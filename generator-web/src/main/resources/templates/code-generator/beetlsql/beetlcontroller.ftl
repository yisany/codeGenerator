import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;
import java.util.Map;

/**
* @author by ${authorName} on ${.now?string('yyyy-MM-dd')}
*/
@RestController
@RequestMapping("/${classInfoDTO.className?uncap_first}")
public class ${classInfoDTO.className}Controller {

    @Autowired
    private SQLManager sqlManager;

    /**
    * 新增或编辑
    */
    @PostMapping("/save")
    public Object save(${classInfoDTO.className} ${classInfoDTO.className?uncap_first}){
        ${classInfoDTO.className} ${classInfoDTO.className?uncap_first}=sqlManager.unique(${classInfoDTO.className}.class,${classInfoDTO.className?uncap_first}.getId());
        if(${classInfoDTO.className?uncap_first}!=null){
            sqlManager.updateById(${classInfoDTO.className?uncap_first});
            return ${returnUtil}.success("编辑成功");
        }else{
            sqlManager.insert(${classInfoDTO.className?uncap_first});
            return ${returnUtil}.error("保存成功");
        }
    }

    /**
    * 删除
    */
    @PostMapping("/delete")
    public Object delete(int id){
        ${classInfoDTO.className} ${classInfoDTO.className?uncap_first}=sqlManager.unique(${classInfoDTO.className}.class,id);
        if(${classInfoDTO.className?uncap_first}!=null){
            sqlManager.deleteById(id);
            return ${returnUtil}.success("删除成功");
        }else{
            return ${returnUtil}.error("没有找到该对象");
        }
    }

    /**
    * 查询
    */
    @PostMapping("/find")
    public Object find(int id){
        ${classInfoDTO.className} ${classInfoDTO.className?uncap_first}=sqlManager.unique(${classInfoDTO.className}.class,id);
        if(${classInfoDTO.className?uncap_first}!=null){
            return ${returnUtil}.success(${classInfoDTO.className?uncap_first});
        }else{
            return ${returnUtil}.error("没有找到该对象");
        }
    }

    /**
    * 分页查询
    */
    @PostMapping("/list")
    public Object list(${classInfoDTO.className} ${classInfoDTO.className?uncap_first},
                        @RequestParam(required = false, defaultValue = "0") int pageNumber,
                        @RequestParam(required = false, defaultValue = "10") int pageSize) {
            List<${classInfoDTO.className}> list = sqlManager.query(${classInfoDTO.className}.class).select();
            return ${returnUtil}.success(list);
    }

}
