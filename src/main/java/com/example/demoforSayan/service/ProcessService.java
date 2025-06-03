package com.example.demoforSayan.service;

import org.springframework.stereotype.Service;

@Service
public class ProcessService {

    public String processValue(String input) {
        // Dummy logic: convert to uppercase
        return "Processed: " + input.toUpperCase();
    }
}
