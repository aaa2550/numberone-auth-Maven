package com.numberONe.mapper;

import com.numberONe.mapper.base.BaseMapper;
import com.numberONe.tempEntity.ReturnPayInfo;

public interface ReturnPayInfoMapper extends BaseMapper {

    int deleteByPrimaryKey(Integer id);

    int insert(ReturnPayInfo record);

    int insertSelective(ReturnPayInfo record);

    ReturnPayInfo selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ReturnPayInfo record);

    int updateByPrimaryKey(ReturnPayInfo record);
}