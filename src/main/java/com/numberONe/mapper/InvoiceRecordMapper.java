package com.numberONe.mapper;

import com.numberONe.tempEntity.InvoiceRecord;

public interface InvoiceRecordMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(InvoiceRecord record);

    int insertSelective(InvoiceRecord record);

    InvoiceRecord selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(InvoiceRecord record);

    int updateByPrimaryKey(InvoiceRecord record);
}