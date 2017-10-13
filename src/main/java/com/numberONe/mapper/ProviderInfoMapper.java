package com.numberONe.mapper;

import com.numberONe.tempEntity.ProviderInfo;

public interface ProviderInfoMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ProviderInfo record);

    int insertSelective(ProviderInfo record);

    ProviderInfo selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ProviderInfo record);

    int updateByPrimaryKey(ProviderInfo record);
}