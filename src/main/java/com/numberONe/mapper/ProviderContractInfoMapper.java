package com.numberONe.mapper;

import com.numberONe.mapper.base.BaseMapper;
import com.numberONe.tempEntity.ProviderContractInfo;

public interface ProviderContractInfoMapper extends BaseMapper {

    int deleteByPrimaryKey(Integer id);

    int insert(ProviderContractInfo record);

    int insertSelective(ProviderContractInfo record);

    ProviderContractInfo selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ProviderContractInfo record);

    int updateByPrimaryKey(ProviderContractInfo record);
}