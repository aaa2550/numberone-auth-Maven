package com.numberONe.tempEntity;

import java.util.Date;

public class KeepmeAccountInfo {
    private Integer id;

    private Date createTime;

    private Date updateTime;

    private String appId;

    private String platform;

    private String keepmeAccountName;

    private String keepmeAccountId;

    private Integer providerId;

    private String providerName;

    private String qq;

    private String industry;

    private String generalizeLink;

    private String services;

    private String subpackage;

    private String ocpa;

    private String passStatus;

    private Date passTime;

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

    public String getAppId() {
        return appId;
    }

    public void setAppId(String appId) {
        this.appId = appId == null ? null : appId.trim();
    }

    public String getPlatform() {
        return platform;
    }

    public void setPlatform(String platform) {
        this.platform = platform == null ? null : platform.trim();
    }

    public String getKeepmeAccountName() {
        return keepmeAccountName;
    }

    public void setKeepmeAccountName(String keepmeAccountName) {
        this.keepmeAccountName = keepmeAccountName == null ? null : keepmeAccountName.trim();
    }

    public String getKeepmeAccountId() {
        return keepmeAccountId;
    }

    public void setKeepmeAccountId(String keepmeAccountId) {
        this.keepmeAccountId = keepmeAccountId == null ? null : keepmeAccountId.trim();
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

    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq == null ? null : qq.trim();
    }

    public String getIndustry() {
        return industry;
    }

    public void setIndustry(String industry) {
        this.industry = industry == null ? null : industry.trim();
    }

    public String getGeneralizeLink() {
        return generalizeLink;
    }

    public void setGeneralizeLink(String generalizeLink) {
        this.generalizeLink = generalizeLink == null ? null : generalizeLink.trim();
    }

    public String getServices() {
        return services;
    }

    public void setServices(String services) {
        this.services = services == null ? null : services.trim();
    }

    public String getSubpackage() {
        return subpackage;
    }

    public void setSubpackage(String subpackage) {
        this.subpackage = subpackage == null ? null : subpackage.trim();
    }

    public String getOcpa() {
        return ocpa;
    }

    public void setOcpa(String ocpa) {
        this.ocpa = ocpa == null ? null : ocpa.trim();
    }

    public String getPassStatus() {
        return passStatus;
    }

    public void setPassStatus(String passStatus) {
        this.passStatus = passStatus == null ? null : passStatus.trim();
    }

    public Date getPassTime() {
        return passTime;
    }

    public void setPassTime(Date passTime) {
        this.passTime = passTime;
    }
}