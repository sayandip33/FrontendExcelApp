package com.example.demoforSayan.controller;

import jakarta.validation.constraints.Pattern;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
@Validated  // This is CRUCIAL
public class MyController {

    @GetMapping("/validateParam")
    public String validateParam(
        @RequestParam
        @Pattern(regexp = "\\d{14}", message = "Account number must be exactly 14 digits")
        String acc) {

        return "Validated: " + acc;
    }
}
