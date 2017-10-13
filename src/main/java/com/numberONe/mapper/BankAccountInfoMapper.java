package com.numberONe.mapper;

import com.numberONe.tempEntity.BankAccountInfo;

public interface BankAccountInfoMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(BankAccountInfo record);

    int insertSelective(BankAccountInfo record);

    BankAccountInfo selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(BankAccountInfo record);

    int updateByPrimaryKey(BankAccountInfo record);
}