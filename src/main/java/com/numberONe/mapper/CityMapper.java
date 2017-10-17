package com.numberONe.mapper;

import com.numberONe.mapper.base.BaseMapper;
import com.numberONe.tempEntity.City;
import org.apache.poi.ss.formula.functions.T;

public interface CityMapper extends BaseMapper{

    int deleteByPrimaryKey(Integer id);

    int insert(City record);

    int insertSelective(City record);

    City selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(City record);

    int updateByPrimaryKey(City record);
}