package com.yis.generator.parse.impl;

import com.alibaba.druid.sql.SQLUtils;
import com.alibaba.druid.sql.ast.SQLObject;
import com.alibaba.druid.sql.ast.SQLStatement;
import com.alibaba.druid.sql.ast.expr.SQLCharExpr;
import com.alibaba.druid.sql.ast.expr.SQLIdentifierExpr;
import com.alibaba.druid.sql.ast.statement.SQLCommentStatement;
import com.alibaba.druid.sql.ast.statement.SQLExprTableSource;
import com.alibaba.druid.sql.ast.statement.SQLPrimaryKey;
import com.alibaba.druid.sql.ast.statement.SQLTableElement;
import com.alibaba.druid.sql.dialect.mysql.ast.statement.MySqlCreateTableStatement;
import com.alibaba.druid.sql.dialect.oracle.ast.stmt.OracleCreateTableStatement;
import com.alibaba.druid.sql.dialect.oracle.visitor.OracleSchemaStatVisitor;
import com.alibaba.druid.sql.visitor.SchemaStatVisitor;
import com.alibaba.druid.stat.TableStat;
import com.alibaba.druid.util.JdbcConstants;
import com.yis.generator.entity.dto.ClassInfoDTO;
import com.yis.generator.entity.dto.FieldInfoDTO;
import com.yis.generator.entity.param.InfoParam;
import com.yis.generator.entity.template.DataTypeMap;
import com.yis.generator.parse.TableParseStrategy;
import com.yis.generator.parse.visitor.MysqlTableSchemaStatVisitor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import java.lang.reflect.Field;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author by yisany on 2020/05/14
 */
@Slf4j
@Component("sql")
public class SqlTableParse implements TableParseStrategy {

    private static final Pattern linePattern = Pattern.compile("_(\\w)");

    @Override
    public ClassInfoDTO process(InfoParam infoParam) {
        ClassInfoDTO info;
        // 需要支持mysql, sqlserver, oracle
        switch (infoParam.getDatabaseType()) {
            case JdbcConstants.MYSQL:
                info = handleMysql(infoParam);
                break;
            case JdbcConstants.ORACLE:
                info = handleOracle(infoParam);
                break;
            default:
                info = new ClassInfoDTO();
                break;
        }
        return info;
    }

    /**
     * oracle sql处理
     */
    private ClassInfoDTO handleOracle(InfoParam infoParam) {
        String tableSql = infoParam.getTableSql();
        boolean annotationFlag = tableSql.contains("comment on ");
        String createSql;
        String commentSqls = "";
        if (annotationFlag) {
            int index = tableSql.indexOf("comment on ");
            createSql = tableSql.substring(0, index);
            commentSqls = tableSql.substring(index);
        } else {
            createSql = tableSql;
        }

        // 处理注释
        String tableComment = null;
        // columnName -> comment
        Map<String, String> nameAndCommentMap = new HashMap<>();
        if (StringUtils.isNotBlank(commentSqls)) {
            String[] commentSqlList = commentSqls.split(";");
            for (String commentSql : commentSqlList) {
                SQLCommentStatement commentStat = (SQLCommentStatement) getSQLStatement(commentSql, JdbcConstants.ORACLE);
                String comment = dealWithName(commentStat.getComment().toString());
                SQLCommentStatement.Type type = commentStat.getType();
                if (SQLCommentStatement.Type.TABLE == type) {
                    tableComment = comment;
                } else {
                    SQLExprTableSource on = commentStat.getOn();
                    String name = on.getName().toString();
                    String[] ss = name.split("\\.");
                    nameAndCommentMap.put(ss[ss.length - 1], comment);
                }
            }
        }
        // 处理表名, 表字段
        SQLStatement stmt = getSQLStatement(createSql, JdbcConstants.ORACLE);
        OracleCreateTableStatement oracleStmt = (OracleCreateTableStatement) stmt;
        OracleSchemaStatVisitor createVisitor = new OracleSchemaStatVisitor();
        SQLExprTableSource tableSource = oracleStmt.getTableSource();
        SQLObject parent = tableSource.getParent();
        parent.accept(createVisitor);
        // 表名
        String tableName = tableSource.getName().getSimpleName();
        if (tableName.contains(".")) {
            String[] names = tableName.split("\\.");
            tableName = names[names.length - 1];
        }
        // 表字段
        List<FieldInfoDTO> fields = setFieldList(createVisitor, nameAndCommentMap, DataTypeMap.ORACLE_TYPE_MAP);

        return buildClassInfo(stmt, tableName, tableComment, fields);
    }

