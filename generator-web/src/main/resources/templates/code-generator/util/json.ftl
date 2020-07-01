<#if classInfoDTO.fieldList?exists && classInfoDTO.fieldList?size gt 0>
{
<#list classInfoDTO.fieldList as fieldItem>
 "${fieldItem.fieldName}":""<#if fieldItem_has_next>,</#if>
</#list>
}
</#if>
