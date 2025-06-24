package com.suanfa8.algocrazyapi.utils;

import com.suanfa8.algocrazyapi.entity.User;
import com.suanfa8.algocrazyapi.service.JwtRedisService;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import java.security.Key;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Component
public class JwtUtil {

    @Value("${jwt.secret}")
    private String secret;

    @Value("${jwt.expiration}")
    private long expiration;

    @Value("${jwt.clock-skew:30000}") // 30 seconds tolerance for clock differences
    private long clockSkew;

    @Autowired
    private JwtRedisService jwtRedisService;

    private Key getSigningKey() {
        try {
            byte[] keyBytes = io.jsonwebtoken.io.Decoders.BASE64.decode(secret);
            if (keyBytes.length < 64) { // HS512 requires 512-bit (64-byte) key
                throw new IllegalArgumentException("Secret key must be at least 512 bits (64 bytes) long when base64 decoded");
            }
            return Keys.hmacShaKeyFor(keyBytes);
        } catch (IllegalArgumentException e) {
            throw new IllegalArgumentException("Invalid secret key format", e);
        }
    }

    public String generateToken(UserDetails userDetails) {
        if (userDetails == null) {
            throw new IllegalArgumentException("UserDetails cannot be null");
        }

        User user = (User) userDetails;
        Map<String, Object> claims = new HashMap<>();
        // 添加头像、用户名、邮箱和角色 ID 到 claims 中
        claims.put("user_id", user.getId().toString());
        claims.put("avatar", user.getAvatar());
        claims.put("nickname", user.getNickname());
        claims.put("email", user.getEmail());
        claims.put("role_id", user.getRoleId());
        claims.put("role", userDetails.getAuthorities());
        // claims 里面可以放用户信息对吗
        // 可以，但是要注意不要放敏感信息，比如密码，因为这个信息会被暴露在 JWT 中
        // setSubject 是什么呢？
        // setSubject 是用来设置 JWT 的主题（Subject）的，主题是一个字符串，用来表示这个 JWT 所代表的用户。
        // 比如，我们可以把用户的 ID 作为主题，这样就可以在 JWT 中标识这个用户。

        // claims 和 Subject 的区别？
        // claims 是用来存储 JWT 的额外信息的，比如用户的角色，权限，过期时间等等。
        // Subject 是用来标识这个 JWT 所代表的用户的，比如用户的 ID。
        return Jwts.builder().setClaims(claims).setSubject(userDetails.getUsername()).setIssuedAt(new Date(System.currentTimeMillis())).setExpiration(new Date(System.currentTimeMillis() + expiration)).signWith(getSigningKey(), SignatureAlgorithm.HS512).compact();
    }

    public boolean validateToken(String token, UserDetails userDetails) {
        try {
            if (token == null || userDetails == null) {
                return false;
            }

            final String username = extractUsername(token);
            return username.equals(userDetails.getUsername()) && !isTokenExpired(token) && jwtRedisService.validateJwt(username, token);
        } catch (JwtException | IllegalArgumentException e) {
            return false;
        }
    }

    public boolean isTokenExpired(String token) {
        try {
            return extractExpiration(token).before(new Date());
        } catch (JwtException | IllegalArgumentException e) {
            return true; // Consider invalid tokens as expired
        }
    }

    public String extractUsername(String token) throws JwtException {
        return extractClaims(token).getSubject();
    }

    public Date extractExpiration(String token) throws JwtException {
        return extractClaims(token).getExpiration();
    }

    public Claims extractClaims(String token) throws JwtException {
        if (token == null || token.trim().isEmpty()) {
            throw new IllegalArgumentException("Token cannot be null or empty");
        }
        return Jwts.parserBuilder().setSigningKey(getSigningKey()).setAllowedClockSkewSeconds(clockSkew / 1000) // convert to seconds
                .build().parseClaimsJws(token).getBody();
    }

}