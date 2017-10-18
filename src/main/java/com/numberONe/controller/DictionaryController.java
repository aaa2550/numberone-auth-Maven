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
import com.numberONe.entity.DictionaryFormMap;
import com.numberONe.enums.DictionaryEnum;
import com.numberONe.mapper.BusinessTypeMapper;
import com.numberONe.mapper.CityMapper;
import com.numberONe.mapper.DictionaryMapper;
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
@RequestMapping("/system/dictionary")
public class DictionaryController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(DictionaryController.class);

	private static final String BUSINESS_PATH = Common.BACKGROUND_PATH + "/system/dictionary";

    @Inject
    private DictionaryMapper dictionaryMapper;

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

    @RequestMapping("list")
    public String listUI(Model model) throws Exception {
        //model.addAttribute("res", findByRes());
        return BUSINESS_PATH + "/list";
    }

    @ResponseBody
    @RequestMapping("findByPage")
    public PageView findByPage( String pageNow,
                                String pageSize,String column,String sort) throws Exception {
        DictionaryFormMap dictionaryFormMap = getFormMap(DictionaryFormMap.class);
        String order = "";
        like("statisticsShortName", dictionaryFormMap);
        if(Common.isNotEmpty(column)){
            order = " order by "+column+" "+sort;
        }else{
            order = " order by id asc";
        }

        dictionaryFormMap.put("$orderby", order);
        dictionaryFormMap=toFormMap(dictionaryFormMap, pageNow, pageSize,dictionaryFormMap.getStr("orderby"));
        pageView.setRecords(TransformUtils.transformEnum(dictionaryMapper.findByPage(dictionaryFormMap)));//不调用默认分页,调用自已的mapper中findUserPage
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
            model.addAttribute("dictionary", dictionaryMapper.findbyFrist("id", id, DictionaryFormMap.class));
        }
        return Common.BACKGROUND_PATH + "/customer/dictionary/edit";
    }

    @ResponseBody
    @RequestMapping("editEntity")
    @SystemLog(module="客户合同信息",methods="客户合同信息-修改")//凡需要处理业务逻辑的.都需要记录操作日志
    public CodeMsg editEntity(Model model) throws Exception {
        DictionaryFormMap dictionaryFormMap = null;
        try {
            dictionaryFormMap = getFormMap(DictionaryFormMap.class);
            dictionaryFormMap.set("updateTime", TimeUtils.getDate());

            if (dictionaryFormMap.containsKey("businessType")) {
                Object businessTypeObj = dictionaryFormMap.get("businessType");
                Dictionary dictionary = dictionaryMapper.single(new Dictionary(DictionaryEnum.业务类型.type, Integer.valueOf(businessTypeObj.toString())));
                dictionaryFormMap.set("businessTypeName", dictionary.getBusinessTypeName());
            }

            if(dictionaryFormMap.containsKey("id")){
                dictionaryMapper.editEntity(dictionaryFormMap);
            } else {
                dictionaryFormMap.set("createTime", TimeUtils.getDate());
                dictionaryMapper.addEntity(dictionaryFormMap);
            }
            return CodeMsg.SUCCESS;
        } catch (Throwable e) {
            logger.error("editEntity error.dictionaryFormMap=" + dictionaryFormMap, e);
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
        DictionaryFormMap dictionaryFormMap = null;
        try {
            dictionaryFormMap = getFormMap(DictionaryFormMap.class);
            dictionaryFormMap.set("createTime", TimeUtils.getDate());
            dictionaryFormMap.set("updateTime", TimeUtils.getDate());
            dictionaryMapper.addEntity(dictionaryFormMap);
            return CodeMsg.SUCCESS;
        } catch (Throwable e) {
            logger.error("addEntity error.dictionaryFormMap=" + dictionaryFormMap, e);
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
                dictionaryMapper.deleteByAttribute("id", id, DictionaryFormMap.class);
            };
            return CodeMsg.SUCCESS;
        } catch (Throwable e) {
            logger.error("deleteEntity error.", e);
            return new CodeMsg(CodeMsg.ERROR_CODE, e.getMessage());
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