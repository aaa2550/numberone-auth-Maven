package com.numberONe.controller;



import javax.inject.Inject;

import com.numberONe.annotation.SystemLog;
import com.numberONe.entity.CityFormMap;
import com.numberONe.entity.CustomerInfoFormMap;
import com.numberONe.mapper.CityMapper;
import com.numberONe.mapper.CustomerInfoMapper;
import com.numberONe.util.CodeMsg;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.numberONe.controller.index.BaseController;
import com.numberONe.plugin.PageView;
import com.numberONe.util.Common;

import java.util.Date;


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

    @Inject
	private CityMapper cityMapper;

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

    @RequestMapping("addUI")
    public String addUI(Model model) throws Exception {
        return BUSINESS_PATH + "/add";
    }

    /**
     * 添加客户信息
     *
     * @return Map
     * @throws Exception
     */
    @RequestMapping("addEntity")
    @ResponseBody
    @SystemLog(module="客户信息",methods="客户信息-新增客户信息")//凡需要处理业务逻辑的.都需要记录操作日志
    public String addEntity() throws Exception {
        CustomerInfoFormMap customerInfoFormMap = getFormMap(CustomerInfoFormMap.class);
        customerInfoFormMap.set("createTime", new Date());
        customerInfoFormMap.set("updateTime", new Date());
        customerInfoMapper.addEntity(customerInfoFormMap);
        return "success";
    }

    @ResponseBody
    @RequestMapping("getCity")
    public CodeMsg getCity(Integer parentId) throws Exception {
        CityFormMap cityFormMap = new CityFormMap();
        cityFormMap.put("where", " where pid = " + parentId);
        return new CodeMsg(CodeMsg.SUCCESS_CODE, "SUCCESS", cityMapper.findByWhere(cityFormMap));
    }

    @ResponseBody
    @RequestMapping("validate")
    public boolean validate() throws Exception {
        CustomerInfoFormMap customerInfoFormMap = getFormMap(CustomerInfoFormMap.class);
        return CollectionUtils.isEmpty(customerInfoMapper.findByNames(customerInfoFormMap));
    }

}