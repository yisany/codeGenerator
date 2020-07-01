<#if classInfoDTO.fieldList?exists && classInfoDTO.fieldList?size gt 0>
SELECT
<#list classInfoDTO.fieldList as fieldItem >
    ${fieldItem.columnName}<#if fieldItem_has_next>,</#if>
</#list>
FROM
    ${classInfoDTO.tableName}
WHERE
<#list classInfoDTO.fieldList as fieldItem >
    <#if fieldItem_index != 0>AND </#if>${fieldItem.columnName} = ''
</#list>;
</#if>

