package com.yis.generator.entity.dto;

import lombok.Data;

/**
 * 字段信息
 *
 * @author xuxueli 2018-05-02 20:11:05
 */
@Data
public class FieldInfoDTO {

    // 数据库字段名
    private String columnName;
    // 类字段名
    private String fieldName;
    // 类字段类型
    private String fieldClass;
    // 类字段注释
    private String fieldComment;
    // 是否为主键
    private boolean primary;

}
