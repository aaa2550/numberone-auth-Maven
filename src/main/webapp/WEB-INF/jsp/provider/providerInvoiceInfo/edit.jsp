<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@include file="/common/common.jspf" %>
    <%--<script type="text/javascript" src="${ctx}/js/provider/providerInfo/add.js"></script>--%>
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
                    "providerInvoiceInfoFormMap.companyId" : {
                        required : true
                    },
                    "providerInvoiceInfoFormMap.taxpayerCode" : {
                        required : true
                    },
                    "providerInvoiceInfoFormMap.title" : {
                        required : true
                    },
                    "providerInvoiceInfoFormMap.address" : {
                        required : true
                    },
                    "providerInvoiceInfoFormMap.tel" : {
                        required : true
                    },
                    "providerInvoiceInfoFormMap.openAccountBank" : {
                        required : true
                    },
                    "providerInvoiceInfoFormMap.accountCode" : {
                        required : true
                    }
                },
                messages : {
                    "providerInvoiceInfoFormMap.companyId" : {
                        required : "请选择所属公司"
                    },
                    "providerInvoiceInfoFormMap.taxpayerCode" : {
                        required : "纳税人识别号不能为空"
                    },
                    "providerInvoiceInfoFormMap.title" : {
                        required : "开票公司不能为空"
                    },
                    "providerInvoiceInfoFormMap.address" : {
                        required : "地址不能为空"
                    },
                    "providerInvoiceInfoFormMap.tel" : {
                        required : "电话不能为空"
                    },
                    "providerInvoiceInfoFormMap.openAccountBank" : {
                        required : "开户银行不能为空"
                    },
                    "providerInvoiceInfoFormMap.accountCode" : {
                        required : "银行账户号不能为空"
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
            initCustomerId();
        });

        function initCustomerId() {
            var url = rootPath + '/provider/providerInfo/findAll.shtml';
            var data = CommnUtil.ajax(url, null,"json");
            if (data && data.code === 0 && data.obj) {
                var h = "";
                for ( var i = 0; i < data.obj.length; i++) {
                    h+="<option value='" + data.obj[i].id + "'>"+ data.obj[i].name + "</option>";
                }
                $("#providerId").html(h);
                if ('${providerInvoiceInfo}') {
                    $("#providerId").val("${providerInvoiceInfo.providerId}");
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
      action="${pageContext.request.contextPath}/provider/providerInvoiceInfo/editEntity.shtml">
    <input type="hidden" class="form-control checkacc"
           value="${providerInfo.id}" name="providerInvoiceInfoFormMap.id" id="id">
    <section class="panel panel-default">
        <div class="panel-body">
            <div class="form-group">
                <label class="col-sm-3 control-label">所属公司</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="所属公司" value="${providerInvoiceInfo.companyId}" name="providerInvoiceInfoFormMap.companyId"
                           id="companyId">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">账户ID</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="账户ID" value="${providerInvoiceInfo.taxpayerCode}" name="providerInvoiceInfoFormMap.taxpayerCode"
                           id="taxpayerCode">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">账户ID</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="账户ID" value="${providerInvoiceInfo.title}" name="providerInvoiceInfoFormMap.title"
                           id="title">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">账户ID</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="账户ID" value="${providerInvoiceInfo.address}" name="providerInvoiceInfoFormMap.address"
                           id="address">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">账户ID</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="账户ID" value="${providerInvoiceInfo.tel}" name="providerInvoiceInfoFormMap.tel"
                           id="tel">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">账户ID</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="账户ID" value="${providerInvoiceInfo.openAccountBank}" name="providerInvoiceInfoFormMap.openAccountBank"
                           id="openAccountBank">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">账户ID</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="账户ID" value="${providerInvoiceInfo.accountCode}" name="providerInvoiceInfoFormMap.accountCode"
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