package ${packageName};

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;
<#if swagger?exists && swagger==true>
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
</#if>

/**
 * @author by ${authorName} on ${.now?string('yyyy-MM-dd')}
 */
@Entity
@Data
@Table(name="${classInfoDTO.tableName}")<#if swagger?exists && swagger==true>
@ApiModel("${classInfoDTO.classComment}")</#if>
public class ${classInfoDTO.className} implements Serializable {

    private static final long serialVersionUID = 1L;

<#if classInfoDTO.fieldList?exists && classInfoDTO.fieldList?size gt 0>
<#list classInfoDTO.fieldList as fieldItem >
    <#if fieldItem.primary?exists && fieldItem.primary==true>
    /**
    * ${fieldItem.fieldComment}
    */
    <#if swagger?exists && swagger==true>
    @ApiModelProperty("${fieldItem.fieldComment}")
    </#if>
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="${fieldItem.columnName}")
    private ${fieldItem.fieldClass} ${fieldItem.fieldName};
    <#else>
    /**
    * ${fieldItem.fieldComment}
    */
    <#if swagger?exists && swagger==true>
    @ApiModelProperty("${fieldItem.fieldComment}")
    </#if>
    @Column(name="${fieldItem.columnName}")
    private ${fieldItem.fieldClass} ${fieldItem.fieldName};
    </#if>

</#list>
    public ${classInfoDTO.className}() {
    }
</#if>

}
