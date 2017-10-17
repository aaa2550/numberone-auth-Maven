package com.numberONe.mapper;

import com.numberONe.mapper.base.BaseMapper;
import com.numberONe.tempEntity.ProviderInfo;

public interface ProviderInfoMapper extends BaseMapper {

    int deleteByPrimaryKey(Integer id);

    int insert(ProviderInfo record);

    int insertSelective(ProviderInfo record);

    ProviderInfo selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ProviderInfo record);

    int updateByPrimaryKey(ProviderInfo record);
}