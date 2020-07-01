import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
* @author by ${authorName} on ${.now?string('yyyy-MM-dd')}
*/
@Repository
public class ${classInfoDTO.className}DaoImpl implements I${classInfoDTO.className}Dao{

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public int add(${classInfoDTO.className} ${classInfoDTO.className?uncap_first}) {
        return jdbcTemplate.update("insert into ${classInfoDTO.tableName}  (<#if classInfoDTO.fieldList?exists && classInfoDTO.fieldList?size gt 0><#list classInfoDTO.fieldList as fieldItem >${fieldItem.columnName}<#if fieldItem_has_next>,</#if></#list></#if> ) values (<#if classInfoDTO.fieldList?exists && classInfoDTO.fieldList?size gt 0><#list classInfoDTO.fieldList as fieldItem >?<#if fieldItem_has_next>,</#if></#list></#if> )",
        <#if classInfoDTO.fieldList?exists && classInfoDTO.fieldList?size gt 0><#list classInfoDTO.fieldList as fieldItem >${classInfoDTO.className?uncap_first}.get${fieldItem.fieldName?cap_first}()<#if fieldItem_has_next>,</#if></#list></#if>);
    }

    @Override
    public int update(${classInfoDTO.className} ${classInfoDTO.className?uncap_first}) {
        return jdbcTemplate.update("UPDATE  ${classInfoDTO.tableName}  SET <#if classInfoDTO.fieldList?exists && classInfoDTO.fieldList?size gt 0><#list classInfoDTO.fieldList as fieldItem ><#if fieldItem_index gt 0 >${fieldItem.columnName}=?<#if fieldItem_has_next>,</#if></#if></#list></#if>"
        +" where <#if classInfoDTO.fieldList?exists && classInfoDTO.fieldList?size gt 0><#list classInfoDTO.fieldList as fieldItem ><#if fieldItem_index = 0>${fieldItem.columnName}=?<#break ></#if></#list></#if>",
        <#if classInfoDTO.fieldList?exists && classInfoDTO.fieldList?size gt 0>
            <#list classInfoDTO.fieldList as fieldItem ><#if fieldItem_index gt 0 >${classInfoDTO.className?uncap_first}.get${fieldItem.fieldName?cap_first}(),</#if></#list>
            <#list classInfoDTO.fieldList as fieldItem ><#if fieldItem_index = 0 >${classInfoDTO.className?uncap_first}.get${fieldItem.fieldName?cap_first}()</#if></#list>
        </#if>;
    }

    @Override
    public int delete(int id) {
        return jdbcTemplate.update("DELETE from ${classInfoDTO.tableName} where <#if classInfoDTO.fieldList?exists && classInfoDTO.fieldList?size gt 0><#list classInfoDTO.fieldList as fieldItem ><#if fieldItem_index = 0>${fieldItem.columnName}=?<#break ></#if></#list></#if>",id);
    }

    @Override
    public ${classInfoDTO.className} findById(int id) {
        List<${classInfoDTO.className}> list = jdbcTemplate.query("select * from ${classInfoDTO.tableName} where <#if classInfoDTO.fieldList?exists && classInfoDTO.fieldList?size gt 0><#list classInfoDTO.fieldList as fieldItem ><#if fieldItem_index = 0>${fieldItem.columnName}=?<#break ></#if></#list></#if>", new Object[]{id}, new BeanPropertyRowMapper<${classInfoDTO.className}>(${classInfoDTO.className}.class));
        if(list!=null && list.size()>0){
            ${classInfoDTO.className} ${classInfoDTO.className?uncap_first} = list.get(0);
            return ${classInfoDTO.className?uncap_first};
        }else{
             return null;
        }
    }

    @Override
    public List<${classInfoDTO.className}> findAllList(Map<String,Object> params) {
        List<${classInfoDTO.className}> list = jdbcTemplate.query("select * from ${classInfoDTO.tableName}", new Object[]{}, new BeanPropertyRowMapper<${classInfoDTO.className}>(${classInfoDTO.className}.class));
        if(list!=null && list.size()>0){
            return list;
        }else{
            return null;
        }
    }

}
