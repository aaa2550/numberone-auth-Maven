package com.numberONe.controller;


import javax.inject.Inject;

import com.numberONe.mapper.KeepmeAccountInfoMapper;
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
import com.numberONe.entity.KeepmeAccountInfoFormMap;
import com.numberONe.mapper.BusinessTypeMapper;
import com.numberONe.mapper.CityMapper;
import com.numberONe.mapper.KeepmeAccountInfoMapper;
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
@RequestMapping("/account/keepmeAccountInfo/")
public class KeepmeAccountInfoController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(KeepmeAccountInfoController.class);

    @Inject
    private KeepmeAccountInfoMapper keepmeAccountInfoMapper;

    @Inject
    private BusinessTypeMapper businessTypeMapper;

    @Inject
	private CityMapper cityMapper;

	private static final String BUSINESS_PATH = Common.BACKGROUND_PATH + "/account/keepmeAccountInfo";
	
	@RequestMapping("list")
	public String listUI(Model model) throws Exception {
		//model.addAttribute("res", findByRes());
		return BUSINESS_PATH + "/list";
	}

	@ResponseBody
	@RequestMapping("findByPage")
	public PageView findByPage( String pageNow,
			String pageSize,String column,String sort) throws Exception {
        KeepmeAccountInfoFormMap keepmeAccountInfoFormMap = getFormMap(KeepmeAccountInfoFormMap.class);
        String order = "";
        like("statisticsShortName", keepmeAccountInfoFormMap);
        if(Common.isNotEmpty(column)){
            order = " order by "+column+" "+sort;
        }else{
            order = " order by id asc";
        }

        keepmeAccountInfoFormMap.put("$orderby", order);
        keepmeAccountInfoFormMap=toFormMap(keepmeAccountInfoFormMap, pageNow, pageSize,keepmeAccountInfoFormMap.getStr("orderby"));
        pageView.setRecords(TransformUtils.transformEnum(keepmeAccountInfoMapper.findByPage(keepmeAccountInfoFormMap)));//不调用默认分页,调用自已的mapper中findUserPage
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
            model.addAttribute("keepmeAccountInfo", keepmeAccountInfoMapper.findbyFrist("id", id, KeepmeAccountInfoFormMap.class));
        }
        return Common.BACKGROUND_PATH + "/account/keepmeAccountInfo/edit";
    }

    @ResponseBody
    @RequestMapping("editEntity")
    @SystemLog(module="客户合同信息",methods="客户合同信息-修改")//凡需要处理业务逻辑的.都需要记录操作日志
    public CodeMsg editEntity(Model model) throws Exception {
        KeepmeAccountInfoFormMap keepmeAccountInfoFormMap = null;
        try {
            keepmeAccountInfoFormMap = getFormMap(KeepmeAccountInfoFormMap.class);
            keepmeAccountInfoFormMap.set("updateTime", TimeUtils.getDate());

            if (keepmeAccountInfoFormMap.containsKey("businessType")) {
                Object businessTypeObj = keepmeAccountInfoFormMap.get("businessType");
                BusinessType businessType = businessTypeMapper.selectByPrimaryKey(Integer.valueOf(businessTypeObj.toString()));
                keepmeAccountInfoFormMap.set("businessTypeName", businessType.getName());
            }

            if(keepmeAccountInfoFormMap.containsKey("id")){
                keepmeAccountInfoMapper.editEntity(keepmeAccountInfoFormMap);
            } else {
                keepmeAccountInfoFormMap.set("createTime", TimeUtils.getDate());
                keepmeAccountInfoMapper.addEntity(keepmeAccountInfoFormMap);
            }
            return CodeMsg.SUCCESS;
        } catch (Throwable e) {
            logger.error("editEntity error.keepmeAccountInfoFormMap=" + keepmeAccountInfoFormMap, e);
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
        KeepmeAccountInfoFormMap keepmeAccountInfoFormMap = null;
        try {
            keepmeAccountInfoFormMap = getFormMap(KeepmeAccountInfoFormMap.class);
            keepmeAccountInfoFormMap.set("createTime", TimeUtils.getDate());
            keepmeAccountInfoFormMap.set("updateTime", TimeUtils.getDate());
            keepmeAccountInfoMapper.addEntity(keepmeAccountInfoFormMap);
            return CodeMsg.SUCCESS;
        } catch (Throwable e) {
            logger.error("addEntity error.keepmeAccountInfoFormMap=" + keepmeAccountInfoFormMap, e);
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
                keepmeAccountInfoMapper.deleteByAttribute("id", id, KeepmeAccountInfoFormMap.class);
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
        KeepmeAccountInfoFormMap keepmeAccountInfoFormMap = getFormMap(KeepmeAccountInfoFormMap.class);
        return CollectionUtils.isEmpty(keepmeAccountInfoMapper.findByNames(keepmeAccountInfoFormMap));
    }

}