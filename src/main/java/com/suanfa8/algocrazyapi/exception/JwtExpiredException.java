package com.suanfa8.algocrazyapi.exception;

import io.jsonwebtoken.ExpiredJwtException;

/**
 * 自定义 JWT 过期异常类，它不能被全局异常捕捉
 */
public class JwtExpiredException extends ExpiredJwtException {

    public JwtExpiredException(String message) {
        super(null, null, message);
    }

}