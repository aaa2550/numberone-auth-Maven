package com.numberONe.tempEntity;

import java.math.BigDecimal;
import java.util.Date;

public class RechargeInfo {
    private Integer id;

    private Date createTime;

    private Date updateTime;

    private Integer generalizeId;

    private String appId;

    private Integer customerId;

    private String customerName;

    private Integer providerId;

    private String providerName;

    private BigDecimal ourRebates;

    private BigDecimal customerRebates;

    private BigDecimal accountRecharge;

    private BigDecimal rebatesRecharge;

    private BigDecimal rechargeCost;

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

    public Integer getGeneralizeId() {
        return generalizeId;
    }

    public void setGeneralizeId(Integer generalizeId) {
        this.generalizeId = generalizeId;
    }

    public String getAppId() {
        return appId;
    }

    public void setAppId(String appId) {
        this.appId = appId == null ? null : appId.trim();
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

    public Integer getProviderId() {
        return providerId;
    }

    public void setProviderId(Integer providerId) {
        this.providerId = providerId;
    }

    public String getProviderName() {
        return providerName;
    }

    public void setProviderName(String providerName) {
        this.providerName = providerName == null ? null : providerName.trim();
    }

    public BigDecimal getOurRebates() {
        return ourRebates;
    }

    public void setOurRebates(BigDecimal ourRebates) {
        this.ourRebates = ourRebates;
    }

    public BigDecimal getCustomerRebates() {
        return customerRebates;
    }

    public void setCustomerRebates(BigDecimal customerRebates) {
        this.customerRebates = customerRebates;
    }

    public BigDecimal getAccountRecharge() {
        return accountRecharge;
    }

    public void setAccountRecharge(BigDecimal accountRecharge) {
        this.accountRecharge = accountRecharge;
    }

    public BigDecimal getRebatesRecharge() {
        return rebatesRecharge;
    }

    public void setRebatesRecharge(BigDecimal rebatesRecharge) {
        this.rebatesRecharge = rebatesRecharge;
    }

    public BigDecimal getRechargeCost() {
        return rechargeCost;
    }

    public void setRechargeCost(BigDecimal rechargeCost) {
        this.rechargeCost = rechargeCost;
    }
}