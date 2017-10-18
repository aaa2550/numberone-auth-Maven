package com.numberONe.mapper;

import com.numberONe.mapper.base.BaseMapper;
import com.numberONe.tempEntity.InvoiceInfo;

public interface ProviderInvoiceInfoMapper extends BaseMapper {

    int deleteByPrimaryKey(Integer id);

    int insert(InvoiceInfo record);

    int insertSelective(InvoiceInfo record);

    InvoiceInfo selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(InvoiceInfo record);

    int updateByPrimaryKey(InvoiceInfo record);
}