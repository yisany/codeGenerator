package ${packageName}.entity;

import lombok.Data;
import java.util.Date;
import java.util.List;
import java.io.Serializable;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;

/**
* @author by ${authorName} on ${.now?string('yyyy-MM-dd')}
*/
@Data
<#if swagger?exists && swagger==true>@ApiModel("${classInfoDTO.classComment}")</#if>
public class ${classInfoDTO.className} implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(type = IdType.AUTO)
<#if classInfoDTO.fieldList?exists && classInfoDTO.fieldList?size gt 0>
<#list classInfoDTO.fieldList as fieldItem >
    /**
    * ${fieldItem.fieldComment}
    */<#if swagger?exists && swagger==true>
    @ApiModelProperty("${fieldItem.fieldComment}")</#if>
    private ${fieldItem.fieldClass} ${fieldItem.fieldName};

</#list>
    public ${classInfoDTO.className}() {
    }
</#if>

}
