package com.suanfa8.algocrazyapi.controller;

import com.suanfa8.algocrazyapi.auth.AuthenticationRequest;
import com.suanfa8.algocrazyapi.auth.AuthenticationResponse;
import com.suanfa8.algocrazyapi.dto.LogoutRequest;
import com.suanfa8.algocrazyapi.service.JwtRedisService;
import com.suanfa8.algocrazyapi.service.UserDetailsServiceImpl;
import com.suanfa8.algocrazyapi.utils.JwtUtil;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@CrossOrigin
@Slf4j
@RestController
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private JwtRedisService jwtRedisService;

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private UserDetailsServiceImpl userDetailsService;

    @Autowired
    private JwtUtil jwtUtil;

    @RequestMapping(value = "/authenticate", method = RequestMethod.POST)
    public ResponseEntity<?> createAuthenticationToken(@RequestBody AuthenticationRequest authenticationRequest) throws Exception {
        String identifier = authenticationRequest.getUsernameOrEmail();
        String password = authenticationRequest.getPassword();
        log.info("identifier: {}, password: {}", identifier, password);

        UserDetails userDetails = null;
        try {
            // 先尝试按用户名查找
            userDetails = userDetailsService.loadUserByUsername(identifier);
        } catch (Exception e) {
            try {
                // 若按用户名查找失败，尝试按邮箱查找
                userDetails = userDetailsService.loadUserByEmail(identifier);
            } catch (Exception ignored) {
                // 若都未找到，抛出异常
                throw new Exception("Incorrect username, email or password", e);
            }
        }

        try {
            authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(userDetails.getUsername(), userDetails.getUsername() + "@@@@@@" + password));
        } catch (BadCredentialsException e) {
            throw new Exception("Incorrect username, email or password", e);
        }

        final String jwt = jwtUtil.generateToken(userDetails);
        jwtRedisService.saveJwt(userDetails.getUsername(), jwt);
        return ResponseEntity.ok(new AuthenticationResponse(jwt));
    }


    @PreAuthorize("hasAnyRole('USER', 'ADMIN')")
    @PostMapping("/logout")
    public ResponseEntity<?> logout(HttpServletRequest request) {
        // 从请求头中获得 token
        String token = request.getHeader("Authorization");
        try {
            if (token != null && token.startsWith("Bearer ")) {
                token = token.substring(7);
            }
            String username = jwtUtil.extractUsername(token);
            log.info("username: {} 退出登录。", username);
            jwtRedisService.deleteJwt(username);
            return ResponseEntity.ok("退出登录成功");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().body("退出登录失败: " + e.getMessage());
        }
    }

}




