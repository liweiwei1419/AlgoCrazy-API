package com.suanfa8.algocrazyapi.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.suanfa8.algocrazyapi.common.Result;
import com.suanfa8.algocrazyapi.dto.message.MessageAddDto;
import com.suanfa8.algocrazyapi.dto.message.MessageReplyDto;
import com.suanfa8.algocrazyapi.entity.Message;
import com.suanfa8.algocrazyapi.service.IMessageService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import org.springframework.beans.BeanUtils;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@CrossOrigin
@Tag(name = "留言板")
@RestController
@RequestMapping("/message")
public class MessageController {

    @Resource
    private IMessageService messageService;

    @Operation(summary = "获取所有留言列表")
    @GetMapping("/all")
    public Result<List<Message>> getAllMessages() {
        return Result.success(messageService.getAllMessages());
    }

    @Operation(summary = "分页获取留言列表")
    @Parameter(name = "pageNum", description = "页码")
    @Parameter(name = "pageSize", description = "每页数量")
    @GetMapping("/list")
    public Result<IPage<Message>> listMessages(
            @RequestParam(required = false) Integer pageNum,
            @RequestParam(required = false) Integer pageSize) {
        return Result.success(messageService.listMessages(pageNum, pageSize));
    }

    @Operation(summary = "添加留言")
    @PostMapping("/add")
    public Result<Message> addMessage(@RequestBody MessageAddDto messageAddDto) {
        Message message = new Message();
        BeanUtils.copyProperties(messageAddDto, message);
        return Result.success(messageService.addMessage(message));
    }

    @Operation(summary = "更新留言状态")
    @PreAuthorize("hasAnyRole('ADMIN')")
    @PutMapping("/status/{id}/{status}")
    public Result<Boolean> updateMessageStatus(
            @Parameter(name = "id", required = true, description = "留言ID") @PathVariable Long id,
            @Parameter(name = "status", required = true, description = "状态：0-待回复，1-已回复") @PathVariable Integer status) {
        return Result.success(messageService.updateMessageStatus(id, status));
    }

    @Operation(summary = "添加回复内容")
    @PreAuthorize("hasAnyRole('ADMIN')")
    @PutMapping("/reply")
    public Result<Boolean> addReply(@RequestBody MessageReplyDto messageReplyDto) {
        return Result.success(messageService.addReply(messageReplyDto.getId(), messageReplyDto.getReplyContent()));
    }

    @Operation(summary = "删除留言")
    @PreAuthorize("hasAnyRole('ADMIN')")
    @DeleteMapping("/delete/{id}")
    public Result<Boolean> deleteMessage(@PathVariable Long id) {
        return Result.success(messageService.deleteMessage(id));
    }

    @Operation(summary = "按状态获取留言列表")
    @Parameter(name = "status", required = true, description = "状态：0-待回复，1-已回复")
    @GetMapping("/status/{status}")
    public Result<List<Message>> getMessagesByStatus(@PathVariable Integer status) {
        return Result.success(messageService.getMessagesByStatus(status));
    }
}