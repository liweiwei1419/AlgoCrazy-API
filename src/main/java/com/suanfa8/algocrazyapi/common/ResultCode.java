package com.suanfa8.algocrazyapi.common;

/**
 * 操作结果状态码
 * @author liweiwei1419
 */
public enum ResultCode {

    /**
    * 操作成功
     */
    SUCCESS(200, "操作成功"),

    /**
     * 操作失败
     */
    FAILED(500, "操作失败"),

    /**
     * 参数检验失败
     */
    VALIDATE_FAILED(400, "参数检验失败"),

    /**
     * 暂未登录或 token 已经过期
     */
    UNAUTHORIZED(401, "暂未登录或 token 已经过期"),

    /**
     * 没有相关权限
     */
    FORBIDDEN(403, "没有相关权限"),

     /**
     * 用户不存在
     */
    USER_NOT_FOUND(404, "用户不存在");

    /**
     * 状态码
     */
    private int code;

    /**
     * 操作结果描述
     */
    private String message;

    ResultCode(int code, String message) {
        this.code = code;
        this.message = message;
    }

    public int getCode() {
        return code;
    }

    public String getMessage() {
        return message;
    }

}