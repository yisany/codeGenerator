package com.yis.generator.parse;

import com.yis.generator.entity.dto.ClassInfoDTO;
import com.yis.generator.entity.param.InfoParam;

/**
 * @author by yisany on 2020/05/14
 */
public interface TableParseStrategy {

    ClassInfoDTO process(InfoParam infoParam);

}
