<#if classInfoDTO.fieldList?exists && classInfoDTO.fieldList?size gt 0>
DELETE
FROM
    ${classInfoDTO.tableName}
WHERE
<#list classInfoDTO.fieldList as fieldItem >
    ${fieldItem.columnName} = ''<#if fieldItem_has_next>,</#if>
</#list>;
</#if>
