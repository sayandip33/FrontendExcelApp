package com.example.demoforSayan.controller;


import com.example.demoforSayan.service.ProcessService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api")
public class ProcessController {

    @Autowired
    private ProcessService processService;

    @PostMapping("/process")
    public Map<String, String> processInput(@RequestBody Map<String, String> payload) {
        String input = payload.get("inputValue");
        String result = processService.processValue(input);
        return Map.of("processedValue", result);
    }
}

