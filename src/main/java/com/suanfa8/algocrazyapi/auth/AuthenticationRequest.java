package com.suanfa8.algocrazyapi.auth;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class AuthenticationRequest {

    private String usernameOrEmail;

    private String password;

}