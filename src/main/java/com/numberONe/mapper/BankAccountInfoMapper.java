package com.numberONe.mapper;

import com.numberONe.mapper.base.BaseMapper;
import com.numberONe.tempEntity.BankAccountInfo;

public interface BankAccountInfoMapper extends BaseMapper {

    int deleteByPrimaryKey(Integer id);

    int insert(BankAccountInfo record);

    int insertSelective(BankAccountInfo record);

    BankAccountInfo selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(BankAccountInfo record);

    int updateByPrimaryKey(BankAccountInfo record);
}