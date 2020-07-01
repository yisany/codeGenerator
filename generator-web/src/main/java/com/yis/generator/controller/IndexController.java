package com.yis.generator.controller;

import com.yis.generator.entity.param.InfoParam;
import com.yis.generator.entity.ReturnT;
import com.yis.generator.service.GeneratorService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

/**
 * spring boot code generator
 *
 * @author zhengk/moshow
 */
@Controller
@Slf4j
public class IndexController {

    @Autowired
    private GeneratorService generatorService;

    @GetMapping("/")
    public String index() {
        return "index";
    }

    @PostMapping("/genCode")
    @ResponseBody
    public ReturnT<Map<String, String>> codeGenerate(@RequestBody InfoParam infoParam) {
        return generatorService.generator(infoParam);
    }

}
