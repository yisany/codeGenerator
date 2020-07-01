package com.yis.generator.parse.impl;

import com.yis.generator.entity.dto.ClassInfoDTO;
import com.yis.generator.entity.dto.FieldInfoDTO;
import com.yis.generator.entity.param.InfoParam;
import com.yis.generator.parse.TableParseStrategy;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author by yisany on 2020/05/14
 */
@Component("sql-regex")
public class SqlRegexTableParse implements TableParseStrategy {
    @Override
    public ClassInfoDTO process(InfoParam infoParam) {
        // field List
        List<FieldInfoDTO> fieldList = new ArrayList<FieldInfoDTO>();
        //return classInfo
        ClassInfoDTO codeJavaInfo = new ClassInfoDTO();

        //匹配整个ddl，将ddl分为表名，列sql部分，表注释
        String DDL_PATTEN_STR = "\\s*create\\s+table\\s+(?<tableName>\\S+)[^\\(]*\\((?<columnsSQL>[\\s\\S]+)\\)[^\\)]+?(comment\\s*(=|on\\s+table)\\s*'(?<tableComment>.*?)'\\s*;?)?$";

        Pattern DDL_PATTERN = Pattern.compile(DDL_PATTEN_STR, Pattern.CASE_INSENSITIVE);

        //匹配列sql部分，分别解析每一列的列名 类型 和列注释
        String COL_PATTERN_STR = "\\s*(?<fieldName>\\S+)\\s+(?<fieldType>\\w+)\\s*(?:\\([\\s\\d,]+\\))?((?!comment).)*(comment\\s*'(?<fieldComment>.*?)')?\\s*(,|$)";

        Pattern COL_PATTERN = Pattern.compile(COL_PATTERN_STR, Pattern.CASE_INSENSITIVE);

        Matcher matcher = DDL_PATTERN.matcher(infoParam.getTableSql().trim());
        if (matcher.find()) {
            String tableName = matcher.group("tableName");
            String tableComment = matcher.group("tableComment");
            codeJavaInfo.setTableName(tableName.replaceAll("'", ""));
            codeJavaInfo.setClassName(tableName.replaceAll("'", ""));
            codeJavaInfo.setClassComment(tableComment.replaceAll("'", ""));
            String columnsSQL = matcher.group("columnsSQL");
            if (columnsSQL != null && columnsSQL.length() > 0) {
                Matcher colMatcher = COL_PATTERN.matcher(columnsSQL);
                while (colMatcher.find()) {
                    String fieldName = colMatcher.group("fieldName");
                    String fieldType = colMatcher.group("fieldType");
                    String fieldComment = colMatcher.group("fieldComment");
                    if (!"key".equalsIgnoreCase(fieldType)) {
                        FieldInfoDTO fieldInfoDTO = new FieldInfoDTO();
                        fieldInfoDTO.setFieldName(fieldName.replaceAll("'", ""));
                        fieldInfoDTO.setColumnName(fieldName.replaceAll("'", ""));
                        fieldInfoDTO.setFieldClass(fieldType.replaceAll("'", ""));
                        fieldInfoDTO.setFieldComment(fieldComment.replaceAll("'", ""));
                        fieldList.add(fieldInfoDTO);
                    }
                }
            }
            codeJavaInfo.setFieldList(fieldList);
        }
        return codeJavaInfo;
    }
}
