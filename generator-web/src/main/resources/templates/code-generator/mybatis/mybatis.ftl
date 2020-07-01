<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${packageName}.dao.${classInfoDTO.className}Dao">

    <resultMap id="BaseResultMap" type="${packageName}.entity.${classInfoDTO.className}Entity" >
        <#if classInfoDTO.fieldList?exists && classInfoDTO.fieldList?size gt 0>
            <#list classInfoDTO.fieldList as fieldItem >
                <result column="${fieldItem.columnName}" property="${fieldItem.fieldName}" />
            </#list>
        </#if>
    </resultMap>

    <sql id="Base_Column_List">
        <#if classInfoDTO.fieldList?exists && classInfoDTO.fieldList?size gt 0>
            <#list classInfoDTO.fieldList as fieldItem >
                ${fieldItem.columnName}<#if fieldItem_has_next>,</#if>
            </#list>
        </#if>
    </sql>

    <insert id="insert" useGeneratedKeys="true" keyColumn="id" keyProperty="id" parameterType="${packageName}.entity.${classInfoDTO.className}Entity">
        INSERT INTO ${classInfoDTO.tableName}
        <trim prefix="(" suffix=")" suffixOverrides=",">
            <#if classInfoDTO.fieldList?exists && classInfoDTO.fieldList?size gt 0>
                <#list classInfoDTO.fieldList as fieldItem >
                    <#if fieldItem.columnName != "id" >
                        ${r"<if test ='null != "}${fieldItem.fieldName}${r"'>"}
                        ${fieldItem.columnName}<#if fieldItem_has_next>,</#if>
                        ${r"</if>"}
                    </#if>
                </#list>
            </#if>
        </trim>
        <trim prefix="values (" suffix=")" suffixOverrides=",">
            <#if classInfoDTO.fieldList?exists && classInfoDTO.fieldList?size gt 0>
                <#list classInfoDTO.fieldList as fieldItem >
                    <#if fieldItem.columnName != "id" >
                    <#--<#if fieldItem.columnName="addtime" || fieldItem.columnName="updatetime" >
                    ${r"<if test ='null != "}${fieldItem.fieldName}${r"'>"}
                        NOW()<#if fieldItem_has_next>,</#if>
                    ${r"</if>"}
                    <#else>-->
                        ${r"<if test ='null != "}${fieldItem.fieldName}${r"'>"}
                        ${r"#{"}${fieldItem.fieldName}${r"}"}<#if fieldItem_has_next>,</#if>
                        ${r"</if>"}
                    <#--</#if>-->
                    </#if>
                </#list>
            </#if>
        </trim>
    </insert>

    <delete id="delete" >
        DELETE FROM ${classInfoDTO.tableName}
        WHERE id = ${r"#{id}"}
    </delete>

    <update id="update" parameterType="${packageName}.entity.${classInfoDTO.className}Entity">
        UPDATE ${classInfoDTO.tableName}
        <set>
            <#list classInfoDTO.fieldList as fieldItem >
                <#if fieldItem.columnName != "id" && fieldItem.columnName != "AddTime" && fieldItem.columnName != "UpdateTime" >
                    ${r"<if test ='null != "}${fieldItem.fieldName}${r"'>"}${fieldItem.columnName} = ${r"#{"}${fieldItem.fieldName}${r"}"}<#if fieldItem_has_next>,</#if>${r"</if>"}
                </#if>
            </#list>
        </set>
        WHERE id = ${r"#{"}id${r"}"}
    </update>


    <select id="load" resultMap="BaseResultMap">
        SELECT <include refid="Base_Column_List" />
        FROM ${classInfoDTO.tableName}
        WHERE id = ${r"#{id}"}
    </select>

    <select id="pageList" resultMap="BaseResultMap">
        SELECT <include refid="Base_Column_List" />
        FROM ${classInfoDTO.tableName}
        LIMIT ${r"#{offset}"}, ${r"#{pageSize}"}
    </select>

    <select id="pageListCount" resultType="java.lang.Integer">
        SELECT count(1)
        FROM ${classInfoDTO.tableName}
    </select>

</mapper>