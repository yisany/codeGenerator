<form action="/${classInfoDTO.className?uncap_first}/save">

    <#if classInfoDTO.fieldList?exists && classInfoDTO.fieldList?size gt 0>
        <#list classInfoDTO.fieldList as fieldItem >
            <div class="form-group">
                <label for="${fieldItem.fieldName}Label">${fieldItem.fieldComment}</label>
                <input type="input" class="form-control" id="${fieldItem.fieldName}" name="${fieldItem.fieldName}" placeholder="请输入${fieldItem.fieldComment}">
            </div>
        </#list>
    </#if>

    <button type="submit" class="btn btn-primary">保存</button>
</form>
