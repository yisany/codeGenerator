package com.yis.generator.parse.visitor;

import com.alibaba.druid.sql.ast.SQLObject;
import com.alibaba.druid.sql.ast.statement.SQLColumnDefinition;
import com.alibaba.druid.sql.ast.statement.SQLCreateTableStatement;
import com.alibaba.druid.sql.ast.statement.SQLPrimaryKey;
import com.alibaba.druid.sql.ast.statement.SQLUnique;
import com.alibaba.druid.sql.visitor.SchemaStatVisitor;
import com.alibaba.druid.stat.TableStat;
import lombok.Data;
import org.apache.commons.lang3.StringUtils;

import java.util.HashMap;
import java.util.Map;

/**
 * @author by yisany on 2020/06/28
 */
@Data
public class MysqlTableSchemaStatVisitor extends SchemaStatVisitor {

    public MysqlTableSchemaStatVisitor(String type) {
        super(type);
    }

    private Map<String, String> columnComment = new HashMap<>();

    public boolean visit(SQLColumnDefinition x) {
        String tableName = null;
        SQLObject parent = x.getParent();
        if (parent instanceof SQLCreateTableStatement) {
            tableName = ((SQLCreateTableStatement) parent).getName().toString();
        }

        if (tableName == null) {
            return true;
        } else {
            String columnName = x.getName().toString();
            String normalize = normalize(columnName);
            //获取列注释，如果注释为空则使用列名做为注释
            String comment = x.getComment() == null ? normalize : x.getComment().toString();
            columnComment.put(normalize, StringUtils.isBlank(comment) ? normalize : normalize(comment));
            TableStat.Column column = this.addColumn(tableName, columnName);
            if (x.getDataType() != null) {
                column.setDataType(x.getDataType().getName());
            }

            for (Object item : x.getConstraints()) {
                if (item instanceof SQLPrimaryKey) {
                    column.setPrimaryKey(true);
                } else if (item instanceof SQLUnique) {
                    column.setUnique(true);
                }
            }

            return false;
        }
    }

    public static String normalize(String name) {
        if (name == null) {
            return null;
        } else {
            if (name.length() > 2) {
                char c0 = name.charAt(0);
                char x0 = name.charAt(name.length() - 1);
                if (c0 == '"' && x0 == '"' || c0 == '`' && x0 == '`' || c0 == '\'' && x0 == '\'') {
                    String normalizeName = name.substring(1, name.length() - 1);
                    if (c0 == '`') {
                        normalizeName = normalizeName.replaceAll("`\\.`", ".");
                    }
                    return normalizeName;
                }
            }

            return name;
        }
    }

}
