package com.yis.generator.entity.template;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

/**
 * @author by yisany on 2020/06/28
 */
public class TemplateMap {

    public static final String TEMPLATE_PATH = "%s/%s/%s.%s";
    public static final String TEMPLATE_PREFIX = "code-generator";
    public static final String TEMPLATE_SUFFIX = "ftl";

    public static final Map<String, Set<String>> TEMPLATE_MAPS = new HashMap<String, Set<String>>(){{
        put("bean", new HashSet<String>() {{
            add("model");
            add("entity");
        }});
        put("ui", new HashSet<String>() {{
            add("swagger-ui");
            add("element-ui");
            add("bootstrap-ui");
            add("layui-edit");
            add("layui-list");
        }});
        put("mybatis", new HashSet<String>() {{
            add("controller");
            add("service");
            add("service_impl");
            add("mapper");
            add("mybatis");
        }});
        put("mybatisPlus", new HashSet<String>() {{
            add("pluscontroller");
            add("plusmapper");
            add("plusentity");
        }});
        put("jpa", new HashSet<String>() {{
            add("entity");
            add("repository");
            add("jpacontroller");
        }});
        put("jdbcTemplate", new HashSet<String>() {{
            add("jtdao");
            add("jtdaoimpl");
        }});
        put("beetlsql", new HashSet<String>() {{
            add("beetlmd");
            add("beetlcontroller");
        }});
        put("util", new HashSet<String>() {{
            add("util");
            add("json");
            add("xml");
        }});
        put("sql", new HashSet<String>() {{
            add("select");
            add("insert");
            add("update");
            add("delete");
        }});
    }};

}
