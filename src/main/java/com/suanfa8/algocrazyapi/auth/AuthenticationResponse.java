package com.suanfa8.algocrazyapi.auth;


import lombok.Getter;

@Getter
public class AuthenticationResponse {
    private String jwt;

    public AuthenticationResponse(String jwt) {
        this.jwt = jwt;
    }

}