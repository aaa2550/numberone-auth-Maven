package com.numberONe.controller;



import javax.inject.Inject;

import com.numberONe.annotation.SystemLog;
import com.numberONe.entity.*;
import com.numberONe.mapper.CityMapper;
import com.numberONe.mapper.CustomerInfoMapper;
import com.numberONe.tempEntity.City;
import com.numberONe.util.CodeMsg;
import com.numberONe.util.TimeUtils;
import com.numberONe.util.TransformUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
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

    private static final Logger logger = LoggerFactory.getLogger(CustomerInfoController.class);

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
        like("companyName", customerInfoFormMap);
        like("name", customerInfoFormMap);
        if(Common.isNotEmpty(column)){
            order = " order by "+column+" "+sort;
        }else{
            order = " order by id asc";
        }

        customerInfoFormMap.put("$orderby", order);
        customerInfoFormMap=toFormMap(customerInfoFormMap, pageNow, pageSize,customerInfoFormMap.getStr("orderby"));
        pageView.setRecords(TransformUtils.transformEnum(customerInfoMapper.findByPage(customerInfoFormMap)));//不调用默认分页,调用自已的mapper中findUserPage
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
            model.addAttribute("customerInfo", customerInfoMapper.findbyFrist("id", id, CustomerInfoFormMap.class));
        }
        return Common.BACKGROUND_PATH + "/customer/customerInfo/edit";
    }

    @ResponseBody
    @RequestMapping("editEntity")
    @SystemLog(module="客户信息",methods="客户信息-修改客户信息")//凡需要处理业务逻辑的.都需要记录操作日志
    public CodeMsg editEntity(Model model) throws Exception {
        CustomerInfoFormMap customerInfoFormMap = null;
        try {
            customerInfoFormMap = getFormMap(CustomerInfoFormMap.class);
            customerInfoFormMap.set("updateTime", TimeUtils.getDate());

            if (customerInfoFormMap.containsKey("province") && customerInfoFormMap.containsKey("city")) {
                Object provinceParam = customerInfoFormMap.get("province");
                Object cityParam = customerInfoFormMap.get("city");

                City province = cityMapper.selectByPrimaryKey(Integer.valueOf(provinceParam.toString()));
                City city = cityMapper.selectByPrimaryKey(Integer.valueOf(cityParam.toString()));
                customerInfoFormMap.set("provinceName", province.getName());
                customerInfoFormMap.set("cityName", city.getName());
            }

            if(customerInfoFormMap.containsKey("id")){
                customerInfoMapper.editEntity(customerInfoFormMap);
            } else {
                customerInfoFormMap.set("createTime", TimeUtils.getDate());
                customerInfoMapper.addEntity(customerInfoFormMap);
            }
            return CodeMsg.SUCCESS;
        } catch (Throwable e) {
            logger.error("editEntity error.customerInfoFormMap=" + customerInfoFormMap, e);
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
        CustomerInfoFormMap customerInfoFormMap = null;
        try {
            customerInfoFormMap = getFormMap(CustomerInfoFormMap.class);
            customerInfoFormMap.set("createTime", TimeUtils.getDate());
            customerInfoFormMap.set("updateTime", TimeUtils.getDate());
            customerInfoMapper.addEntity(customerInfoFormMap);
            return CodeMsg.SUCCESS;
        } catch (Throwable e) {
            logger.error("addEntity error.customerInfoFormMap=" + customerInfoFormMap, e);
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
                customerInfoMapper.deleteByAttribute("id", id, CustomerInfoFormMap.class);
            };
            return CodeMsg.SUCCESS;
        } catch (Throwable e) {
            logger.error("deleteEntity error.", e);
            return new CodeMsg(CodeMsg.ERROR_CODE, e.getMessage());
        }
    }

    @ResponseBody
    @RequestMapping("findAll")
    public CodeMsg findAll() {
        try {
            return success(customerInfoMapper.findByWhere(new CustomerInfoFormMap()));
        } catch (Exception e) {
            logger.error("findAll error.", e);
            return error(e.getMessage());
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
        CustomerInfoFormMap customerInfoFormMap = getFormMap(CustomerInfoFormMap.class);
        return CollectionUtils.isEmpty(customerInfoMapper.findByNames(customerInfoFormMap));
    }

}