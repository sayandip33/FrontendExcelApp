package com.example.demoforSayan.log4j;

import org.apache.logging.log4j.LogManager;

import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class ChainService {

	private static final Logger logger = LogManager.getLogger(ChainService.class);

	public String startProcess() {
		logger.info("startProcess called");
		return methodA();
	}

	private String methodA() {
		logger.info("methodA called");
		return methodB();
	}

	private String methodB() {
		logger.info("methodB called");
		return methodC();
	}

	private String methodC() {
		logger.info("methodC called");
		return methodD();
	}

	private String methodD() {
		logger.info("methodD called");
		return methodE();
	}

	private String methodE() {
		logger.info("methodE called");
		return "Final result from methodE";
	}
}