    /**
     * mysql sql处理
     */
    private ClassInfoDTO handleMysql(InfoParam infoParam) {
        String tableSql = infoParam.getTableSql();
        SQLStatement stmt = getSQLStatement(tableSql, JdbcConstants.MYSQL);

        MySqlCreateTableStatement mysqlStmt = (MySqlCreateTableStatement) stmt;
        MysqlTableSchemaStatVisitor visitor = new MysqlTableSchemaStatVisitor(JdbcConstants.MYSQL);
        mysqlStmt.accept(visitor);

        // 注释
        String tableComment = null;
        // columnName -> comment
        Map<String, String> nameAndCommentMap = new HashMap<>();
        for (Map.Entry<String, String> entry : visitor.getColumnComment().entrySet()) {
            String columnName = dealWithName(entry.getKey());
            String comment = dealWithName(entry.getValue());
            nameAndCommentMap.put(columnName, comment);
        }

        // 表名
        String tableName = null;
        Map<TableStat.Name, TableStat> tables = visitor.getTables();
        for (Map.Entry<TableStat.Name, TableStat> entry : tables.entrySet()) {
            TableStat.Name key = entry.getKey();
            tableName = dealWithName(key.getName());
            if (tableName.contains(".")) {
                String[] names = tableName.split("\\.");
                tableName = names[names.length - 1];
            }
            // 表名注释
            SQLCharExpr cExpr = ((SQLCharExpr) mysqlStmt.getComment());
            tableComment = Objects.isNull(cExpr) ? tableName : dealWithName(cExpr.getText());
        }
        // 表字段
        List<FieldInfoDTO> fields = setFieldList(visitor, nameAndCommentMap, DataTypeMap.MYSQL_TYPE_MAP);

        return buildClassInfo(stmt, tableName, tableComment, fields);
    }

    /**
     * 构建表字段
     */
    private FieldInfoDTO buildField(String columnName, String dataType, String columnComment, Map<String, String> typeMap) {
        if (typeMap.get(dataType.toUpperCase()) == null) {
            throw new RuntimeException("根据数据库类型获取java类型失败，尚未在【TypeMap.RESULT_MAP】中加入映射，数据库类型为:" + dataType);
        }
        String type = typeMap.get(dataType.toUpperCase());
        FieldInfoDTO info = new FieldInfoDTO();
        info.setColumnName(columnName);
        info.setFieldName(lineToHump(columnName));
        info.setFieldClass(type);
        info.setFieldComment(columnComment);
        info.setPrimary(false);
        return info;
    }

    /**
     * 构建表结构
     */
    private ClassInfoDTO buildClassInfo(SQLStatement stmt, String tableName, String tableComment, List<FieldInfoDTO> fields) {
        // 主键
        setPrimaryKey(stmt, fields);

        ClassInfoDTO classInfoDTO = new ClassInfoDTO();
        classInfoDTO.setTableName(tableName);
        classInfoDTO.setClassName(strUpper(lineToHump(tableName)));
        classInfoDTO.setFieldList(fields);
        classInfoDTO.setClassComment(StringUtils.isBlank(tableComment) ? tableName : tableComment);

        return classInfoDTO;
    }

    private SQLStatement getSQLStatement(String sql, String type) {
        List<SQLStatement> sqlStatements = SQLUtils.parseStatements(sql, type);

        if (sqlStatements.size() < 1) {
            log.error("sql parser error");
            throw new RuntimeException("sql解析失败");
        }
        return sqlStatements.get(0);
    }

    /**
     * 设置主键
     */
    private void setPrimaryKey(SQLStatement stmt, List<FieldInfoDTO> fields) {
        String primaryKey = "";
        List<SQLPrimaryKey> primaryKeys = new ArrayList<>();
        try {
            Field tableElementList = stmt.getClass().getSuperclass().getDeclaredField("tableElementList");
            tableElementList.setAccessible(true);
            List<SQLTableElement> sqlTableElements = (List<SQLTableElement>) tableElementList.get(stmt);
            for (SQLTableElement sqlTableElement : sqlTableElements) {
                if (sqlTableElement instanceof SQLPrimaryKey) {
                    primaryKeys.add((SQLPrimaryKey) sqlTableElement);
                }
            }
        } catch (Exception e) {
            log.error("primary key not found");
        }
        if (!primaryKeys.isEmpty()) {
            SQLIdentifierExpr expr = (SQLIdentifierExpr) primaryKeys.get(0).getColumns().get(0).getExpr();
            primaryKey = dealWithName(expr.getName());
        }
        if (StringUtils.isNotBlank(primaryKey)) {
            for (FieldInfoDTO field : fields) {
                if (primaryKey.equals(field.getColumnName())) {
                    field.setPrimary(true);
                }
            }
        }
    }

    /**
     * 设置字段属性
     */
    private List<FieldInfoDTO> setFieldList(SchemaStatVisitor visitor, Map<String, String> nameAndCommentMap, Map<String, String> typeMap) {
        List<FieldInfoDTO> fields = new ArrayList<>();
        Collection<TableStat.Column> columns = visitor.getColumns();
        for (TableStat.Column column : columns) {
            String columnName = dealWithName(column.getName());
            String dataType = column.getDataType();
            String columnComment = nameAndCommentMap.getOrDefault(columnName, columnName);
            fields.add(buildField(columnName, dataType, columnComment, typeMap));
        }
        return fields;
    }

    /**
     * 去掉某些字符
     * @param str
     * @return
     */
    private String dealWithName(String str) {
        if (str.contains("`")) {
            str = str.replaceAll("`", "");
        }
        if (str.contains("'")) {
            str = str.replaceAll("'", "");
        }
        return str;
    }

    /**
     * 下划线转驼峰
     */
    private String lineToHump(String str) {
        str = str.toLowerCase();
        Matcher matcher = linePattern.matcher(str);
        StringBuffer sb = new StringBuffer();
        while (matcher.find()) {
            matcher.appendReplacement(sb, matcher.group(1).toUpperCase());
        }
        matcher.appendTail(sb);
        return sb.toString();
    }

    /**
     * 首字母大写
     */
    private String strUpper(String str) {
        char[] cs = str.toCharArray();
        cs[0] -= 32;
        return String.valueOf(cs);
    }
}
