sample
===

select #use("cols")# from ${classInfoDTO.tableName} where #use("condition")#

cols
===
<#if classInfoDTO.fieldList?exists && classInfoDTO.fieldList?size gt 0>
    <#list classInfoDTO.fieldList as fieldItem >
        `${fieldItem.columnName}`<#if fieldItem_has_next>,</#if>
    </#list>
</#if>

updateSample
===
<#if classInfoDTO.fieldList?exists && classInfoDTO.fieldList?size gt 0>
    <#list classInfoDTO.fieldList as fieldItem >
        `${fieldItem.columnName}=#${fieldItem.fieldName}#`<#if fieldItem_has_next>,</#if>
    </#list>
</#if>

condition
===
    1 = 1
<#if classInfoDTO.fieldList?exists && classInfoDTO.fieldList?size gt 0>
    <#list classInfoDTO.fieldList as fieldItem >
    @if(!isEmpty(${fieldItem.fieldName})){
      and `${fieldItem.columnName}`=#${fieldItem.fieldName}#
    @}
    </#list>
</#if>
