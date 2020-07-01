<#if classInfoDTO.fieldList?exists && classInfoDTO.fieldList?size gt 0>
UPDATE ${classInfoDTO.tableName}
SET
<#list classInfoDTO.fieldList as fieldItem >
    ${fieldItem.columnName} = ''<#if fieldItem_has_next>,</#if>
</#list>
WHERE
<#list classInfoDTO.fieldList as fieldItem >
    ${fieldItem.columnName} = ''<#if fieldItem_has_next>,</#if>
</#list>;
</#if>
