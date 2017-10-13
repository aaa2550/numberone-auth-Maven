package com.numberONe.mapper;

import com.numberONe.tempEntity.ProviderContractInfo;

public interface ProviderContractInfoMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ProviderContractInfo record);

    int insertSelective(ProviderContractInfo record);

    ProviderContractInfo selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ProviderContractInfo record);

    int updateByPrimaryKey(ProviderContractInfo record);
}