package com.example.demoforSayan.controller;

import com.example.demoforSayan.dto.AccountTransferDTO;
import com.example.demoforSayan.service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

@Controller
public class AccountController {

	@Autowired
	private AccountService accountService;

	@GetMapping("/")
	public String index() {
		return "index";
	}

	@PostMapping("/upload")
	@ResponseBody
	public String handleFileUpload(@RequestParam("file") MultipartFile file) {
		return accountService.processExcel(file);
	}

	@GetMapping("/accounts")
	@ResponseBody
	public Map<String, ?> getAllAccounts() {
		return accountService.getAccounts();
	}

	@PostMapping("/search")
	@ResponseBody
	public AccountTransferDTO searchAccount(@RequestParam String accountNumber) {
		return accountService.findAccount(accountNumber);
	}

	@PostMapping("/update-transfer")
	@ResponseBody
	public String updateTransferNumber(@RequestParam String accountNumber, @RequestParam String transferNumber) {
		boolean success = accountService.updateTransferNumber(accountNumber, transferNumber);
		return success ? "Updated successfully" : "Account not found";
	}

}
