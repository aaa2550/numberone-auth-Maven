package com.numberONe.controller;


import javax.inject.Inject;

import com.numberONe.entity.BusinessFormMap;
import com.numberONe.mapper.BusinessTypeMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.numberONe.annotation.SystemLog;
import com.numberONe.controller.index.BaseController;
import com.numberONe.entity.CityFormMap;
import com.numberONe.entity.CustomerContractInfoFormMap;
import com.numberONe.mapper.CityMapper;
import com.numberONe.mapper.CustomerContractInfoMapper;
import com.numberONe.plugin.PageView;
import com.numberONe.tempEntity.City;
import com.numberONe.util.CodeMsg;
import com.numberONe.util.Common;
import com.numberONe.util.TimeUtils;
import com.numberONe.util.TransformUtils;

import java.util.List;


/**
 * 
 * @author numberONe 2014-11-19
 * @version 3.0v
 */
@Controller
@RequestMapping("/business/businessType/")
public class BusinessController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(BusinessController.class);

    @Inject
    private BusinessTypeMapper businessTypeMapper;

	@ResponseBody
	@RequestMapping("findAll")
	public CodeMsg findAll() {
	    try {
            List<BusinessFormMap> businessFormMaps = businessTypeMapper.findByWhere(getFormMap(BusinessFormMap.class));
            return new CodeMsg(CodeMsg.SUCCESS_CODE, "SUCCESS", businessFormMaps);
	    } catch (Throwable e) {
	        logger.error("findAll error.", e);
	        return new CodeMsg(CodeMsg.ERROR_CODE, e.getMessage());
        }

	}

}