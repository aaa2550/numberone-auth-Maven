package com.numberONe.controller;



import javax.inject.Inject;

import com.numberONe.entity.CustomerInfoFormMap;
import com.numberONe.entity.LogFormMap;
import com.numberONe.mapper.CustomerInfoMapper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.numberONe.controller.index.BaseController;
import com.numberONe.plugin.PageView;
import com.numberONe.util.Common;

/**
 * 
 * @author numberONe 2014-11-19
 * @version 3.0v
 */
@Controller
@RequestMapping("/customer/customerInfo/")
public class CustomerInfoController extends BaseController {
	@Inject
	private CustomerInfoMapper customerInfoMapper;

	private static final String BUSINESS_PATH = Common.BACKGROUND_PATH + "/customer/customerInfo";
	
	@RequestMapping("list")
	public String listUI(Model model) throws Exception {
		//model.addAttribute("res", findByRes());
		return BUSINESS_PATH + "/list";
	}

	@ResponseBody
	@RequestMapping("findByPage")
	public PageView findByPage( String pageNow,
			String pageSize,String column,String sort) throws Exception {
        CustomerInfoFormMap customerInfoFormMap = getFormMap(CustomerInfoFormMap.class);
        String order = "";
        if(Common.isNotEmpty(column)){
            order = " order by "+column+" "+sort;
        }else{
            order = " order by id asc";
        }

        customerInfoFormMap.put("$orderby", order);
        customerInfoFormMap=toFormMap(customerInfoFormMap, pageNow, pageSize,customerInfoFormMap.getStr("orderby"));
        pageView.setRecords(customerInfoMapper.findByPage(customerInfoFormMap));//不调用默认分页,调用自已的mapper中findUserPage
        return pageView;
	}

}