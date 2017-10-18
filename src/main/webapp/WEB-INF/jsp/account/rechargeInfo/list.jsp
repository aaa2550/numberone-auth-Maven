<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--<script type="text/javascript" src="${pageContext.request.contextPath}/js/account/rechargeInfo/list.js"></script>--%>
<script type="text/javascript">
    var pageii = null;
    var grid = null;
    $(function () {

        grid = lyGrid({
            pagId: 'paging',
            l_column: [{
                colkey : "id",
                name : "id",
            },{
                colkey : "createTime",
                name : "创建时间",
            },{
                colkey : "updateTime",
                name : "更新时间",
            },{
                colkey : "generalizeId",
                name : "推广账户ID",
            },{
                colkey : "appId",
                name : "APPID",
            },{
                colkey : "customerId",
                name : "客户ID",
            },{
                colkey : "customerName",
                name : "客户名称",
            },{
                colkey : "providerId",
                name : "供应商ID",
            },{
                colkey : "providerName",
                name : "供应商名称",
            },{
                colkey : "ourRebates",
                name : "我方返点",
            },{
                colkey : "customerRebates",
                name : "客户返点",
            },{
                colkey : "accountRecharge",
                name : "账户充值",
            },{
                colkey : "rebatesRecharge",
                name : "返点充值",
            },{
                colkey : "rechargeCost",
                name : "充值成本",
            }],
            jsonUrl: rootPath + '/account/rechargeInfo/findByPage.shtml',
            checkbox: true,
            serNumber: true
        });
        $("#search").click("click", function () {// 绑定查询按扭
            var searchParams = $("#searchForm").serializeJson();// 初始化传参数
            grid.setOptions({
                data: searchParams
            });
        });
        $("#add").click("click", function () {
            addFunction();
        });
        $("#edit").click("click", function () {
            editFunction();
        });
        $("#delete").click("click", function () {
            deleteFunction();
        });
    });
    function editFunction() {
        var cbox = grid.getSelectedCheckbox();
        if (cbox.length > 1 || cbox == "") {
            layer.msg("只能选中一个");
            return;
        }
        pageii = layer.open({
            title: "编辑",
            type: 2,
            area: ["600px", "80%"],
            content: rootPath + '/account/rechargeInfo/editUI.shtml?id=' + cbox
        });
    }
    function addFunction() {
        pageii = layer.open({
            title: "新增",
            type: 2,
            area: ["600px", "80%"],
            content: rootPath + '/account/rechargeInfo/editUI.shtml'
        });
    }

    function deleteFunction() {
        var cbox = grid.getSelectedCheckbox();
        if (cbox == "") {
            layer.msg("请选择删除项！！");
            return;
        }
        layer.confirm('是否删除？', function (index) {
            var url = rootPath + '/account/rechargeInfo/deleteEntity.shtml';
            var data = CommnUtil.ajax(url, {
                ids: cbox.join(",")
            }, "json");
            if (data.code == 0) {
                layer.msg('删除成功');
                grid.loadData();
            } else {
                layer.msg(data.msg);
            }
        });
    }
</script>
<div class="m-b-md">
    <form class="form-inline" role="form" id="searchForm"
          name="searchForm">
        <div class="form-group">
            <label class="control-label"> <span
                class="h4 font-thin v-middle">推广账号ID:</span></label> <input
            class="input-medium ui-autocomplete-input" id="generalizeId"
            name="rechargeInfoFormMap.generalizeId">
        </div>
        <div class="form-group">
            <label class="control-label"> <span
                class="h4 font-thin v-middle">APPID:</span></label> <input
            class="input-medium ui-autocomplete-input" id="appId"
            name="rechargeInfoFormMap.appId">
        </div>
        <div class="form-group">
            <label class="control-label"> <span
                class="h4 font-thin v-middle">客户名称:</span></label> <input
            class="input-medium ui-autocomplete-input" id="customerName"
            name="rechargeInfoFormMap.customerName">
        </div>
        <a href="javascript:void(0)" class="btn btn-default" id="search">查询</a>
    </form>
</div>
<header class="panel-heading">
    <div class="doc-buttons">
        <button type="button" id="add" class="btn btn-primary marR10">新增</button>
        <button type="button" id="edit" class="btn btn-info marR10">修改</button>
        <button type="button" id="delete" class="btn btn-danger marR10">删除</button>
        <a href="javascript:grid.exportData('/user/export.shtml')" class="btn btn-info" id="export">导出excel</a>
    </div>
</header>
<div class="table-responsive">
    <div id="paging" class="pagclass"></div>
</div>

<div class="table-responsive">
    <div id="paging2" class="pagclass"></div>
</div>
