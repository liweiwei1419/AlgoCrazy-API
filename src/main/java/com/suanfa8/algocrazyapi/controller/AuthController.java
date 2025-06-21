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
        String username = authenticationRequest.getUsername();
        try {
            String password = authenticationRequest.getPassword();
            log.info("username: {}, password: {}", username, password);
            authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(username, username + "@@@@@@" + password));
        } catch (BadCredentialsException e) {
            throw new Exception("Incorrect username or password", e);
        }
        final UserDetails userDetails = userDetailsService.loadUserByUsername(username);
        final String jwt = jwtUtil.generateToken(userDetails);
        jwtRedisService.saveJwt(userDetails.getUsername(), jwt);
        return ResponseEntity.ok(new AuthenticationResponse(jwt));
    }

    // @RequestBody LogoutRequest logoutRequest
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




