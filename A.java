@Bean
public SecurityFilterChain configure(HttpSecurity http) throws Exception {

    http
        .securityMatcher("/login/**", "/logout/**", "/oauth2/**", "/", "/oidc/*",
                         "/reports.do", "/doUpdateRex.do", "/canUpdate.do",
                         "/doUpdate.do", "/doUpdateBNYM9MenuOption.do",
                         "/doUpdateEMEA9MenuOption.do", "/doUpdateAPAC9MenuOption.do",
                         "/doUpdatePERSHINGINTERNAL9MenuOption.do", "/logout.do",
                         "/updategetUserInfoForProcID.do")

        .authorizeHttpRequests(authorize -> authorize
            .requestMatchers("/healthCheck", "/error",
                             "/unprotected/logout/**", "/logout/**",
                             "/logout.do", "/login/**")
            .permitAll()
            .requestMatchers("/", "/reports.do", "/doUpdateRex.do",
                             "/canUpdate.do", "/doUpdate.do",
                             "/doUpdateBNYM9MenuOption.do",
                             "/doUpdateEMEA9MenuOption.do",
                             "/doUpdateAPAC9MenuOption.do",
                             "/doUpdatePERSHINGINTERNAL9MenuOption.do",
                             "/updategetUserInfoForProcID.do")
            .hasAnyRole("VXIADMIN", "VXIPHO")
            .anyRequest().authenticated())

        .oauth2Login(oauth -> oauth.userInfoEndpoint(userInfo ->
            userInfo.oidcUserService(this.oidcUserService())))

        .logout(logout -> {
            logout.logoutSuccessUrl("/logout.do");
            logout.addLogoutHandler(pingFederateLogoutHandler());
        })

        // ✅ FIXED SECTION — Using new cookie customizer API
        .csrf(csrf -> {
            CookieCsrfTokenRepository csrfTokenRepository = new CookieCsrfTokenRepository();
            csrfTokenRepository.setCookieCustomizer(cookie -> cookie
                .httpOnly(true)     // add HttpOnly flag
                .secure(true)       // ensure Secure flag
                .path("/helpdeskadminportal") // optional: set consistent path
            );
            csrf.csrfTokenRepository(csrfTokenRepository);
            csrf.ignoringRequestMatchers("/logout", "/logout.do");
        })

        .sessionManagement(session -> session.sessionConcurrency(concurrency -> {
            concurrency.maximumSessions(1);
            concurrency.maxSessionsPreventsLogin(false);
            concurrency.expiredUrl("/logout.do");
            concurrency.sessionRegistry(new SpringSessionBackedSessionRegistry<>(sessionRepository));
        })
        .invalidSessionUrl("/logout.do")
        .sessionAuthenticationErrorUrl("/unprotected/unauthenticatedsession.jsp"));

    http.cors(cors -> cors.configurationSource(request -> {
        CorsConfiguration configuration = new CorsConfiguration();
        configuration.setAllowedOrigins(Arrays.asList(
            "https://localhost:8443",
            "https://vru-services.qa.bnymellon.net",
            "https://vru-services.bnymellon.net"));
        configuration.setAllowedMethods(Arrays.asList("*"));
        configuration.setAllowedHeaders(Arrays.asList("*"));
        return configuration;
    }));

    return http.build();
}
