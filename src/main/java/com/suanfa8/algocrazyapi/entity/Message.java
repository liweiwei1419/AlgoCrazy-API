package com.suanfa8.algocrazyapi.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
@TableName("message_board")
public class Message {
    @TableId(type = IdType.AUTO)
    private Long id;
    
    @TableField("nickname")
    private String nickname;
    
    @TableField("email")
    private String email;
    
    @TableField("avatar")
    private String avatar;
    
    @TableField("content")
    private String content;
    
    @TableField("status")
    private Integer status; // 0-待回复，1-已回复
    
    @TableField("parent_id")
    private Long parentId; // 父留言ID，0表示顶层留言
    
    @TableField("level")
    private Integer level; // 回复层级：0-顶层，1-一级回复，2-二级回复...
    
    @TableField("reply_to_nickname")
    private String replyToNickname; // 回复对象的昵称
    
    @TableField("reply_content")
    private String replyContent;
    
    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @TableField("reply_time")
    private LocalDateTime replyTime;
    
    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @TableField(value = "created_at", fill = FieldFill.INSERT)
    private LocalDateTime createdAt;
    
    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @TableField(value = "updated_at", fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updatedAt;
    
    @TableField("is_deleted")
    @TableLogic
    private Boolean isDeleted = false;
    
    /**
     * 子回复列表（非数据库字段，用于树形结构返回）
     */
    @TableField(exist = false)
    private List<Message> children;
}