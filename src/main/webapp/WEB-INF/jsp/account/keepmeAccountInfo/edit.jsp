<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@include file="/common/common.jspf" %>
    <%--<script type="text/javascript" src="${ctx}/js/account/keepmeAccountInfo/add.js"></script>--%>
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
                    "keepmeAccountInfoFormMap.accountType" : {
                        required : true,
                        digits: true
                    },
                    "keepmeAccountInfoFormMap.businessType" : {
                        required : true,
                        digits: true
                    },
                    "keepmeAccountInfoFormMap.contractCode" : {
                        required : true,
                    },
                    "keepmeAccountInfoFormMap.statisticsShortName" : {
                        required : true,
                    },
                    "keepmeAccountInfoFormMap.ourCompanyName" : {
                        required : true
                    },
                    "keepmeAccountInfoFormMap.contractStartTime" : {
                        required : true
                    },
                    "keepmeAccountInfoFormMap.contractEndTime" : {
                        required : true
                    },
                    "keepmeAccountInfoFormMap.rebates" : {
                        required : true,
                        percent : true
                    },
                    "keepmeAccountInfoFormMap.orderfrom" : {
                        required : true,
                        number: true
                    }
                },
                messages : {
                    "keepmeAccountInfoFormMap.accountType" : {
                        required : "请选择客户类型",
                        digits: "请选择客户类型"
                    },
                    "keepmeAccountInfoFormMap.businessType" : {
                        required : "业务类型不能为空",
                        digits: "请选择业务类型"
                    },
                    "keepmeAccountInfoFormMap.contractCode" : {
                        required : "合同编号不能为空",
                    },
                    "keepmeAccountInfoFormMap.statisticsShortName" : {
                        required : "统计简称不能为空",
                    },
                    "keepmeAccountInfoFormMap.ourCompanyName" : {
                        required : "我方主体名称不能为空"
                    },
                    "keepmeAccountInfoFormMap.contractStartTime" : {
                        required : "合同开始时间不能为空"
                    },
                    "keepmeAccountInfoFormMap.contractEndTime" : {
                        required : "合同结束时间不能为空"
                    },
                    "keepmeAccountInfoFormMap.rebates" : {
                        required : "返点不能为空",
                        digits: "返点为整数"
                    },
                    "keepmeAccountInfoFormMap.orderfrom" : {
                        required : "账期不能为空",
                        digits: "账期为整数"
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
            var url = rootPath + '/business/businessType/findAll.shtml';
            var data = CommnUtil.ajax(url, null,"json");
            if (data && data.code === 0 && data.obj) {
                var h = "<option selected>请选择</option>";
                for ( var i = 0; i < data.obj.length; i++) {
                    h+="<option value='" + data.obj[i].id + "'>"+ data.obj[i].name + "</option>";
                }
                $("#businessType").html(h);
                if ('${keepmeAccountInfo}') {
                    init();
                }
            } else {
                layer.msg("获取菜单信息错误，请联系管理员！");
            }
        });
        function but(v){
            if(v.value==2){
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
            $("#accountType").val("${keepmeAccountInfo.accountType}");
            $("#businessType").val("${keepmeAccountInfo.businessType}");
        }
    </script>
</head>
<body>
<div class="l_err" style="width: 100%; margin-top: 2px;"></div>
<form id="form" name="form" class="form-horizontal" method="post"
      action="${pageContext.request.contextPath}/account/keepmeAccountInfo/editEntity.shtml">
    <input type="hidden" class="form-control checkacc"
           value="${keepmeAccountInfo.id}" name="keepmeAccountInfoFormMap.id" id="id">
    <section class="panel panel-default">
        <div class="panel-body">
            <div class="form-group">
                <label class="col-sm-3 control-label">APPID</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="APPID" value="${keepmeAccountInfo.appId}" name="keepmeAccountInfoFormMap.appId"
                           id="appId">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">账户ID</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="账户ID" value="${keepmeAccountInfo.keepmeAccounId}" name="keepmeAccountInfoFormMap.keepmeAccounId"
                           id="keepmeAccounId">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">账户名称</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="账户名称" value="${keepmeAccountInfo.keepmeAccountName}" name="keepmeAccountInfoFormMap.keepmeAccountName"
                           id="keepmeAccountName">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">QQ</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="QQ" value="${keepmeAccountInfo.qq}" name="keepmeAccountInfoFormMap.qq"
                           id="qq">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">行业</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="行业" value="${keepmeAccountInfo.industry}" name="keepmeAccountInfoFormMap.industry"
                           id="industry">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">推广链接</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="推广链接" value="${keepmeAccountInfo.generalizeLink}" name="keepmeAccountInfoFormMap.generalizeLink"
                           id="generalizeLink">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">投放平台</label>
                <div class="col-sm-9">
                    <select id="platform" name="keepmeAccountInfoFormMap.platform" class="form-control m-b"
                            tabindex="-1">
                    </select>
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">供应商</label>
                <div class="col-sm-9">
                    <select id="providerId" name="keepmeAccountInfoFormMap.providerId" class="form-control m-b"
                            tabindex="-1">
                    </select>
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">功能类型</label>
                <div class="col-sm-9" id="services">
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