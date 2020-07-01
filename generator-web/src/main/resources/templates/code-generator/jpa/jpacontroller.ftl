package ${packageName}.controller;

import ${packageName}.entity.${classInfoDTO.className};
import ${packageName}.repository.${classInfoDTO.className}Repository;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.data.domain.ExampleMatcher;
import org.springframework.data.domain.PageRequest;
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
    private ${classInfoDTO.className}Repository ${classInfoDTO.className?uncap_first}Repository;

    /**
    * 新增或编辑
    */
    @PostMapping("/save")
    public Object save(${classInfoDTO.className} ${classInfoDTO.className?uncap_first}){
        return ${classInfoDTO.className?uncap_first}Repository.save(${classInfoDTO.className?uncap_first});
    }

    /**
    * 删除
    */
    @PostMapping("/delete")
    public Object delete(int id){
        Optional<${classInfoDTO.className}> ${classInfoDTO.className?uncap_first}=${classInfoDTO.className?uncap_first}Repository.findById(id);
        if(${classInfoDTO.className?uncap_first}.isPresent()){
            ${classInfoDTO.className?uncap_first}Repository.deleteById(id);
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
        Optional<${classInfoDTO.className}> ${classInfoDTO.className?uncap_first}=${classInfoDTO.className?uncap_first}Repository.findById(id);
        if(${classInfoDTO.className?uncap_first}.isPresent()){
            return ${returnUtil}.success(${classInfoDTO.className?uncap_first}.get());
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

            //创建匹配器，需要查询条件请修改此处代码
            ExampleMatcher matcher = ExampleMatcher.matchingAll();

            //创建实例
            Example<${classInfoDTO.className}> example = Example.of(${classInfoDTO.className?uncap_first}, matcher);
            //分页构造
            Pageable pageable = PageRequest.of(pageNumber,pageSize);

            return ${classInfoDTO.className?uncap_first}Repository.findAll(example, pageable);
    }

}
