package com.example.demoforSayan;

public class YearToWords {
    
    // Arrays for number-to-word conversion
    private static final String[] units = {
        "", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine",
        "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen",
        "sixteen", "seventeen", "eighteen", "nineteen"
    };

    private static final String[] tens = {
        "", "", "twenty", "thirty", "forty", "fifty",
        "sixty", "seventy", "eighty", "ninety"
    };

    // Convert number to words
    public static String numberToWords(int num) {
        if (num == 0) return "zero";
        if (num < 20) return units[num];
        if (num < 100) 
            return tens[num / 10] + (num % 10 != 0 ? " " + units[num % 10] : "");
        if (num < 1000) 
            return units[num / 100] + " hundred" + (num % 100 != 0 ? " " + numberToWords(num % 100) : "");
        if (num < 10000) 
            return units[num / 1000] + " thousand" + (num % 1000 != 0 ? " " + numberToWords(num % 1000) : "");
        if (num < 1000000) {
            return numberToWords(num / 1000) + " thousand" 
                   + (num % 1000 != 0 ? " " + numberToWords(num % 1000) : "");
        }
        return "";
    }

    public static String toCommaSeparatedWords(int year) {
        String words = numberToWords(year);
        return String.join(",", words.split(" "));
    }

    public static void main(String[] args) {
      
        int year = 2025;
      
        System.out.println(toCommaSeparatedWords(year));
    }
}
