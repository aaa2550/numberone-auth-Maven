package com.numberONe.entity;

import com.numberONe.annotation.TableSeg;
import com.numberONe.util.FormMap;


/**
 * 客户信息表
 */
@TableSeg(tableName = "customer_info", id="id")
public class CustomerInfoFormMap extends FormMap<String,Object>{

	/**
	 *@descript
	 *@author numberONe
	 *@date 2015年3月29日
	 *@version 1.0
	 */
	private static final long serialVersionUID = 1L;

}
