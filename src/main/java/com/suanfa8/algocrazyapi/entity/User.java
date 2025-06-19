package com.suanfa8.algocrazyapi.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.time.LocalDateTime;
import java.util.Collection;
import java.util.Collections;

@Data
@ToString
@AllArgsConstructor
@NoArgsConstructor
@TableName("suanfa8_user")
public class User implements UserDetails{

    @TableId(type = IdType.AUTO)
    private Long id;
    private String username;
    private String password;
    private String nickname;
    private String avatar;
    private String email;
    private Integer role_id;
    private String homepage;
    private Integer deleted;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        // 根据 role_id 动态设置权限
        if (role_id != null) {
            String role = "ROLE_USER"; // 默认角色
            if (role_id == 1) {
                role = "ROLE_ADMIN";
            }
            return Collections.singletonList(new SimpleGrantedAuthority(role));
        }
        return Collections.emptyList();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return deleted == 0; // 假设 deleted 为 0 表示用户启用
    }

}
