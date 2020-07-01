import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
* @author by ${authorName} on ${.now?string('yyyy-MM-dd')}
*/
public class ${classInfoDTO.className} implements Serializable {

    private static final long serialVersionUID = 1L;

<#if classInfoDTO.fieldList?exists && classInfoDTO.fieldList?size gt 0>
<#list classInfoDTO.fieldList as fieldItem >
    /**
    * ${fieldItem.fieldComment}
    */
    private ${fieldItem.fieldClass} ${fieldItem.fieldName};

</#list>
</#if>

<#if classInfoDTO.fieldList?exists && classInfoDTO.fieldList?size gt 0>
    public ${classInfoDTO.className}() {
    }

<#list classInfoDTO.fieldList as fieldItem>
    public ${fieldItem.fieldClass} get${fieldItem.fieldName?cap_first}() {
        return ${fieldItem.fieldName};
    }

    public void set${fieldItem.fieldName?cap_first}(${fieldItem.fieldClass} ${fieldItem.fieldName}) {
        this.${fieldItem.fieldName} = ${fieldItem.fieldName};
    }

</#list>
</#if>
}
