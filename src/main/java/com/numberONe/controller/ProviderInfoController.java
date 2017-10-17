package com.numberONe.controller;


import javax.inject.Inject;

import com.numberONe.mapper.ProviderInfoMapper;
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
import com.numberONe.entity.ProviderInfoFormMap;
import com.numberONe.mapper.CityMapper;
import com.numberONe.mapper.ProviderInfoMapper;
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
@RequestMapping("/provider/providerInfo/")
public class ProviderInfoController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(ProviderInfoController.class);

    @Inject
    private ProviderInfoMapper providerInfoMapper;

    @Inject
	private CityMapper cityMapper;

	private static final String BUSINESS_PATH = Common.BACKGROUND_PATH + "/provider/providerInfo";
	
	@RequestMapping("list")
	public String listUI(Model model) throws Exception {
		//model.addAttribute("res", findByRes());
		return BUSINESS_PATH + "/list";
	}

	@ResponseBody
	@RequestMapping("findByPage")
	public PageView findByPage( String pageNow,
			String pageSize,String column,String sort) throws Exception {
        ProviderInfoFormMap providerInfoFormMap = getFormMap(ProviderInfoFormMap.class);
        String order = "";
        like("companyName", providerInfoFormMap);
        like("name", providerInfoFormMap);
        if(Common.isNotEmpty(column)){
            order = " order by "+column+" "+sort;
        }else{
            order = " order by id asc";
        }

        providerInfoFormMap.put("$orderby", order);
        providerInfoFormMap=toFormMap(providerInfoFormMap, pageNow, pageSize,providerInfoFormMap.getStr("orderby"));
        pageView.setRecords(TransformUtils.transformEnum(providerInfoMapper.findByPage(providerInfoFormMap)));//不调用默认分页,调用自已的mapper中findUserPage
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
            model.addAttribute("providerInfo", providerInfoMapper.findbyFrist("id", id, ProviderInfoFormMap.class));
        }
        return Common.BACKGROUND_PATH + "/provider/providerInfo/edit";
    }

    @ResponseBody
    @RequestMapping("editEntity")
    @SystemLog(module="供应商信息",methods="供应商信息-修改")//凡需要处理业务逻辑的.都需要记录操作日志
    public CodeMsg editEntity(Model model) throws Exception {
        ProviderInfoFormMap providerInfoFormMap = null;
        try {
            providerInfoFormMap = getFormMap(ProviderInfoFormMap.class);
            providerInfoFormMap.set("updateTime", TimeUtils.getDate());

            if (providerInfoFormMap.containsKey("province") && providerInfoFormMap.containsKey("city")) {
                Object provinceParam = providerInfoFormMap.get("province");
                Object cityParam = providerInfoFormMap.get("city");

                City province = cityMapper.selectByPrimaryKey(Integer.valueOf(provinceParam.toString()));
                City city = cityMapper.selectByPrimaryKey(Integer.valueOf(cityParam.toString()));
                providerInfoFormMap.set("provinceName", province.getName());
                providerInfoFormMap.set("cityName", city.getName());
            }

            if(providerInfoFormMap.containsKey("id")){
                providerInfoMapper.editEntity(providerInfoFormMap);
            } else {
                providerInfoFormMap.set("createTime", TimeUtils.getDate());
                providerInfoMapper.addEntity(providerInfoFormMap);
            }
            return CodeMsg.SUCCESS;
        } catch (Throwable e) {
            logger.error("editEntity error.providerInfoFormMap=" + providerInfoFormMap, e);
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
    @SystemLog(module="供应商信息",methods="供应商信息-新增")//凡需要处理业务逻辑的.都需要记录操作日志
    public CodeMsg addEntity() throws Exception {
        ProviderInfoFormMap providerInfoFormMap = null;
        try {
            providerInfoFormMap = getFormMap(ProviderInfoFormMap.class);
            providerInfoFormMap.set("createTime", TimeUtils.getDate());
            providerInfoFormMap.set("updateTime", TimeUtils.getDate());
            providerInfoMapper.addEntity(providerInfoFormMap);
            return CodeMsg.SUCCESS;
        } catch (Throwable e) {
            logger.error("addEntity error.providerInfoFormMap=" + providerInfoFormMap, e);
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
    @SystemLog(module="供应商信息",methods="供应商信息-删除")//凡需要处理业务逻辑的.都需要记录操作日志
    public CodeMsg deleteEntity(Model model) throws Exception {
        try {
            String[] ids = getParaValues("ids");
            for (String id : ids) {
                providerInfoMapper.deleteByAttribute("id", id, ProviderInfoFormMap.class);
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
        ProviderInfoFormMap providerInfoFormMap = getFormMap(ProviderInfoFormMap.class);
        return CollectionUtils.isEmpty(providerInfoMapper.findByNames(providerInfoFormMap));
    }

}