package com.example.demoforSayan;
import java.util.*;

public class YearSplitter {
    
    // Method to split year and return as a string
    public static String splitYear(int year) {
        List<Integer> parts = new ArrayList<>();
        int remaining = year;

        // Extract the thousands part (if any)
        int thousands = (remaining / 1000) * 1000;
        if (thousands > 0) {
            parts.add(thousands);
            remaining -= thousands;
        }

        // Extract the hundreds part (if any)
        int hundreds = (remaining / 100) * 100;
        if (hundreds > 0) {
            parts.add(hundreds);
            remaining -= hundreds;
        }

        // Remaining part (tens & ones)
        if (remaining > 0) {
            parts.add(remaining);
        }

        // Join parts into a string
        return String.join(",", parts.stream()
                                     .map(String::valueOf)
                                     .toArray(String[]::new));
    }

    public static void main(String[] args) {
        // Test cases
        System.out.println(splitYear(2025));  // 2000,25
        System.out.println(splitYear(2024));  // 2000,24
        System.out.println(splitYear(1098));  // 1000,98
        System.out.println(splitYear(1998));  // 1000,900,98
        System.out.println(splitYear(2155));  // 2000,100,55
    }
}
