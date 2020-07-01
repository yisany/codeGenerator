package com.yis.generator.service;

import com.yis.generator.entity.param.InfoParam;
import com.yis.generator.entity.ReturnT;

import java.util.Map;

/**
 * GeneratorService
 * @author zhengkai.blog.csdn.net
 */
public interface GeneratorService {

    ReturnT<Map<String, String>> generator(InfoParam infoParam);

}
