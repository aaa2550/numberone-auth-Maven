package com.numberONe.controller;


import javax.inject.Inject;

import com.numberONe.mapper.ProviderContractInfoMapper;
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
import com.numberONe.entity.ProviderContractInfoFormMap;
import com.numberONe.mapper.BusinessTypeMapper;
import com.numberONe.mapper.CityMapper;
import com.numberONe.mapper.ProviderContractInfoMapper;
import com.numberONe.plugin.PageView;
import com.numberONe.tempEntity.BusinessType;
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
@RequestMapping("/provider/providerContractInfo/")
public class ProviderContractInfoController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(ProviderContractInfoController.class);

    @Inject
    private ProviderContractInfoMapper providerContractInfoMapper;

    @Inject
    private BusinessTypeMapper businessTypeMapper;

    @Inject
	private CityMapper cityMapper;

	private static final String BUSINESS_PATH = Common.BACKGROUND_PATH + "/provider/providerContractInfo";
	
	@RequestMapping("list")
	public String listUI(Model model) throws Exception {
		//model.addAttribute("res", findByRes());
		return BUSINESS_PATH + "/list";
	}

	@ResponseBody
	@RequestMapping("findByPage")
	public PageView findByPage( String pageNow,
			String pageSize,String column,String sort) throws Exception {
        ProviderContractInfoFormMap providerContractInfoFormMap = getFormMap(ProviderContractInfoFormMap.class);
        String order = "";
        like("statisticsShortName", providerContractInfoFormMap);
        if(Common.isNotEmpty(column)){
            order = " order by "+column+" "+sort;
        }else{
            order = " order by id asc";
        }

        providerContractInfoFormMap.put("$orderby", order);
        providerContractInfoFormMap=toFormMap(providerContractInfoFormMap, pageNow, pageSize,providerContractInfoFormMap.getStr("orderby"));
        pageView.setRecords(TransformUtils.transformEnum(providerContractInfoMapper.findByPage(providerContractInfoFormMap)));//不调用默认分页,调用自已的mapper中findUserPage
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
            model.addAttribute("providerContractInfo", providerContractInfoMapper.findbyFrist("id", id, ProviderContractInfoFormMap.class));
        }
        return Common.BACKGROUND_PATH + "/provider/providerContractInfo/edit";
    }

    @ResponseBody
    @RequestMapping("editEntity")
    @SystemLog(module="供应商合同信息",methods="供应商合同信息-修改")//凡需要处理业务逻辑的.都需要记录操作日志
    public CodeMsg editEntity(Model model) throws Exception {
        ProviderContractInfoFormMap providerContractInfoFormMap = null;
        try {
            providerContractInfoFormMap = getFormMap(ProviderContractInfoFormMap.class);
            providerContractInfoFormMap.set("updateTime", TimeUtils.getDate());

            if (providerContractInfoFormMap.containsKey("businessType")) {
                Object businessTypeObj = providerContractInfoFormMap.get("businessType");
                BusinessType businessType = businessTypeMapper.selectByPrimaryKey(Integer.valueOf(businessTypeObj.toString()));
                providerContractInfoFormMap.set("businessTypeName", businessType.getName());
            }

            if(providerContractInfoFormMap.containsKey("id")){
                providerContractInfoMapper.editEntity(providerContractInfoFormMap);
            } else {
                providerContractInfoFormMap.set("createTime", TimeUtils.getDate());
                providerContractInfoMapper.addEntity(providerContractInfoFormMap);
            }
            return CodeMsg.SUCCESS;
        } catch (Throwable e) {
            logger.error("editEntity error.providerContractInfoFormMap=" + providerContractInfoFormMap, e);
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
    @SystemLog(module="供应商合同信息",methods="供应商合同信息-新增")//凡需要处理业务逻辑的.都需要记录操作日志
    public CodeMsg addEntity() throws Exception {
        ProviderContractInfoFormMap providerContractInfoFormMap = null;
        try {
            providerContractInfoFormMap = getFormMap(ProviderContractInfoFormMap.class);
            providerContractInfoFormMap.set("createTime", TimeUtils.getDate());
            providerContractInfoFormMap.set("updateTime", TimeUtils.getDate());
            providerContractInfoMapper.addEntity(providerContractInfoFormMap);
            return CodeMsg.SUCCESS;
        } catch (Throwable e) {
            logger.error("addEntity error.providerContractInfoFormMap=" + providerContractInfoFormMap, e);
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
    @SystemLog(module="供应商合同信息",methods="供应商合同信息-删除")//凡需要处理业务逻辑的.都需要记录操作日志
    public CodeMsg deleteEntity(Model model) throws Exception {
        try {
            String[] ids = getParaValues("ids");
            for (String id : ids) {
                providerContractInfoMapper.deleteByAttribute("id", id, ProviderContractInfoFormMap.class);
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
        ProviderContractInfoFormMap providerContractInfoFormMap = getFormMap(ProviderContractInfoFormMap.class);
        return CollectionUtils.isEmpty(providerContractInfoMapper.findByNames(providerContractInfoFormMap));
    }

}