package com.numberONe.mapper;

import com.numberONe.mapper.base.BaseMapper;
import com.numberONe.tempEntity.CustomerContractInfo;

public interface CustomerContractInfoMapper extends BaseMapper {

    int deleteByPrimaryKey(Integer id);

    int insert(CustomerContractInfo record);

    int insertSelective(CustomerContractInfo record);

    CustomerContractInfo selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CustomerContractInfo record);

    int updateByPrimaryKey(CustomerContractInfo record);
}