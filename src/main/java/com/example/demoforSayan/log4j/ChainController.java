package com.example.demoforSayan.log4j;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.ThreadContext;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@RestController
public class ChainController {

	private static final Logger logger = LogManager.getLogger(ChainController.class);
	private final ChainService chainService;

	public ChainController(ChainService chainService) {
		this.chainService = chainService;
	}
	HttpSession session=null;

	@GetMapping("/chain")
	public String startChain(HttpServletRequest request) {
		HttpSession session = request.getSession();
		
		if(session!=null) {
			logger.info("session.invalidate()");
			System.err.println(session.getId());
			session.invalidate();
		}
		
		session=request.getSession(true);
		System.err.println(session.getId());
		 ThreadContext.put("sessionId", session.getId());
		
		logger.info("startChain endpoint called");
		chainService.startProcess();
		
		session.invalidate();
		ThreadContext.clearAll();
		logger.info("frontend calling");
		
		
		return "abc";
	}
}
