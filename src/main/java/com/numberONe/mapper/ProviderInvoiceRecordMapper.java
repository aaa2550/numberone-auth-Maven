package com.numberONe.mapper;

import com.numberONe.mapper.base.BaseMapper;
import com.numberONe.tempEntity.InvoiceRecord;

public interface ProviderInvoiceRecordMapper extends BaseMapper {

    int deleteByPrimaryKey(Integer id);

    int insert(InvoiceRecord record);

    int insertSelective(InvoiceRecord record);

    InvoiceRecord selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(InvoiceRecord record);

    int updateByPrimaryKey(InvoiceRecord record);
}