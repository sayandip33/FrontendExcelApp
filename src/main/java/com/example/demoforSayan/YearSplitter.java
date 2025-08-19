package com.example.demoforSayan;
import java.util.*;

public class YearSplitter {
    public static void main(String[] args) {
        int year = 2155;

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

        // Print result
        for (int i = 0; i < parts.size(); i++) {
            System.out.print(parts.get(i));
            if (i < parts.size() - 1) {
                System.out.print(",");
            }
        }
    }
}
