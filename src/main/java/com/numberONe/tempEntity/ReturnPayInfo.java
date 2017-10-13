package com.numberONe.tempEntity;

import java.math.BigDecimal;
import java.util.Date;

public class ReturnPayInfo {
    private Integer id;

    private Date createTime;

    private Date updateTime;

    private Integer customerId;

    private String customerName;

    private Date transactTime;

    private BigDecimal payMoney;

    private BigDecimal returnMoney;

    private BigDecimal surplusMoney;

    private String currency;

    private String accountName;

    private String account;

    private String openAccountInstitutions;

    private Date bankRecordTime;

    private String abstracts;

    private String remark;

    private String serialNumber;

    private String voucherSpecies;

    private String voucherCode;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public Integer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName == null ? null : customerName.trim();
    }

    public Date getTransactTime() {
        return transactTime;
    }

    public void setTransactTime(Date transactTime) {
        this.transactTime = transactTime;
    }

    public BigDecimal getPayMoney() {
        return payMoney;
    }

    public void setPayMoney(BigDecimal payMoney) {
        this.payMoney = payMoney;
    }

    public BigDecimal getReturnMoney() {
        return returnMoney;
    }

    public void setReturnMoney(BigDecimal returnMoney) {
        this.returnMoney = returnMoney;
    }

    public BigDecimal getSurplusMoney() {
        return surplusMoney;
    }

    public void setSurplusMoney(BigDecimal surplusMoney) {
        this.surplusMoney = surplusMoney;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency == null ? null : currency.trim();
    }

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName == null ? null : accountName.trim();
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account == null ? null : account.trim();
    }

    public String getOpenAccountInstitutions() {
        return openAccountInstitutions;
    }

    public void setOpenAccountInstitutions(String openAccountInstitutions) {
        this.openAccountInstitutions = openAccountInstitutions == null ? null : openAccountInstitutions.trim();
    }

    public Date getBankRecordTime() {
        return bankRecordTime;
    }

    public void setBankRecordTime(Date bankRecordTime) {
        this.bankRecordTime = bankRecordTime;
    }

    public String getAbstracts() {
        return abstracts;
    }

    public void setAbstracts(String abstracts) {
        this.abstracts = abstracts == null ? null : abstracts.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public String getSerialNumber() {
        return serialNumber;
    }

    public void setSerialNumber(String serialNumber) {
        this.serialNumber = serialNumber == null ? null : serialNumber.trim();
    }

    public String getVoucherSpecies() {
        return voucherSpecies;
    }

    public void setVoucherSpecies(String voucherSpecies) {
        this.voucherSpecies = voucherSpecies == null ? null : voucherSpecies.trim();
    }

    public String getVoucherCode() {
        return voucherCode;
    }

    public void setVoucherCode(String voucherCode) {
        this.voucherCode = voucherCode == null ? null : voucherCode.trim();
    }
}