/**
* ${classInfoDTO.classComment}对象Get Set
* @author ${authorName} ${.now?string('yyyy-MM-dd')}
*/

<#if classInfoDTO.fieldList?exists && classInfoDTO.fieldList?size gt 0>
<#list classInfoDTO.fieldList as fieldItem>
// ${fieldItem.fieldComment}
${fieldItem.fieldClass} ${fieldItem.fieldName} = ${classInfoDTO.className?uncap_first}.get${fieldItem.fieldName?cap_first}();
</#list>

<#list classInfoDTO.fieldList as fieldItem>
// ${fieldItem.fieldComment}
${classInfoDTO.className?uncap_first}.set${fieldItem.fieldName?cap_first}();
</#list>

<#list classInfoDTO.fieldList as fieldItem>
// ${fieldItem.fieldComment}
${classInfoDTO.className?uncap_first}.set${fieldItem.fieldName?cap_first}(${classInfoDTO.className?uncap_first}2.get${fieldItem.fieldName?cap_first}(););
</#list>
</#if>
