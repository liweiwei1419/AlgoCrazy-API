package com.suanfa8.algocrazyapi.common;

/**
 * 操作结果状态码
 *
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
    USER_NOT_FOUND(404, "用户不存在"),


    /**
     * 习题解答不存在
     */
    EXERCISE_SOLUTION_NOT_FOUND(500, "习题解答不存在"),

    /**
     * 创建失败
     */
    CREATE_FAILED(500, "习题解答创建失败"),

    /**
     * 更新失败
     */
    UPDATE_FAILED(500, "习题解答更新失败"),

    /**
     * 删除失败
     */
    DELETE_FAILED(500, "习题解答删除失败"),

    PARAM_ERROR(500, "参数错误");


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