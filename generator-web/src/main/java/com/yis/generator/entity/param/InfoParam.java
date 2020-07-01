package com.yis.generator.entity.param;

import lombok.Data;

/**
 * Post data - InfoParam
 * @author zhengkai.blog.csdn.net
 */
@Data
public class InfoParam {
    private String tableSql;
    private String authorName;
    private String packageName;
    private String returnUtil;
    private String nameCaseType;
    private String tinyintTransType;
    private String dataType;
    private String databaseType;
    private boolean swagger;

    @Data
    public static class NAME_CASE_TYPE{
        public static String CAMEL_CASE="CamelCase";
        public static String UNDER_SCORE_CASE="UnderScoreCase";
        public static String UPPER_UNDER_SCORE_CASE="UpperUnderScoreCase";
    }
}
