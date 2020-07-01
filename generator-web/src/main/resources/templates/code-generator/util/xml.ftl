<!--
 ${classInfoDTO.classComment}对象Get Set
 @author ${authorName} ${.now?string('yyyy-MM-dd')}
-->
<#if classInfoDTO.fieldList?exists && classInfoDTO.fieldList?size gt 0>
<${classInfoDTO.className}>
<#list classInfoDTO.fieldList as fieldItem>
 <${fieldItem.fieldName}></${fieldItem.fieldName}>
</#list>
</${classInfoDTO.className}>
</#if>
