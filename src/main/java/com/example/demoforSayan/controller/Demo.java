package com.example.demoforSayan.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@ResponseBody
public class Demo {
	
//	@Autowired
//	private DemoServive d;
	
	@GetMapping("/hii")
	public String hii() {
		
		DemoServive d=new DemoServive();
		return d.getValuefromProperties();
	}

}
