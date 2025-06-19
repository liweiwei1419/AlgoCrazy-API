package com.suanfa8.algocrazyapi.controller;

import com.suanfa8.algocrazyapi.auth.AuthenticationRequest;
import com.suanfa8.algocrazyapi.auth.AuthenticationResponse;
import com.suanfa8.algocrazyapi.service.JwtRedisService;
import com.suanfa8.algocrazyapi.service.UserDetailsServiceImpl;
import com.suanfa8.algocrazyapi.utils.JwtUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.CrossOrigin;
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

}




