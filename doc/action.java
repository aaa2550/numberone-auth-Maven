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

@Controller
@RequestMapping("/@[templateCode3]/@[templateCode1]/")
public class @[templateCode2]Controller extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(@[templateCode2]Controller.class);

    @Inject
    private @[templateCode2]Mapper @[templateCode1]Mapper;

    @Inject
	private CityMapper cityMapper;

	private static final String BUSINESS_PATH = Common.BACKGROUND_PATH + "/@[templateCode3]/@[templateCode1]";
	
	@RequestMapping("list")
	public String listUI(Model model) throws Exception {
		//model.addAttribute("res", findByRes());
		return BUSINESS_PATH + "/list";
	}

	@ResponseBody
	@RequestMapping("findByPage")
	public PageView findByPage( String pageNow,
			String pageSize,String column,String sort) throws Exception {
        @[templateCode2]FormMap @[templateCode1]FormMap = getFormMap(@[templateCode2]FormMap.class);
        String order = "";
        like("companyName", @[templateCode1]FormMap);
        like("name", @[templateCode1]FormMap);
        if(Common.isNotEmpty(column)){
            order = " order by "+column+" "+sort;
        }else{
            order = " order by id asc";
        }

        @[templateCode1]FormMap.put("$orderby", order);
        @[templateCode1]FormMap=toFormMap(@[templateCode1]FormMap, pageNow, pageSize,@[templateCode1]FormMap.getStr("orderby"));
        pageView.setRecords(TransformUtils.transformEnum(@[templateCode1]Mapper.findByPage(@[templateCode1]FormMap)));//不调用默认分页,调用自已的mapper中findUserPage
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
            model.addAttribute("@[templateCode1]", @[templateCode1]Mapper.findbyFrist("id", id, @[templateCode2]FormMap.class));
        }
        return Common.BACKGROUND_PATH + "/@[templateCode3]/@[templateCode1]/edit";
    }

    @ResponseBody
    @RequestMapping("editEntity")
    @SystemLog(module="客户信息",methods="客户信息-修改客户信息")//凡需要处理业务逻辑的.都需要记录操作日志
    public CodeMsg editEntity(Model model) throws Exception {
        @[templateCode2]FormMap @[templateCode1]FormMap = null;
        try {
            @[templateCode1]FormMap = getFormMap(@[templateCode2]FormMap.class);
            @[templateCode1]FormMap.set("updateTime", TimeUtils.getDate());

            if (@[templateCode1]FormMap.containsKey("province") && @[templateCode1]FormMap.containsKey("city")) {
                Object provinceParam = @[templateCode1]FormMap.get("province");
                Object cityParam = @[templateCode1]FormMap.get("city");

                City province = cityMapper.selectByPrimaryKey(Integer.valueOf(provinceParam.toString()));
                City city = cityMapper.selectByPrimaryKey(Integer.valueOf(cityParam.toString()));
                @[templateCode1]FormMap.set("provinceName", province.getName());
                @[templateCode1]FormMap.set("cityName", city.getName());
            }

            if(@[templateCode1]FormMap.containsKey("id")){
                @[templateCode1]Mapper.editEntity(@[templateCode1]FormMap);
            } else {
                @[templateCode1]FormMap.set("createTime", TimeUtils.getDate());
                @[templateCode1]Mapper.addEntity(@[templateCode1]FormMap);
            }
            return CodeMsg.SUCCESS;
        } catch (Throwable e) {
            logger.error("editEntity error.@[templateCode1]FormMap=" + @[templateCode1]FormMap, e);
            return new CodeMsg(CodeMsg.ERROR_CODE, e.getMessage());
        }
    }

    /**
     * 添加
     *
     * @return Map
     * @throws Exception
     */
    @RequestMapping("addEntity")
    @ResponseBody
    @SystemLog(module="客户信息",methods="客户信息-新增客户信息")//凡需要处理业务逻辑的.都需要记录操作日志
    public CodeMsg addEntity() throws Exception {
        @[templateCode2]FormMap @[templateCode1]FormMap = null;
        try {
            @[templateCode1]FormMap = getFormMap(@[templateCode2]FormMap.class);
            @[templateCode1]FormMap.set("createTime", TimeUtils.getDate());
            @[templateCode1]FormMap.set("updateTime", TimeUtils.getDate());
            @[templateCode1]Mapper.addEntity(@[templateCode1]FormMap);
            return CodeMsg.SUCCESS;
        } catch (Throwable e) {
            logger.error("addEntity error.@[templateCode1]FormMap=" + @[templateCode1]FormMap, e);
            return new CodeMsg(CodeMsg.ERROR_CODE, e.getMessage());
        }
    }

    /**
     * 根据ID删除
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
                @[templateCode1]Mapper.deleteByAttribute("id", id, @[templateCode2]FormMap.class);
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
            return success(@[templateCode1]Mapper.findByWhere(new @[templateCode2]FormMap()));
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
        @[templateCode2]FormMap @[templateCode1]FormMap = getFormMap(@[templateCode2]FormMap.class);
        return CollectionUtils.isEmpty(@[templateCode1]Mapper.findByNames(@[templateCode1]FormMap));
    }

}