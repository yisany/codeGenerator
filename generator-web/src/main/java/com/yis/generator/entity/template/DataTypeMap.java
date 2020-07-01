package com.yis.generator.entity.template;

import java.util.HashMap;
import java.util.Map;

/**
 * @author by yisany on 2020/05/19
 */
public class DataTypeMap {

    public static final Map<String, String> MYSQL_TYPE_MAP = new HashMap<String, String>() {{
        put("CHAR", "String");
        put("VARCHAR", "String");
        put("TEXT", "String");
        put("LONGVARCHAR", "String");
        put("NUMERIC", "java.math.BigDecimal");
        put("DECIMAL", "java.math.BigDecimal");
        put("BIT", "Boolean");
        put("TINYINT", "Boolean");
        put("SMALLINT", "Short");
        put("INT", "Integer");
        put("INTEGER", "Integer");
        put("INT UNSIGNED", "Integer");
        put("MEDIUMINT", "Integer");
        put("BIGINT", "Long");
        put("REAL", "Float");
        put("FLOAT", "Double");
        put("DOUBLE", "Double");
        put("BINARY", "Byte []");
        put("VARBINARY", "Byte []");
        put("DATE", "java.util.Date");
        put("DATETIME", "java.util.Date");
        put("TIMESTAMP", "java.util.Date");
    }};

    public static final Map<String, String> ORACLE_TYPE_MAP = new HashMap<String, String>() {{
        put("CHAR", "String");
        put("VARCHAR2", "String");
        put("NUMBER", "Long");
        put("DATE", "java.util.Date");
        put("TIMESTAMP", "java.util.Date");
        put("BLOB", "Object");
    }};

}
