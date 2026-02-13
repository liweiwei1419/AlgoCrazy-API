package com.suanfa8.algocrazyapi.config;

import com.suanfa8.algocrazyapi.filter.JwtRequestFilter;
import com.suanfa8.algocrazyapi.service.impl.UserDetailsServiceImpl;
import jakarta.annotation.Resource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
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

// 允许方法级别的注释
@EnableMethodSecurity(securedEnabled = true)  // 添加到类注解上
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
            "/comment/comments", "/comment/add", "/comment/*/replies", "/user/register", "/user/forgot-password", "/user/reset-password", "/user/homepage/**", "/hello/world", "/hello/days-until-2025-10-30", "/hello/greet", "/tree/**", "/article/**", "/file/**", "/leetcode/problems/**", "/message/**", "/algorithm-category/**",
            // Knife4j 文档访问路径
            "/v3/api-docs", "/v3/api-docs/**",    // API 描述文档的 JSON 数据
            "/swagger-ui/**",     // Swagger UI 的所有资源（HTML, JS, CSS）
            "/swagger-ui.html",    // Swagger UI 主页面,
            "/webjars/**",           // Swagger 可能需要的静态资源
            "/swagger-resources/**",    // Swagger 资源
            "/doc.html"     // Knife4j 主页

    };

    /**
     * 配置密码编码器
     *
     * @return BCryptPasswordEncoder 实例
     */
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new CustomMd5PasswordEncoder(1024);
    }

    /**
     * 配置认证提供者
     *
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
     *
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
     *
     * @param http HttpSecurity 对象
     * @return SecurityFilterChain 实例
     * @throws Exception 异常
     */
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http.cors(cors -> cors.configurationSource(corsConfigurationSource())).csrf(csrf -> csrf.disable()).authorizeHttpRequests(auth -> auth.requestMatchers(URL_WHITELIST).permitAll().anyRequest().authenticated()).sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                // .authenticationProvider(authenticationProvider())
                .addFilterBefore(jwtRequestFilter, UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }


    @Bean
    CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        // 明确指定允许的前端源地址
        // configuration.addAllowedOriginPattern("http://localhost:5173");
        // configuration.addAllowedOriginPattern("https://algocrazy.dance8.fun");
        configuration.addAllowedOriginPattern("*");
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
