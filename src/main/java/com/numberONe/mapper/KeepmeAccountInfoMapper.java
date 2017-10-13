package com.numberONe.mapper;

import com.numberONe.tempEntity.KeepmeAccountInfo;

public interface KeepmeAccountInfoMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(KeepmeAccountInfo record);

    int insertSelective(KeepmeAccountInfo record);

    KeepmeAccountInfo selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(KeepmeAccountInfo record);

    int updateByPrimaryKey(KeepmeAccountInfo record);
}