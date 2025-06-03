package com.example.demoforSayan.dto;

public class AccountTransferDTO {
    private String accountNumber;
    private String createdByUpdatedByIsActive;
    private String transferNumber;

    public AccountTransferDTO(String accountNumber, String createdByUpdatedByIsActive, String transferNumber) {
        this.accountNumber = accountNumber;
        this.createdByUpdatedByIsActive = createdByUpdatedByIsActive;
        this.transferNumber = transferNumber;
    }

    // Getters & Setters
    public String getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

    public String getCreatedByUpdatedByIsActive() {
        return createdByUpdatedByIsActive;
    }

    public void setCreatedByUpdatedByIsActive(String value) {
        this.createdByUpdatedByIsActive = value;
    }

    public String getTransferNumber() {
        return transferNumber;
    }

    public void setTransferNumber(String transferNumber) {
        this.transferNumber = transferNumber;
    }
}
