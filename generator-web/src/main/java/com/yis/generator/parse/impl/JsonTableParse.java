package com.yis.generator.parse.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.yis.generator.entity.dto.ClassInfoDTO;
import com.yis.generator.entity.dto.FieldInfoDTO;
import com.yis.generator.entity.param.InfoParam;
import com.yis.generator.parse.TableParseStrategy;
import com.yis.generator.config.CodeGenerateException;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

/**
 * @author by yisany on 2020/05/14
 */
@Component("json")
public class JsonTableParse implements TableParseStrategy {
    @Override
    public ClassInfoDTO process(InfoParam infoParam) {
        ClassInfoDTO codeJavaInfo = new ClassInfoDTO();
        codeJavaInfo.setTableName("JsonDto");
        codeJavaInfo.setClassName("JsonDto");
        codeJavaInfo.setClassComment("JsonDto");

        //support children json if forget to add '{' in front of json
        if (infoParam.getTableSql().trim().startsWith("\"")) {
            infoParam.setTableSql("{" + infoParam.getTableSql());
        }
        if (JSON.isValid(infoParam.getTableSql())) {
            if (infoParam.getTableSql().trim().startsWith("{")) {
                JSONObject jsonObject = JSONObject.parseObject(infoParam.getTableSql().trim());
                //parse FieldList by JSONObject
                codeJavaInfo.setFieldList(processJsonObjectToFieldList(jsonObject));
            } else if (infoParam.getTableSql().trim().startsWith("[")) {
                JSONArray jsonArray = JSONArray.parseArray(infoParam.getTableSql().trim());
                //parse FieldList by JSONObject
                codeJavaInfo.setFieldList(processJsonObjectToFieldList(jsonArray.getJSONObject(0)));
            }
        }

        return codeJavaInfo;
    }

    private List<FieldInfoDTO> processJsonObjectToFieldList(JSONObject jsonObject) {
        // field List
        List<FieldInfoDTO> fieldList = new ArrayList<FieldInfoDTO>();
        jsonObject.keySet().stream().forEach(jsonField -> {
            FieldInfoDTO fieldInfoDTO = new FieldInfoDTO();
            fieldInfoDTO.setFieldName(jsonField);
            fieldInfoDTO.setColumnName(jsonField);
            fieldInfoDTO.setFieldClass(String.class.getSimpleName());
            fieldInfoDTO.setFieldComment("father:" + jsonField);
            fieldList.add(fieldInfoDTO);
            if (jsonObject.get(jsonField) instanceof JSONArray) {
                jsonObject.getJSONArray(jsonField).stream().forEach(arrayObject -> {
                    FieldInfoDTO fieldInfoDTO2 = new FieldInfoDTO();
                    fieldInfoDTO2.setFieldName(arrayObject.toString());
                    fieldInfoDTO2.setColumnName(arrayObject.toString());
                    fieldInfoDTO2.setFieldClass(String.class.getSimpleName());
                    fieldInfoDTO2.setFieldComment("children:" + arrayObject.toString());
                    fieldList.add(fieldInfoDTO2);
                });
            } else if (jsonObject.get(jsonField) instanceof JSONObject) {
                jsonObject.getJSONObject(jsonField).keySet().stream().forEach(arrayObject -> {
                    FieldInfoDTO fieldInfoDTO2 = new FieldInfoDTO();
                    fieldInfoDTO2.setFieldName(arrayObject.toString());
                    fieldInfoDTO2.setColumnName(arrayObject.toString());
                    fieldInfoDTO2.setFieldClass(String.class.getSimpleName());
                    fieldInfoDTO2.setFieldComment("children:" + arrayObject.toString());
                    fieldList.add(fieldInfoDTO2);
                });
            }
        });
        if (fieldList.size() < 1) {
            throw new CodeGenerateException("JSON解析失败");
        }
        return fieldList;
    }
}
