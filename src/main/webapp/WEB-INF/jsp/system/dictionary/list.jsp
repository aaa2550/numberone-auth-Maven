<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--<script type="text/javascript" src="${pageContext.request.contextPath}/js/system/dictionary/list.js"></script>--%>
<script type="text/javascript">
    var pageii = null;
    var grid = null;
    $(function() {

        grid = lyGrid({
            pagId : 'paging',
            l_column : [{
                colkey : "id",
                name : "id"
            },{
                colkey : "businessType",
                name : "业务类型"
            },{
                colkey : "businessName",
                name : "业务类型名称"
            },{
                colkey : "businessTypeIndex",
                name : "词典索引"
            },{
                colkey : "businessTypeName",
                name : "词典名称"
            }],
            jsonUrl : rootPath + '/customer/dictionary/findByPage.shtml',
            checkbox : true,
            serNumber : true
        });
        $("#search").click("click", function() {// 绑定查询按扭
            var searchParams = $("#searchForm").serializeJson();// 初始化传参数
            grid.setOptions({
                data : searchParams
            });
        });
        $("#add").click("click", function() {
            addFunction();
        });
        $("#edit").click("click", function() {
            editFunction();
        });
        $("#delete").click("click", function() {
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
            title : "编辑",
            type : 2,
            area : [ "600px", "80%" ],
            content : rootPath + '/system/dictionary/editUI.shtml?id=' + cbox
        });
    }
    function addFunction() {
        pageii = layer.open({
            title : "新增",
            type : 2,
            area : [ "600px", "80%" ],
            content : rootPath + '/system/dictionary/editUI.shtml'
        });
    }

    function deleteFunction() {
        var cbox = grid.getSelectedCheckbox();
        if (cbox == "") {
            layer.msg("请选择删除项！！");
            return;
        }
        layer.confirm('是否删除？', function(index) {
            var url = rootPath + '/system/dictionary/deleteEntity.shtml';
            var data = CommnUtil.ajax(url, {
                ids : cbox.join(",")
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
                class="h4 font-thin v-middle">统计简称:</span></label> <input
            class="input-medium ui-autocomplete-input" id="statisticsShortName"
            name="dictionaryFormMap.statisticsShortName">
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
