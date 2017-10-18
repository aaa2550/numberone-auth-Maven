<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@include file="/common/common.jspf" %>
    <%--<script type="text/javascript" src="${ctx}/js/account/rechargeInfo/add.js"></script>--%>
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
                    "rechargeInfoFormMap.id" : {
                        required : true
                    },
                    "rechargeInfoFormMap.generalizeId" : {
                        required : true
                    },
                    "rechargeInfoFormMap.appId" : {
                        required : true
                    },
                    "rechargeInfoFormMap.customerId" : {
                        required : true
                    },
                    "rechargeInfoFormMap.providerId" : {
                        required : true
                    },
                    "rechargeInfoFormMap.ourRebates" : {
                        required : true
                    },
                    "rechargeInfoFormMap.customerRebates" : {
                        required : true
                    },
                    "rechargeInfoFormMap.accountRecharge" : {
                        required : true
                    },
                    "rechargeInfoFormMap.rebatesRecharge" : {
                        required : true
                    },
                    "rechargeInfoFormMap.rechargeCost" : {
                        required : true
                    }
                },
                messages : {
                    "rechargeInfoFormMap.id" : {
                        required : "id不能为空"
                    },
                    "rechargeInfoFormMap.generalizeId" : {
                        required : "推广账号ID不能为空"
                    },
                    "rechargeInfoFormMap.appId" : {
                        required : "APPID不能为空"
                    },
                    "rechargeInfoFormMap.customerId" : {
                        required : "必须选择客户公司"
                    },
                    "rechargeInfoFormMap.providerId" : {
                        required : "必须选择供应商"
                    },
                    "rechargeInfoFormMap.ourRebates" : {
                        required : "我方返点不能为空"
                    },
                    "rechargeInfoFormMap.customerRebates" : {
                        required : "客户方返点不能为空"
                    },
                    "rechargeInfoFormMap.accountRecharge" : {
                        required : "账户充值不能为空"
                    },
                    "rechargeInfoFormMap.rebatesRecharge" : {
                        required : "返点充值不能为空"
                    },
                    "rechargeInfoFormMap.rechargeCost" : {
                        required : "充值成本不能为空"
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
            initCustomer();
            initProviderId();

        });

        function initProviderId() {
            var url = rootPath + '/provider/providerInfo/findAll.shtml';
            var data = CommnUtil.ajax(url, null,"json");
            if (data && data.code === 0 && data.obj) {
                var h = "";
                var services = "${rechargeInfo.services}";
                for ( var i = 0; i < data.obj.length; i++) {
                    h+="<input type='checkbox' "+(services.indexOf("["+data.obj[i].id+"]")>=0?"checked":"")+" value='"+data.obj[i].id+"'/>"+data.obj[i].companyName;
                }
                $("#providerId").html(h);
                if ('${rechargeInfo}') {
                    $("#providerId").val("${rechargeInfo.providerId}");
                }
            } else {
                layer.msg("获取菜单信息错误，请联系管理员！");
            }
        }

        function initCustomer() {
            var url = rootPath + '/customer/customerInfo/findAll.shtml';
            var data = CommnUtil.ajax(url, null,"json");
            if (data && data.code === 0 && data.obj) {
                var h = "";
                var services = "${rechargeInfo.services}";
                for ( var i = 0; i < data.obj.length; i++) {
                    h+="<input type='checkbox' "+(services.indexOf("["+data.obj[i].id+"]")>=0?"checked":"")+" value='"+data.obj[i].id+"'/>"+data.obj[i].companyName;
                }
                $("#customerId").html(h);
                if ('${rechargeInfo}') {
                    $("#customerId").val("${rechargeInfo.customerId}");
                }
            } else {
                layer.msg("获取菜单信息错误，请联系管理员！");
            }
        }

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
    </script>
</head>
<body>
<div class="l_err" style="width: 100%; margin-top: 2px;"></div>
<form id="form" name="form" class="form-horizontal" method="post"
      action="${pageContext.request.contextPath}/account/rechargeInfo/editEntity.shtml">
    <input type="hidden" class="form-control checkacc"
           value="${rechargeInfo.id}" name="rechargeInfoFormMap.id" id="id">
    <section class="panel panel-default">
        <div class="panel-body">
            <div class="form-group">
                <label class="col-sm-3 control-label">APPID</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="APPID" value="${rechargeInfo.appId}" name="rechargeInfoFormMap.appId"
                           id="appId">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">推广账户ID</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="推广账户ID" value="${rechargeInfo.generalizeId}" name="rechargeInfoFormMap.generalizeId"
                           id="generalizeId">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">客户公司</label>
                <div class="col-sm-9">
                    <select id="customerId" name="rechargeInfoFormMap.customerId" class="form-control m-b"
                            tabindex="-1">
                    </select>
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">供应商</label>
                <div class="col-sm-9">
                    <select id="providerId" name="rechargeInfoFormMap.providerId" class="form-control m-b"
                            tabindex="-1">
                    </select>
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">我方返点</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="我方返点" value="${rechargeInfo.ourRebates}" name="rechargeInfoFormMap.ourRebates"
                           id="ourRebates">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">客户返点</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="客户返点" value="${rechargeInfo.customerRebates}" name="rechargeInfoFormMap.customerRebates"
                           id="customerRebates">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">账户充值</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="账户充值" value="${rechargeInfo.accountRecharge}" name="rechargeInfoFormMap.accountRecharge"
                           id="accountRecharge">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">返点充值</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="返点充值" value="${rechargeInfo.rebatesRecharge}" name="rechargeInfoFormMap.rebatesRecharge"
                           id="rebatesRecharge">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">充值成本</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="充值成本" value="${rechargeInfo.rechargeCost}" name="rechargeInfoFormMap.rechargeCost"
                           id="rechargeCost">
                </div>
            </div>
            <footer class="panel-footer text-right bg-light lter">
            <button type="submit" class="btn btn-success btn-s-xs">提交</button>
        </footer>
    </section>
</form>

</body>
</html>