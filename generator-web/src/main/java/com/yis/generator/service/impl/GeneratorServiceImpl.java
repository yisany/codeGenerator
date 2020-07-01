package com.yis.generator.service.impl;

import com.google.common.base.Throwables;
import com.yis.generator.entity.template.TemplateMap;
import com.yis.generator.entity.dto.ClassInfoDTO;
import com.yis.generator.entity.param.InfoParam;
import com.yis.generator.entity.ReturnT;
import com.yis.generator.parse.TableParseFactory;
import com.yis.generator.parse.TableParseStrategy;
import com.yis.generator.service.GeneratorService;
import com.yis.generator.util.FreemarkerTool;
import freemarker.template.TemplateException;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

/**
 * GeneratorService
 * @author zhengkai.blog.csdn.net
 */
@Slf4j
@Service
public class GeneratorServiceImpl implements GeneratorService {

    @Autowired
    private FreemarkerTool freemarkerTool;
    @Autowired
    private TableParseFactory tableParseFactory;

    @Override
    public ReturnT<Map<String, String>> generator(InfoParam infoParam) {
        try {
            if (StringUtils.isBlank(infoParam.getTableSql())) {
                return new ReturnT<>(ReturnT.FAIL_CODE, "表结构信息不可为空");
            }
            // parse table
            TableParseStrategy strategy = tableParseFactory.getStrategy(infoParam.getDataType());
            ClassInfoDTO classInfoDTO = strategy.process(infoParam);

            // process the param
            Map<String, Object> params = new HashMap<>();
            params.put("classInfoDTO", classInfoDTO);
            params.put("tableName", classInfoDTO == null ? System.currentTimeMillis() : classInfoDTO.getTableName());
            params.put("authorName", infoParam.getAuthorName());
            params.put("packageName", infoParam.getPackageName());
            params.put("returnUtil", infoParam.getReturnUtil());
            params.put("swagger", infoParam.isSwagger());
            log.info("generator table: {}, field size: {}.",
                    classInfoDTO == null ? "" : classInfoDTO.getTableName(),
                    (classInfoDTO == null || classInfoDTO.getFieldList() == null) ? "" : classInfoDTO.getFieldList().size()
            );

            // generate the template
            Map<String, String> result = getResultByParams(params);

            return new ReturnT<>(result);
        } catch (TemplateException e) {
            log.error("generator code error, template fail, e={}", Throwables.getStackTraceAsString(e));
            return new ReturnT<>(ReturnT.FAIL_CODE, e.getMessage());
        } catch (IOException e) {
            log.error("generator code error, io fail, e={}", Throwables.getStackTraceAsString(e));
            return new ReturnT<>(ReturnT.FAIL_CODE, e.getMessage());
        }
    }

    private Map<String, String> getResultByParams(Map<String, Object> params) throws IOException, TemplateException {
        Map<String, String> result = new HashMap<>();
        result.put("tableName",params.get("tableName").toString());

        for (Map.Entry<String, Set<String>> entry : TemplateMap.TEMPLATE_MAPS.entrySet()) {
            String type = entry.getKey();
            for (String name : entry.getValue()) {
                String key = type + "-" + name;
                String path = String.format(TemplateMap.TEMPLATE_PATH, TemplateMap.TEMPLATE_PREFIX, type, name, TemplateMap.TEMPLATE_SUFFIX);
                result.put("bean".equals(type) ? name : key, freemarkerTool.processString(path, params));
            }
        }

        return result;
    }
}
