package com.numberONe.mapper;

import com.numberONe.tempEntity.RechargeInfo;

public interface RechargeInfoMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(RechargeInfo record);

    int insertSelective(RechargeInfo record);

    RechargeInfo selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(RechargeInfo record);

    int updateByPrimaryKey(RechargeInfo record);
}