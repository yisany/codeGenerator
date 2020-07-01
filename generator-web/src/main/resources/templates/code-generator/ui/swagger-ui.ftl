@ApiOperation(value = "${classInfoDTO.classComment}", notes = "${classInfoDTO.classComment}")
    @ApiImplicitParams({
            <#if classInfoDTO.fieldList?exists && classInfoDTO.fieldList?size gt 0>
                <#list classInfoDTO.fieldList as fieldItem >
                @ApiImplicitParam(name = "${fieldItem.fieldName}", value = "${fieldItem.fieldComment}", required = false, dataType = "${fieldItem.fieldClass}")<#if fieldItem_has_next>,</#if>
                </#list>
            </#if>
    }
    )
