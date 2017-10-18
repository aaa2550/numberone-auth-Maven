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
import com.numberONe.entity.CustomerInvoiceRecordFormMap;
import com.numberONe.enums.DictionaryEnum;
import com.numberONe.mapper.BusinessTypeMapper;
import com.numberONe.mapper.CityMapper;
import com.numberONe.mapper.CustomerInvoiceRecordMapper;
import com.numberONe.mapper.DictionaryMapper;
import com.numberONe.plugin.PageView;
import com.numberONe.tempEntity.Dictionary;
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
@RequestMapping("/customer/customerInvoiceRecord/")
public class CustomerInvoiceRecordController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(CustomerInvoiceRecordController.class);

    @Inject
    private CustomerInvoiceRecordMapper customerInvoiceRecordMapper;

    @Inject
    private BusinessTypeMapper businessTypeMapper;

    @Inject
    private DictionaryMapper dictionaryMapper;

    @Inject
	private CityMapper cityMapper;

	private static final String BUSINESS_PATH = Common.BACKGROUND_PATH + "/customer/customerInvoiceRecord";
	
	@RequestMapping("list")
	public String listUI(Model model) throws Exception {
		//model.addAttribute("res", findByRes());
		return BUSINESS_PATH + "/list";
	}

	@ResponseBody
	@RequestMapping("findByPage")
	public PageView findByPage( String pageNow,
			String pageSize,String column,String sort) throws Exception {
        CustomerInvoiceRecordFormMap customerInvoiceRecordFormMap = getFormMap(CustomerInvoiceRecordFormMap.class);
        String order = "";
        like("statisticsShortName", customerInvoiceRecordFormMap);
        if(Common.isNotEmpty(column)){
            order = " order by "+column+" "+sort;
        }else{
            order = " order by id asc";
        }

        customerInvoiceRecordFormMap.put("$orderby", order);
        customerInvoiceRecordFormMap=toFormMap(customerInvoiceRecordFormMap, pageNow, pageSize,customerInvoiceRecordFormMap.getStr("orderby"));
        pageView.setRecords(TransformUtils.transformEnum(customerInvoiceRecordMapper.findByPage(customerInvoiceRecordFormMap)));//不调用默认分页,调用自已的mapper中findUserPage
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
            model.addAttribute("customerInvoiceRecord", customerInvoiceRecordMapper.findbyFrist("id", id, CustomerInvoiceRecordFormMap.class));
        }
        return Common.BACKGROUND_PATH + "/customer/customerInvoiceRecord/edit";
    }

    @ResponseBody
    @RequestMapping("editEntity")
    @SystemLog(module="客户合同信息",methods="客户合同信息-修改")//凡需要处理业务逻辑的.都需要记录操作日志
    public CodeMsg editEntity(Model model) throws Exception {
        CustomerInvoiceRecordFormMap customerInvoiceRecordFormMap = null;
        try {
            customerInvoiceRecordFormMap = getFormMap(CustomerInvoiceRecordFormMap.class);
            customerInvoiceRecordFormMap.set("updateTime", TimeUtils.getDate());

            if (customerInvoiceRecordFormMap.containsKey("businessType")) {
                Object businessTypeObj = customerInvoiceRecordFormMap.get("businessType");
                Dictionary dictionary = dictionaryMapper.single(new Dictionary(DictionaryEnum.业务类型.type, Integer.valueOf(businessTypeObj.toString())));
                customerInvoiceRecordFormMap.set("businessTypeName", dictionary.getBusinessTypeName());
            }

            if(customerInvoiceRecordFormMap.containsKey("id")){
                customerInvoiceRecordMapper.editEntity(customerInvoiceRecordFormMap);
            } else {
                customerInvoiceRecordFormMap.set("createTime", TimeUtils.getDate());
                customerInvoiceRecordMapper.addEntity(customerInvoiceRecordFormMap);
            }
            return CodeMsg.SUCCESS;
        } catch (Throwable e) {
            logger.error("editEntity error.customerInvoiceRecordFormMap=" + customerInvoiceRecordFormMap, e);
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
    @SystemLog(module="客户合同信息",methods="客户合同信息-新增")//凡需要处理业务逻辑的.都需要记录操作日志
    public CodeMsg addEntity() throws Exception {
        CustomerInvoiceRecordFormMap customerInvoiceRecordFormMap = null;
        try {
            customerInvoiceRecordFormMap = getFormMap(CustomerInvoiceRecordFormMap.class);
            customerInvoiceRecordFormMap.set("createTime", TimeUtils.getDate());
            customerInvoiceRecordFormMap.set("updateTime", TimeUtils.getDate());
            customerInvoiceRecordMapper.addEntity(customerInvoiceRecordFormMap);
            return CodeMsg.SUCCESS;
        } catch (Throwable e) {
            logger.error("addEntity error.customerInvoiceRecordFormMap=" + customerInvoiceRecordFormMap, e);
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
    @SystemLog(module="客户合同信息",methods="客户合同信息-删除")//凡需要处理业务逻辑的.都需要记录操作日志
    public CodeMsg deleteEntity(Model model) throws Exception {
        try {
            String[] ids = getParaValues("ids");
            for (String id : ids) {
                customerInvoiceRecordMapper.deleteByAttribute("id", id, CustomerInvoiceRecordFormMap.class);
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
        CustomerInvoiceRecordFormMap customerInvoiceRecordFormMap = getFormMap(CustomerInvoiceRecordFormMap.class);
        return CollectionUtils.isEmpty(customerInvoiceRecordMapper.findByNames(customerInvoiceRecordFormMap));
    }

}