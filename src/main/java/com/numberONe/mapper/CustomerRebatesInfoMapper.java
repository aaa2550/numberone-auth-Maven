package com.numberONe.mapper;

import com.numberONe.mapper.base.BaseMapper;
import com.numberONe.tempEntity.RebatesInfo;

public interface CustomerRebatesInfoMapper extends BaseMapper {

    int deleteByPrimaryKey(Integer id);

    int insert(RebatesInfo record);

    int insertSelective(RebatesInfo record);

    RebatesInfo selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(RebatesInfo record);

    int updateByPrimaryKey(RebatesInfo record);
}