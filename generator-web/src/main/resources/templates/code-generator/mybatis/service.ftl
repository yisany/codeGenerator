import java.util.Map;

/**
* @author by ${authorName} on ${.now?string('yyyy-MM-dd')}
*/
public interface ${classInfoDTO.className}Service {

    /**
    * 新增
    */
    public ReturnT<String> insert(${classInfoDTO.className} ${classInfoDTO.className?uncap_first});

    /**
    * 删除
    */
    public ReturnT<String> delete(int id);

    /**
    * 更新
    */
    public ReturnT<String> update(${classInfoDTO.className} ${classInfoDTO.className?uncap_first});

    /**
    * 根据主键 id 查询
    */
    public ${classInfoDTO.className} load(int id);

    /**
    * 分页查询
    */
    public Map<String,Object> pageList(int offset, int pagesize);

}
