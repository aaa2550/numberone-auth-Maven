<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@include file="/common/common.jspf" %>
    <%--<script type="text/javascript" src="${ctx}/js/customer/bankAccountInfo/add.js"></script>--%>
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
    <script type="text/javascript">
        $(function() {
            // 异步加载所有菜单列表
            $("form").validate({
                submitHandler : function(form) {// 必须写在验证前面，否则无法ajax提交
                    ly.ajaxSubmit(form,{//验证新增是否成功
                        type : "post",
                        dataType : "json",
                        success : function(data) {
                            if (data.code == 0) {
                                layer.confirm('操作成功!是否关闭窗口?', function(index) {
                                    parent.grid.loadData();
                                    parent.layer.close(parent.pageii);
                                    return false;
                                });
                                $("#form")[0].reset();
                            } else {
                                layer.alert(data.msg, 3);
                            }
                        }
                    });
                },
                rules : {
                    "bankAccountInfoFormMap.companyId" : {
                        required : true
                    },
                    "bankAccountInfoFormMap.type" : {
                        required : true
                    },
                    "bankAccountInfoFormMap.accountName" : {
                        required : true
                    },
                    "bankAccountInfoFormMap.bankName" : {
                        required : true
                    },
                    "bankAccountInfoFormMap.accountCode" : {
                        required : true
                    }
                },
                messages : {
                    "bankAccountInfoFormMap.companyId" : {
                        required : "必须选择公司"
                    },
                    "bankAccountInfoFormMap.type" : {
                        required : "必须选择类型"
                    },
                    "bankAccountInfoFormMap.accountName" : {
                        required : "账户名称不能为空"
                    },
                    "bankAccountInfoFormMap.bankName" : {
                        required : "公司名称不能为空"
                    },
                    "bankAccountInfoFormMap.accountCode" : {
                        required : "账户号不能为空"
                    }
                },
                errorPlacement : function(error, element) {// 自定义提示错误位置
                    $(".l_err").css('display', 'block');
                    // element.css('border','3px solid #FFCCCC');
                    $(".l_err").html(error.html());
                },
                success : function(label) {// 验证通过后
                    $(".l_err").css('display', 'none');
                }
            });
            var url = rootPath + '/dictionary/findByBusinessType.shtml?businessType=1';
            var data = CommnUtil.ajax(url, null,"json");
            if (data && data.code === 0 && data.obj) {
                var h = "<option selected>请选择</option>";
                for ( var i = 0; i < data.obj.length; i++) {
                    h+="<option value='" + data.obj[i].businessTypeIndex + "'>"+ data.obj[i].businessTypeName + "</option>";
                }
                $("#businessType").html(h);
                if ('${bankAccountInfo}') {
                    init();
                }
            } else {
                layer.msg("获取菜单信息错误，请联系管理员！");
            }
        });

        function initServices() {
            var url = rootPath + '/dictionary/findByBusinessType.shtml?businessType=3';
            var data = CommnUtil.ajax(url, null,"json");
            if (data && data.code === 0 && data.obj) {
                var h = "";
                var services = "${keepmeAccountInfo.services}";
                for ( var i = 0; i < data.obj.length; i++) {
                    h+="<input type='checkbox' "+(services.indexOf("["+data.obj[i].businessTypeIndex+"]")>=0?"checked":"")+" value='"+data.obj[i].businessTypeIndex+"'/>"+data.obj[i].businessTypeName;
                }
            } else {
                layer.msg("获取菜单信息错误，请联系管理员！");
            }
        }

        function initPlatform() {
            var url = rootPath + '/dictionary/findByBusinessType.shtml?businessType=2';
            var data = CommnUtil.ajax(url, null,"json");
            if (data && data.code === 0 && data.obj) {
                var h = "<option selected>请选择</option>";
                for ( var i = 0; i < data.obj.length; i++) {
                    h+="<option value='" + data.obj[i].businessTypeIndex + "'>"+ data.obj[i].businessTypeName + "</option>";
                }
                $("#platform").html(h);
                if ('${keepmeAccountInfo}') {
                    $("#platform").val("${keepmeAccountInfo.platform}");
                }
            } else {
                layer.msg("获取菜单信息错误，请联系管理员！");
            }
        }
        function but(v){
            if (v.value==1) {
                $("#companyId").html("<option value='1'>点我公司</option>");
            } else {
                var url = "";
                if (v.value==2) {
                    url = rootPath + '/customer/customerInfo/findAll.shtml';
                } else {
                    url = rootPath + '/provider/providerInfo/findAll.shtml';
                }
                var data = CommnUtil.ajax(url, null,"json");
                if (data && data.code === 0 && data.obj) {
                    var h = "";
                    for ( var i = 0; i < data.obj.length; i++) {
                        h+="<option value='" + data.obj[i].id + "'>"+ data.obj[i].name + "</option>";
                    }
                    $("#companyId").html(h);
                    if ('${bankAccountInfo}') {
                        $("#companyId").val("${bankAccountInfo.companyId}");
                    }
                } else {
                    layer.msg("获取菜单信息错误，请联系管理员！");
                }
            }

            if(v.value==1){
                showBut();
            }else{
                $("#divbut").css("display","none");
            }
        }
        function toBut(b){
            $("#description").val($("#"+b.id).html());
        }
        function showBut(){
            $("#divbut").css("display","block");
            var url = rootPath + '/resources/findByButtom.shtml';
            var data = CommnUtil.ajax(url, null,"json");
            if (data != null) {
                var bb = $("#but");
                bb.html('');
                for ( var i = 0; i < data.length; i++) {
                    bb.append("<span onclick=\"toBut(this)\" id=\"span_"+data[i].id+"\">"+ data[i].buttom+"</span>");
                }
            } else {
                layer.msg("获取按扭列表失败！");
            }
        }
        function init() {
            if ('${bankAccountInfo}') {
                $("#type").val(${bankAccountInfo.type});
            } else {
                $("#type").val(1);
                but({value : ${bankAccountInfo.type}});
            }
        }
    </script>
</head>
<body>
<div class="l_err" style="width: 100%; margin-top: 2px;"></div>
<form id="form" name="form" class="form-horizontal" method="post"
      action="${pageContext.request.contextPath}/customer/bankAccountInfo/editEntity.shtml">
    <input type="hidden" class="form-control checkacc"
           value="${bankAccountInfo.id}" name="bankAccountInfoFormMap.id" id="id">
    <section class="panel panel-default">
        <div class="panel-body">
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">账户ID</label>
                <div class="col-sm-9">
                    <select id="type" name="bankAccountInfoFormMap.type" class="form-control m-b"
                            tabindex="-1" onclick="but(this)">
                        <option selected value="1">------ 我方 ------</option>
                        <option value="2">------ 客户 ------</option>
                        <option value="3">------ 供应商 ------</option>
                    </select>
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">公司</label>
                <div class="col-sm-9">
                    <select id="companyId" name="bankAccountInfoFormMap.companyId" class="form-control m-b"
                            tabindex="-1">
                    </select>
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">账户名称</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="账户名称" value="${bankAccountInfo.accountName}" name="bankAccountInfoFormMap.accountName"
                           id="accountName">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">公司名称</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="公司名称" value="${bankAccountInfo.bankName}" name="bankAccountInfoFormMap.bankName"
                           id="bankName">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">账户号</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="账户号" value="${bankAccountInfo.accountCode}" name="bankAccountInfoFormMap.accountCode"
                           id="accountCode">
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