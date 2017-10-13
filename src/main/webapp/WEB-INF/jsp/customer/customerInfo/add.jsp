<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/common/common.jspf"%>
<script type="text/javascript" src="${ctx}/js/customer/customerInfo/add.js"></script>
<style type="text/css">
#but button {
	margin-bottom: 5px;
	margin-right: 5px;
}
.col-sm-3 {
	width: 15%;
	float: left;
}

.col-sm-9 {
	width: 85%;
	float: left;
}

label[class^="btn btn-default"] {
	margin-top: -4px;
}
</style>
</head>
<body>
	<div class="l_err" style="width: 100%; margin-top: 2px;"></div>
	<form id="form" name="form" class="form-horizontal" method="post"
	action="${pageContext.request.contextPath}/resources/addEntity.shtml">
	<section class="panel panel-default">
		<div class="panel-body">
			<div class="form-group">
				<label class="col-sm-3 control-label">公司全称</label>
				<div class="col-sm-9">
					<input type="text" class="form-control checkacc"
						placeholder="公司全称" name="customerInfoFormMap.customerName" id="customerName">
				</div>
			</div>
			<div class="line line-dashed line-lg pull-in"></div>
			<div class="form-group">
				<label class="col-sm-3 control-label">公司简称</label>
				<div class="col-sm-9">
					<input type="text" class="form-control checkacc"
						placeholder="公司简称" name="customerInfoFormMap.name" id="name">
				</div>
			</div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">客户类型</label>
                <div class="col-sm-9">
                    <select id="type" name="customerInfoFormMap.type" class="form-control m-b"
                            tabindex="-1" onchange="but(this)">
                        <option value="0">------  直客  ------</option>
                        <option value="1">------  子客  ------</option>
                    </select>
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">联系人姓名</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="联系人姓名" name="customerInfoFormMap.linkmanName" id="linkmanName">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">电话</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="电话" name="customerInfoFormMap.linkmanTel" id="linkmanTel">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">邮箱</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="邮箱" name="customerInfoFormMap.email" id="email">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">省份</label>
                <div class="col-sm-9">
                    <select id="province" name="customerInfoFormMap.province" class="form-control m-b"
                            tabindex="-1">
                    </select>
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">城市</label>
                <div class="col-sm-9">
                    <select id="city" name="customerInfoFormMap.city" class="form-control m-b"
                            tabindex="-1">
                    </select>
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">详细地址</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="详细地址" name="customerInfoFormMap.address" id="address">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">备注</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="备注" name="customerInfoFormMap.remark" id="remark">
                </div>
            </div>
			<div class="line line-dashed line-lg pull-in"></div>
			<div class="form-group">
				<label class="col-sm-3 control-label">上级菜单</label>
				<div class="col-sm-9">
					<select id="parentId" name="resFormMap.parentId" class="form-control m-b"
						tabindex="-1">
					</select>
				</div>
			</div>
		</div>
		<footer class="panel-footer text-right bg-light lter">
		<button type="submit" class="btn btn-success btn-s-xs">提交</button>
		</footer> 
	</section>
</form>
</body>
</html>