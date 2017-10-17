package com.numberONe.tempEntity;

import java.util.Date;

public class KeepmeAccountInfo {
    private Integer id;

    private Date createTime;

    private Date updateTime;

    private String appId;

    private Integer platform;

    private String platformName;

    private String keepmeAccountName;

    private String keepmeAccounId;

    private Integer providerId;

    private String providerName;

    private String qq;

    private String industry;

    private String generalizeLink;

    private String services;

    private Integer passStatus;

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

    public Integer getPlatform() {
        return platform;
    }

    public void setPlatform(Integer platform) {
        this.platform = platform;
    }

    public String getPlatformName() {
        return platformName;
    }

    public void setPlatformName(String platformName) {
        this.platformName = platformName == null ? null : platformName.trim();
    }

    public String getKeepmeAccountName() {
        return keepmeAccountName;
    }

    public void setKeepmeAccountName(String keepmeAccountName) {
        this.keepmeAccountName = keepmeAccountName == null ? null : keepmeAccountName.trim();
    }

    public String getKeepmeAccounId() {
        return keepmeAccounId;
    }

    public void setKeepmeAccounId(String keepmeAccounId) {
        this.keepmeAccounId = keepmeAccounId == null ? null : keepmeAccounId.trim();
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

    public Integer getPassStatus() {
        return passStatus;
    }

    public void setPassStatus(Integer passStatus) {
        this.passStatus = passStatus;
    }

    public Date getPassTime() {
        return passTime;
    }

    public void setPassTime(Date passTime) {
        this.passTime = passTime;
    }
}