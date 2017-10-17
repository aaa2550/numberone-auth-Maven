<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--<script type="text/javascript" src="${pageContext.request.contextPath}/js/customer/customerInfo/list.js"></script>--%>
<script type="text/javascript">
    var pageii = null;
    var grid = null;
    $(function() {

        grid = lyGrid({
            pagId : 'paging',
            l_column : [ {
                colkey : "id",
                name : "id",
            }, {
                colkey : "companyName",
                name : "公司全称",
                isSort:true,
            }, {
                colkey : "customerType",
                name : "类型",
                isSort:true,
            }, {
                colkey : "name",
                name : "公司简称"
            }, {
                name : "地址",
                renderData : function( rowindex ,data, rowdata, colkeyn) {
                    return rowdata.province + rowdata.city + rowdata.address;
                }
            }, {
                colkey : "linkmanName",
                name : "联系人"
            }, {
                colkey : "linkmanTel",
                name : "联系人电话"
            }, {
                colkey : "email",
                name : "邮箱"
            }, {
                colkey : "createTime",
                name : "时间",
                isSort:true,
                renderData : function(rowindex,data, rowdata, column) {
                    return new Date(data).format("yyyy-MM-dd hh:mm:ss");
                }
            }, {
                colkey : "remark",
                name : "备注"
            }, {
                name : "操作",
                renderData : function( rowindex ,data, rowdata, colkeyn) {
                    return "测试渲染函数";
                }
            } ],
            jsonUrl : rootPath + '/customer/customerInfo/findByPage.shtml',
            checkbox : true,
            serNumber : true
        });
        $("#search").click("click", function() {// 绑定查询按扭
            var searchParams = $("#searchForm").serializeJson();// 初始化传参数
            grid.setOptions({
                data : searchParams
            });
        });
        $("#addCustomerInfo").click("click", function() {
            addCustomerInfo();
        });
        $("#editCustomerInfo").click("click", function() {
            editCustomerInfo();
        });
        $("#deleteCustomerInfo").click("click", function() {
            deleteCustomerInfo();
        });
    });
    function editCustomerInfo() {
        var cbox = grid.getSelectedCheckbox();
        if (cbox.length > 1 || cbox == "") {
            layer.msg("只能选中一个");
            return;
        }
        pageii = layer.open({
            title : "编辑",
            type : 2,
            area : [ "600px", "80%" ],
            content : rootPath + '/customer/customerInfo/editUI.shtml?id=' + cbox
        });
    }
    function addCustomerInfo() {
        pageii = layer.open({
            title : "新增",
            type : 2,
            area : [ "600px", "80%" ],
            content : rootPath + '/customer/customerInfo/editUI.shtml'
        });
    }

    function deleteCustomerInfo() {
        var cbox = grid.getSelectedCheckbox();
        if (cbox == "") {
            layer.msg("请选择删除项！！");
            return;
        }
        layer.confirm('是否删除？', function(index) {
            var url = rootPath + '/customer/customerInfo/deleteEntity.shtml';
            var s = CommnUtil.ajax(url, {
                ids : cbox.join(",")
            }, "json");
            if (s == "success") {
                layer.msg('删除成功');
                grid.loadData();
            } else {
                layer.msg('删除失败');
            }
        });
    }
</script>
<div class="m-b-md">
    <form class="form-inline" role="form" id="searchForm"
          name="searchForm">
        <div class="form-group">
            <label class="control-label"> <span
                class="h4 font-thin v-middle">账号:</span></label> <input
            class="input-medium ui-autocomplete-input" id="accountName"
            name="userFormMap.accountName">
        </div>
        <a href="javascript:void(0)" class="btn btn-default" id="search">查询</a>
        <a href="javascript:grid.exportData('/user/export.shtml')" class="btn btn-info" id="search">导出excel</a>
    </form>
</div>
<header class="panel-heading">
    <div class="doc-buttons">
        <button type="button" id="addCustomerInfo" class="btn btn-primary marR10">新增</button>
        <button type="button" id="editCustomerInfo" class="btn btn-info marR10">修改</button>
        <button type="button" id="deleteCustomerInfo" class="btn btn-danger marR10">删除</button>
    </div>
</header>
<div class="table-responsive">
    <div id="paging" class="pagclass"></div>
</div>

<div class="table-responsive">
    <div id="paging2" class="pagclass"></div>
</div>
