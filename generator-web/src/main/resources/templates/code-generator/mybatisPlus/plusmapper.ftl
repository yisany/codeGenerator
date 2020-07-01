package ${packageName}.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import ${packageName}.entity.${classInfoDTO.className};

/**
* @author by ${authorName} on ${.now?string('yyyy-MM-dd')}
*/
@Mapper
public interface ${classInfoDTO.className}Mapper extends BaseMapper<${classInfoDTO.className}> {

    @Select(
    "<script>select t0.* from ${classInfoDTO.tableName} t0 " +
    //add here if need left join
    "where 1=1" +
    <#list classInfoDTO.fieldList as fieldItem >
    "<when test='${fieldItem.fieldName}!=null and ${fieldItem.fieldName}!=&apos;&apos; '> and t0.${fieldItem.columnName}=井{${fieldItem.fieldName}}</when> " +
    </#list>
    //add here if need page limit
    //" limit ￥{page},￥{limit} " +
    " </script>")
    List<${classInfoDTO.className}> pageAll(${classInfoDTO.className} queryParamDTO);

    @Select("<script>select count(1) from ${classInfoDTO.tableName} t0 " +
    //add here if need left join
    "where 1=1" +
    <#list classInfoDTO.fieldList as fieldItem >
    "<when test='${fieldItem.fieldName}!=null and ${fieldItem.fieldName}!=&apos;&apos; '> and t0.${fieldItem.columnName}=井{${fieldItem.fieldName}}</when> " +
    </#list>
     " </script>")
    int countAll(${classInfoDTO.className} queryParamDTO);

}
