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
	$("#editAccount").click("click", function() {
		editAccount();
	});
	$("#delAccount").click("click", function() {
		delAccount();
	});
	$("#permissions").click("click", function() {
		permissions();
	});
});
function editAccount() {
	var cbox = grid.getSelectedCheckbox();
	if (cbox.length > 1 || cbox == "") {
		layer.msg("只能选中一个");
		return;
	}
	pageii = layer.open({
		title : "编辑",
		type : 2,
		area : [ "600px", "80%" ],
		content : rootPath + '/user/editUI.shtml?id=' + cbox
	});
}
function addCustomerInfo() {
	pageii = layer.open({
		title : "新增",
		type : 2,
		area : [ "600px", "80%" ],
		content : rootPath + '/customer/customerInfo/addUI.shtml'
	});
}
function delAccount() {
	var cbox = grid.getSelectedCheckbox();
	if (cbox == "") {
		layer.msg("请选择删除项！！");
		return;
	}
	layer.confirm('是否删除？', function(index) {
		var url = rootPath + '/user/deleteEntity.shtml';
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
function permissions() {
	var cbox = grid.getSelectedCheckbox();
	if (cbox.length > 1 || cbox == "") {
		layer.msg("请选择一个对象！");
		return;
	}
	var url = rootPath + '/resources/permissions.shtml?userId='+cbox;
	pageii = layer.open({
		title : "分配权限",
		type : 2,
		area : [ "700px", "80%" ],
		content : url
	});
}