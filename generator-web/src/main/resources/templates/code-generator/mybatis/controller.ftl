import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
* @author by ${authorName} on ${.now?string('yyyy-MM-dd')}
*/
@RestController
@RequestMapping(value = "/${classInfoDTO.className}")
public class ${classInfoDTO.className}Controller {

    @Resource
    private ${classInfoDTO.className}Service ${classInfoDTO.className?uncap_first}Service;

    /**
    * 新增
    * @author ${authorName}
    * @date ${.now?string('yyyy/MM/dd')}
    **/
    @RequestMapping("/insert")
    public ReturnT<String> insert(${classInfoDTO.className} ${classInfoDTO.className?uncap_first}){
        return ${classInfoDTO.className?uncap_first}Service.insert(${classInfoDTO.className?uncap_first});
    }

    /**
    * 刪除
    * @author ${authorName}
    * @date ${.now?string('yyyy/MM/dd')}
    **/
    @RequestMapping("/delete")
    public ReturnT<String> delete(int id){
        return ${classInfoDTO.className?uncap_first}Service.delete(id);
    }

    /**
    * 更新
    * @author ${authorName}
    * @date ${.now?string('yyyy/MM/dd')}
    **/
    @RequestMapping("/update")
    public ReturnT<String> update(${classInfoDTO.className} ${classInfoDTO.className?uncap_first}){
        return ${classInfoDTO.className?uncap_first}Service.update(${classInfoDTO.className?uncap_first});
    }

    /**
    * 查询 根据主键 id 查询
    * @author ${authorName}
    * @date ${.now?string('yyyy/MM/dd')}
    **/
    @RequestMapping("/load")
    public ReturnT<String> load(int id){
        return ${classInfoDTO.className?uncap_first}Service.load(id);
    }

    /**
    * 查询 分页查询
    * @author ${authorName}
    * @date ${.now?string('yyyy/MM/dd')}
    **/
    @RequestMapping("/pageList")
    public Map<String, Object> pageList(@RequestParam(required = false, defaultValue = "0") int offset,
                                        @RequestParam(required = false, defaultValue = "10") int pagesize) {
        return ${classInfoDTO.className?uncap_first}Service.pageList(offset, pagesize);
    }

}
