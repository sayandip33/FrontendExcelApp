package com.example.demoforSayan;

public class A {
	public static void main(String[] args) {
		System.out.println("Starting main method......");

		Object a = null;

		if (a != null && a.toString().toLowerCase() == "sayan") {
			System.err.println("if");

		} else {
			System.err.println("else");
		}

//		String b=(String) a;
//		
//		System.err.println(b);

	}
}
