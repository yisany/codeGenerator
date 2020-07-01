package com.yis.generator.entity.dto;

import lombok.Data;

import java.util.List;

/**
 * 类信息
 *
 * @author xuxueli 2018-05-02 20:02:34
 */
@Data
public class ClassInfoDTO {

    // 表名
    private String tableName;
    // 类名
    private String className;
    // 类注释
    private String classComment;
    // 类字段
    private List<FieldInfoDTO> fieldList;

    public ClassInfoDTO() {
    }

    public ClassInfoDTO(String tableName, String className, String classComment, List<FieldInfoDTO> fieldList) {
        this.tableName = tableName;
        this.className = className;
        this.classComment = classComment;
        this.fieldList = fieldList;
    }
}