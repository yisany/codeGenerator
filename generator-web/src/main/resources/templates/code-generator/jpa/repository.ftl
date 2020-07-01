package ${packageName}.repository;
import ${packageName}.entity.${classInfoDTO.className};

<#if classInfoDTO.fieldList?exists && classInfoDTO.fieldList?size gt 0>
    <#list classInfoDTO.fieldList as fieldItem >
        <#if fieldItem.fieldClass == "Date">
            <#assign importDdate = true />
        </#if>
    </#list>
</#if>
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

/**
* @author by ${authorName} on ${.now?string('yyyy-MM-dd')}
*/
@Repository
public interface ${classInfoDTO.className}Repository extends JpaRepository<${classInfoDTO.className},Integer>, JpaSpecificationExecutor<${classInfoDTO.className}> {



}
