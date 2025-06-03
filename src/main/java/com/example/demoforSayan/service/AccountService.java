package com.example.demoforSayan.service;

import com.example.demoforSayan.dto.AccountTransferDTO;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

@Service
public class AccountService {

	public static final Map<String, AccountTransferDTO> ACCOUNT_MAP = new HashMap<>();

	public String processExcel(MultipartFile file) {
		try (InputStream is = file.getInputStream(); Workbook workbook = new XSSFWorkbook(is)) {
			Sheet sheet = workbook.getSheetAt(0);

			for (Row row : sheet) {
				if (row.getRowNum() == 0)
					continue; // skip header

				Cell cell = row.getCell(0);
				String accNum = cell.getStringCellValue().trim();

				// Validate 14-digit account number
				if (!accNum.matches("\\d{14}")) {
					return "Invalid account number found: " + accNum;
				}

				AccountTransferDTO dto = new AccountTransferDTO(accNum, "admin_admin_true", // createdBy_updatedBy_isActive
						"TXN" + accNum.substring(0, 4) // transfer number mock
				);

				ACCOUNT_MAP.put(accNum, dto);
			}

			return "File processed successfully. Total accounts: " + ACCOUNT_MAP.size();
		} catch (Exception e) {
			e.printStackTrace();
			return "Failed to process file: " + e.getMessage();
		}
	}

	public Map<String, AccountTransferDTO> getAccounts() {
		return ACCOUNT_MAP;
	}

	public AccountTransferDTO findAccount(String accNum) {
		return ACCOUNT_MAP.get(accNum);
	}

	public boolean updateTransferNumber(String accNum, String newTransferNum) {
		AccountTransferDTO dto = ACCOUNT_MAP.get(accNum);
		if (dto != null) {
			dto.setTransferNumber(newTransferNum);
			return true;
		}
		return false;
	}

}
