package com.numberONe.controller;


import javax.inject.Inject;

import com.numberONe.entity.CustomerContractInfoFormMap;
import com.numberONe.mapper.CustomerContractInfoMapper;
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
import com.numberONe.entity.CustomerInfoFormMap;
import com.numberONe.mapper.CityMapper;
import com.numberONe.mapper.CustomerInfoMapper;
import com.numberONe.plugin.PageView;
import com.numberONe.tempEntity.City;
import com.numberONe.util.CodeMsg;
import com.numberONe.util.Common;
import com.numberONe.util.TimeUtils;
import com.numberONe.util.TransformUtils;


/**
 * 
 * @author numberONe 2014-11-19
 * @version 3.0v
 */
@Controller
@RequestMapping("/customer/customerContractInfo/")
public class CustomerContractInfoController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(CustomerContractInfoController.class);

    @Inject
    private CustomerContractInfoMapper customerContractInfoMapper;

    @Inject
	private CityMapper cityMapper;

	private static final String BUSINESS_PATH = Common.BACKGROUND_PATH + "/customer/customerContractInfo";
	
	@RequestMapping("list")
	public String listUI(Model model) throws Exception {
		//model.addAttribute("res", findByRes());
		return BUSINESS_PATH + "/list";
	}

	@ResponseBody
	@RequestMapping("findByPage")
	public PageView findByPage( String pageNow,
			String pageSize,String column,String sort) throws Exception {
        CustomerContractInfoFormMap customerContractInfoFormMap = getFormMap(CustomerContractInfoFormMap.class);
        String order = "";
        like("companyName", customerContractInfoFormMap);
        like("name", customerContractInfoFormMap);
        if(Common.isNotEmpty(column)){
            order = " order by "+column+" "+sort;
        }else{
            order = " order by id asc";
        }

        customerContractInfoFormMap.put("$orderby", order);
        customerContractInfoFormMap=toFormMap(customerContractInfoFormMap, pageNow, pageSize,customerContractInfoFormMap.getStr("orderby"));
        pageView.setRecords(TransformUtils.transformEnum(customerContractInfoMapper.findByPage(customerContractInfoFormMap)));//不调用默认分页,调用自已的mapper中findUserPage
        return pageView;
	}

    @RequestMapping("addUI")
    public String addUI(Model model) throws Exception {
        return BUSINESS_PATH + "/add";
    }

    @RequestMapping("editUI")
    public String editUI(Model model) throws Exception {
        String id = getPara("id");
        if(Common.isNotEmpty(id)){
            model.addAttribute("customerContractInfo", customerContractInfoMapper.findbyFrist("id", id, CustomerContractInfoFormMap.class));
        }
        return Common.BACKGROUND_PATH + "/customer/customerContractInfo/edit";
    }

    @ResponseBody
    @RequestMapping("editEntity")
    @SystemLog(module="客户信息",methods="客户信息-修改客户信息")//凡需要处理业务逻辑的.都需要记录操作日志
    public CodeMsg editEntity(Model model) throws Exception {
        CustomerContractInfoFormMap customerContractInfoFormMap = null;
        try {
            customerContractInfoFormMap = getFormMap(CustomerContractInfoFormMap.class);
            customerContractInfoFormMap.set("updateTime", TimeUtils.getDate());

            if (customerContractInfoFormMap.containsKey("province") && customerContractInfoFormMap.containsKey("city")) {
                Object provinceParam = customerContractInfoFormMap.get("province");
                Object cityParam = customerContractInfoFormMap.get("city");

                City province = cityMapper.selectByPrimaryKey(Integer.valueOf(provinceParam.toString()));
                City city = cityMapper.selectByPrimaryKey(Integer.valueOf(cityParam.toString()));
                customerContractInfoFormMap.set("provinceName", province.getName());
                customerContractInfoFormMap.set("cityName", city.getName());
            }

            if(customerContractInfoFormMap.containsKey("id")){
                customerContractInfoMapper.editEntity(customerContractInfoFormMap);
            } else {
                customerContractInfoFormMap.set("createTime", TimeUtils.getDate());
                customerContractInfoMapper.addEntity(customerContractInfoFormMap);
            }
            return CodeMsg.SUCCESS;
        } catch (Throwable e) {
            logger.error("editEntity error.customerContractInfoFormMap=" + customerContractInfoFormMap, e);
            return new CodeMsg(CodeMsg.ERROR_CODE, e.getMessage());
        }
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
    public CodeMsg addEntity() throws Exception {
        CustomerContractInfoFormMap customerContractInfoFormMap = null;
        try {
            customerContractInfoFormMap = getFormMap(CustomerContractInfoFormMap.class);
            customerContractInfoFormMap.set("createTime", TimeUtils.getDate());
            customerContractInfoFormMap.set("updateTime", TimeUtils.getDate());
            customerContractInfoMapper.addEntity(customerContractInfoFormMap);
            return CodeMsg.SUCCESS;
        } catch (Throwable e) {
            logger.error("addEntity error.customerContractInfoFormMap=" + customerContractInfoFormMap, e);
            return new CodeMsg(CodeMsg.ERROR_CODE, e.getMessage());
        }
    }

    /**
     * 根据ID删除
     *
     * @param model
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping("deleteEntity")
    @SystemLog(module="客户信息",methods="客户信息-删除客户信息")//凡需要处理业务逻辑的.都需要记录操作日志
    public CodeMsg deleteEntity(Model model) throws Exception {
        try {
            String[] ids = getParaValues("ids");
            for (String id : ids) {
                customerContractInfoMapper.deleteByAttribute("id", id, CustomerContractInfoFormMap.class);
            };
            return CodeMsg.SUCCESS;
        } catch (Throwable e) {
            logger.error("deleteEntity error.", e);
            return new CodeMsg(CodeMsg.ERROR_CODE, e.getMessage());
        }
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
        CustomerContractInfoFormMap customerContractInfoFormMap = getFormMap(CustomerContractInfoFormMap.class);
        return CollectionUtils.isEmpty(customerContractInfoMapper.findByNames(customerContractInfoFormMap));
    }

}