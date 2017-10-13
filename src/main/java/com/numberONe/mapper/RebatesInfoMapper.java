package com.numberONe.mapper;

import com.numberONe.tempEntity.RebatesInfo;

public interface RebatesInfoMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(RebatesInfo record);

    int insertSelective(RebatesInfo record);

    RebatesInfo selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(RebatesInfo record);

    int updateByPrimaryKey(RebatesInfo record);
}