package com.suanfa8.algocrazyapi.exception;

import com.suanfa8.algocrazyapi.common.Result;
import com.suanfa8.algocrazyapi.common.ResultCode;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

    /**
     * 处理 JWT 过期异常
     *
     * @param ex
     * @return
     */
    @ExceptionHandler(JwtExpiredException.class)
    public Result<ResultCode> handleException(Exception ex) {
        log.error("捕捉到 Token 过期异常", ex);
        // 使用 401 Unauthorized 状态码表示未授权，适用于令牌过期场景
        return Result.fail(ResultCode.UNAUTHORIZED);
    }

    @ExceptionHandler(RuntimeException.class)
    public ResponseEntity<String> handleRuntimeException(RuntimeException ex) {
        return ResponseEntity.badRequest().body(ex.getMessage());
    }

}