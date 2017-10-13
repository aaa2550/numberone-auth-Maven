package com.numberONe.mapper;

import com.numberONe.entity.CustomerInfoFormMap;
import com.numberONe.entity.UserFormMap;
import com.numberONe.mapper.base.BaseMapper;
import com.numberONe.tempEntity.CustomerInfo;

import java.util.List;

public interface CustomerInfoMapper extends BaseMapper {

    /*List<CustomerInfoFormMap> findUserPage(CustomerInfoFormMap customerInfoFormMap);*/

    int deleteByPrimaryKey(Integer id);

    int insert(CustomerInfo record);

    int insertSelective(CustomerInfo record);

    CustomerInfo selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CustomerInfo record);

    int updateByPrimaryKey(CustomerInfo record);
}