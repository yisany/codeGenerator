<#if classInfoDTO.fieldList?exists && classInfoDTO.fieldList?size gt 0>
INSERT INTO ${classInfoDTO.tableName} ( <#list classInfoDTO.fieldList as fieldItem >${fieldItem.columnName}<#if fieldItem_has_next>,</#if></#list> )
VALUES
    (
    <#list classInfoDTO.fieldList as fieldItem >
    ''<#if fieldItem_has_next>,</#if>
    </#list>
    );
</#if>
