package com.yis.generator.parse;

import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * @author by yisany on 2020/05/14
 */
@Slf4j
@Service
public class TableParseFactory {

    @Autowired
    private Map<String, TableParseStrategy> strategys;

    public TableParseStrategy getStrategy(String component) {
        TableParseStrategy strategy = strategys.get(component);
        if (!ObjectUtils.allNotNull(strategy)) {
            throw new RuntimeException("no strategy defined, component=" + component);
        }
        return strategy;
    }

}
