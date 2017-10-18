package com.numberONe.controller;


import javax.inject.Inject;

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
import com.numberONe.enums.DictionaryEnum;
import com.numberONe.mapper.BusinessTypeMapper;
import com.numberONe.mapper.CityMapper;
import com.numberONe.mapper.CustomerContractInfoMapper;
import com.numberONe.mapper.DictionaryMapper;
import com.numberONe.plugin.PageView;
import com.numberONe.tempEntity.Dictionary;
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
@RequestMapping("/dictionary")
public class DictionaryController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(DictionaryController.class);

    @Inject
    private DictionaryMapper dictionaryMapper;

    @Inject
	private CityMapper cityMapper;

	private static final String BUSINESS_PATH = Common.BACKGROUND_PATH + "/dictionary/dictionary";

    @ResponseBody
    @RequestMapping("/findByBusinessType")
    public CodeMsg findByBusinessType(Integer businessType) {
        try {
            List<Dictionary> dictionaries = dictionaryMapper.list(businessType);
            return success(dictionaries);
        } catch (Exception e) {
            logger.error("findByBusinessType error.", e);
            return error(e.getMessage());
        }
    }

    @ResponseBody
    @RequestMapping("/findByBusinessTypeIndex")
    public CodeMsg findByBusinessTypeIndex(Dictionary dictionary) {
        try {
            return success(dictionaryMapper.single(dictionary));
        } catch (Exception e) {
            logger.error("findByBusinessTypeIndex error.", e);
            return error(e.getMessage());
        }
    }

}