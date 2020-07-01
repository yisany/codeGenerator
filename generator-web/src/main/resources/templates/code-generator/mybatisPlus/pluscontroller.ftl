package ${packageName}.controller;

import com.alibaba.fastjson.JSON;
import ${packageName}.entity.${classInfoDTO.className};
import ${packageName}.mapper.${classInfoDTO.className}Mapper;
import ${packageName}.util.ReturnT;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.web.servlet.ModelAndView;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
* @author by ${authorName} on ${.now?string('yyyy-MM-dd')}
*/
@Slf4j
@RestController
@RequestMapping("/${classInfoDTO.className?uncap_first}")
public class ${classInfoDTO.className}Controller {

    @Autowired
    private ${classInfoDTO.className}Mapper ${classInfoDTO.className?uncap_first}Mapper;

    /**
    * 新增或编辑
    */
    @PostMapping("/save")
    public Object save(@RequestBody ${classInfoDTO.className} ${classInfoDTO.className?uncap_first}){
        log.info("${classInfoDTO.className?uncap_first}:"+JSON.toJSONString(${classInfoDTO.className?uncap_first}));
        ${classInfoDTO.className} old${classInfoDTO.className} = ${classInfoDTO.className?uncap_first}Mapper.selectOne(new QueryWrapper<${classInfoDTO.className}>().eq("${classInfoDTO.className?uncap_first}_id",${classInfoDTO.className?uncap_first}.get${classInfoDTO.className}Id()));
        ${classInfoDTO.className?uncap_first}.setModifyDate(new Date());
        if(old${classInfoDTO.className}!=null){
            ${classInfoDTO.className?uncap_first}Mapper.updateById(${classInfoDTO.className?uncap_first});
        }else{
        if(${classInfoDTO.className?uncap_first}Mapper.selectOne(new QueryWrapper<${classInfoDTO.className}>().eq("${classInfoDTO.className?uncap_first}_name",${classInfoDTO.className?uncap_first}.get${classInfoDTO.className}Name()))!=null){
            return new ReturnT<>(ReturnT.FAIL_CODE,"保存失败，名字重复");
        }
        ${classInfoDTO.className?uncap_first}.setCreateDate(new Date());
        ${classInfoDTO.className?uncap_first}Mapper.insert(${classInfoDTO.className?uncap_first});
        }
        return new ReturnT<>(ReturnT.SUCCESS_CODE,"保存成功");
    }

    /**
    * 删除
    */
    @PostMapping("/delete")
    public Object delete(int id){
    ${classInfoDTO.className} ${classInfoDTO.className?uncap_first} = ${classInfoDTO.className?uncap_first}Mapper.selectOne(new QueryWrapper<${classInfoDTO.className}>().eq("${classInfoDTO.className?uncap_first}_id",id));
        if(${classInfoDTO.className?uncap_first}!=null){
            ${classInfoDTO.className?uncap_first}Mapper.deleteById(id);
            return new ReturnT<>(ReturnT.SUCCESS_CODE,"删除成功");
        }else{
            return new ReturnT<>(ReturnT.FAIL_CODE,"没有找到该对象");
        }
    }

    /**
    * 查询
    */
    @PostMapping("/find")
    public Object find(int id){
    ${classInfoDTO.className} ${classInfoDTO.className?uncap_first} = ${classInfoDTO.className?uncap_first}Mapper.selectOne(new QueryWrapper<${classInfoDTO.className}>().eq("${classInfoDTO.className?uncap_first}_id",id));
        if(${classInfoDTO.className?uncap_first}!=null){
            return new ReturnT<>(${classInfoDTO.className?uncap_first});
        }else{
            return new ReturnT<>(ReturnT.FAIL_CODE,"没有找到该对象");
        }
    }

    /**
    * 分页查询
    */
    @PostMapping("/list")
    public Object list(String searchParams,
    @RequestParam(required = false, defaultValue = "0") int page,
    @RequestParam(required = false, defaultValue = "10") int limit) {
        log.info("page:"+page+"-limit:"+limit+"-json:"+ JSON.toJSONString(searchParams));
        //分页构造器
        Page<${classInfoDTO.className}> buildPage = new Page<${classInfoDTO.className}>(page,limit);
        //条件构造器
        QueryWrapper<${classInfoDTO.className}> queryWrapper = new QueryWrapper<${classInfoDTO.className}>();
        if(StringUtils.isNotEmpty(searchParams)&&JSON.isValid(searchParams)) {
            ${classInfoDTO.className} ${classInfoDTO.className?uncap_first} = JSON.parseObject(searchParams, ${classInfoDTO.className}.class);
            queryWrapper.eq(StringUtils.isNoneEmpty(${classInfoDTO.className?uncap_first}.get${classInfoDTO.className}Name()), "${classInfoDTO.className?uncap_first}_name", ${classInfoDTO.className?uncap_first}.get${classInfoDTO.className}Name());
        }
        //执行分页
        IPage<${classInfoDTO.className}> pageList = ${classInfoDTO.className?uncap_first}Mapper.selectPage(buildPage, queryWrapper);
        //返回结果
        return new ReturnT<>(pageList.getRecords(),Integer.parseInt(pageList.getTotal()+""));
    }
    @GetMapping("/list")
    public ModelAndView listPage(){
        return new ModelAndView("cms/${classInfoDTO.className?uncap_first}-list");
    }
    @GetMapping("/edit")
    public ModelAndView editPage(int id){
        ${classInfoDTO.className} ${classInfoDTO.className?uncap_first} = ${classInfoDTO.className?uncap_first}Mapper.selectOne(new QueryWrapper<${classInfoDTO.className}>().eq("${classInfoDTO.className?uncap_first}_id",id));
        return new ModelAndView("cms/${classInfoDTO.className?uncap_first}-edit","${classInfoDTO.className?uncap_first}",${classInfoDTO.className?uncap_first});
    }
}



