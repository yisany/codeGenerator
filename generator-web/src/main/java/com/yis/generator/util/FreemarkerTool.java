package com.yis.generator.util;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.io.StringWriter;
import java.util.Map;

/**
 * freemarker tool
 *
 * @author xuxueli 2018-05-02 19:56:00
 */
@Slf4j
@Component
public class FreemarkerTool {

    @Autowired
    private Configuration configuration;

    /**
     * process Template Into String
     */
    public String processTemplateIntoString(Template template, Object model) throws IOException, TemplateException {
        StringWriter result = new StringWriter();
        template.process(model, result);
        return result.toString();
    }

    /**
     * 传入需要转义的字符串进行转义
     */
    public String escapeString(String originStr) {
        return originStr.replaceAll("井", "\\#").replaceAll("￥", "\\$");
    }

    /**
     * process String
     *
     * @param templateName 路径
     * @param params       数据
     */
    public String processString(String templateName, Map<String, Object> params) throws IOException, TemplateException {
        //获取对应的模板
        Template template = configuration.getTemplate(templateName);
        //处理为template并进行转义
        return escapeString(processTemplateIntoString(template, params));
    }


}
