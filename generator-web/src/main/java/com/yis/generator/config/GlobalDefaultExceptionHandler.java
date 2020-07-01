package com.yis.generator.config;

import javax.servlet.http.HttpServletRequest;

import com.google.common.base.Throwables;
import com.yis.generator.entity.ReturnT;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 用于当后端系统抛出异常时对前端的返回
 */
@Slf4j
@ControllerAdvice
public class GlobalDefaultExceptionHandler {

    @ExceptionHandler(Exception.class)
    @ResponseBody
    public ReturnT defaultExceptionHandler(HttpServletRequest req, Exception e) {
        log.error("exception is born, e={}", Throwables.getStackTraceAsString(e));
        return new ReturnT<>(ReturnT.FAIL_CODE, e.getMessage());
    }

}
