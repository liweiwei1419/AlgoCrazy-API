package com.suanfa8.algocrazyapi.config;

import com.suanfa8.algocrazyapi.filter.JwtRequestFilter;
import com.suanfa8.algocrazyapi.service.UserDetailsServiceImpl;
import jakarta.annotation.Resource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.Arrays;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Resource
    private UserDetailsServiceImpl userDetailsService;

    @Resource
    private JwtRequestFilter jwtRequestFilter;


    private static final String[] URL_WHITELIST = {
            // 放行的 URL 路径
            "/auth/authenticate",
            // 添加退出登录接口路径
            "/auth/logout",

            "/user/register", "/user/send-verification-code", "/user/reset-password",

            "/hello/world",
            "/hello/greet",
            "/tree/**",
            "/article/**",
            "/file/**"
//            "/article/liwei", "/user/register", "/ok", "/user/login", "/messages/**", "/logout", "/captcha", "/favicon.ico",
//            // 下面是 swagger-ui 放行的页面
//            "/doc.html","/swagger-ui/**", "/webjars/**", "/v2/**", "/swagger-resources/**",
//            "/v3/**",  // knife4j 相关放行
//            // 下面是算法吧的相关放行
//            "/article/**",
//            "/content/**",
//            "/essay/**",
//            "/essay/**",
//            "/catalogue/**",
//            "/redis/catalogue",
//            "/redis/category/",
//            "/category",
//            "/categories",
//            "/tags/**",
//            "/comment/**",
//            "/increaseLikeNum/**",
//            "/increaseDislikeNum/**",
//            "/message/**",
//            "/user/**",
//            "/danmu/**",
//            "/video/**",
//            "/common-problem/**",
//            "/update-history/**",
//            "/website-introduction/**",
    };

    /**
     * 配置密码编码器
     * @return BCryptPasswordEncoder 实例
     */
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new CustomMd5PasswordEncoder(1024);
    }

    /**
     * 配置认证提供者
     * @return DaoAuthenticationProvider 实例
     */
    @Bean
    public AuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailsService);
        authProvider.setPasswordEncoder(passwordEncoder());
        return authProvider;
    }

    /**
     * 配置认证管理器
     * @param config 认证配置
     * @return AuthenticationManager 实例
     * @throws Exception 异常
     */
    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration config) throws Exception {
        return config.getAuthenticationManager();
    }

    /**
     * 配置安全过滤器链
     * @param http HttpSecurity 对象
     * @return SecurityFilterChain 实例
     * @throws Exception 异常
     */
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .cors(cors -> cors.configurationSource(corsConfigurationSource()))
                .csrf(csrf -> csrf.disable())
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers(URL_WHITELIST).permitAll()
                        .anyRequest().authenticated()
                )
                .sessionManagement(session -> session
                        .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                )
                // .authenticationProvider(authenticationProvider())
                .addFilterBefore(jwtRequestFilter, UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }


    @Bean
    CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        // 明确指定允许的前端源地址
        configuration.addAllowedOriginPattern("http://localhost:5173");
        configuration.addAllowedOriginPattern("https://algocrazy.dance8.fun");
        configuration.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "DELETE", "OPTIONS"));
        configuration.setAllowedHeaders(Arrays.asList("*"));
        configuration.setAllowCredentials(true);
        configuration.addExposedHeader("Authorization");
        // 设置预检请求缓存时间
        configuration.setMaxAge(3600L);
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }
}
