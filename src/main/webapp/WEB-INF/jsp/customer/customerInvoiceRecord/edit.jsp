<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@include file="/common/common.jspf" %>
    <%--<script type="text/javascript" src="${ctx}/js/customer/customerInvoiceRecord/add.js"></script>--%>
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
                    "customerInvoiceInfoFormMap.invoiceInfoId" : {
                        required : true
                    },
                    "customerInvoiceInfoFormMap.applyName" : {
                        required : true
                    },
                    "customerInvoiceInfoFormMap.customerId" : {
                        required : true
                    },
                    "customerInvoiceInfoFormMap.money" : {
                        required : true
                    },
                    "customerInvoiceInfoFormMap.platform" : {
                        required : true
                    },
                    "customerInvoiceInfoFormMap.payTime" : {
                        required : true
                    },
                    "customerInvoiceInfoFormMap.invoiceCode" : {
                        required : true
                    },
                    "customerInvoiceInfoFormMap.openTime" : {
                        required : true
                    }
                },
                messages : {
                    "customerInvoiceInfoFormMap.invoiceInfoId" : {
                        required : "发票信息表ID不能为空"
                    },
                    "customerInvoiceInfoFormMap.applyName" : {
                        required : "申请人姓名不能为空"
                    },
                    "customerInvoiceInfoFormMap.customerId" : {
                        required : "请选择被开票公司"
                    },
                    "customerInvoiceInfoFormMap.money" : {
                        required : "金额不能为空"
                    },
                    "customerInvoiceInfoFormMap.platform" : {
                        required : "投放平台不能为空"
                    },
                    "customerInvoiceInfoFormMap.payTime" : {
                        required : "费用发生日期不能为空"
                    },
                    "customerInvoiceInfoFormMap.invoiceCode" : {
                        required : "发票号不能为空"
                    },
                    "customerInvoiceInfoFormMap.openTime" : {
                        required : "开票日期不能为空"
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
                if ('${customerContractInfo}') {
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
            $("#customerType").val("${customerContractInfo.customerType}");
            $("#businessType").val("${customerContractInfo.businessType}");
        }
    </script>
</head>
<body>
<div class="l_err" style="width: 100%; margin-top: 2px;"></div>
<form id="form" name="form" class="form-horizontal" method="post"
      action="${pageContext.request.contextPath}/customer/customerContractInfo/editEntity.shtml">
    <input type="hidden" class="form-control checkacc"
           value="${customerInvoiceRecord.id}" name="customerContractInfoFormMap.id" id="id">
    <section class="panel panel-default">
        <div class="panel-body">
            <div class="form-group">
                <label class="col-sm-3 control-label">发票信息</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="发票信息" value="${customerInvoiceInfo.invoiceInfoId}" name="customerInvoiceInfoFormMap.invoiceInfoId"
                           id="invoiceInfoId">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">申请人</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="申请人" value="${customerInvoiceInfo.applyName}" name="customerInvoiceInfoFormMap.applyName"
                           id="applyName">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">开票公司</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="开票公司" value="${customerInvoiceInfo.customerId}" name="customerInvoiceInfoFormMap.customerId"
                           id="customerId">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">金额</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="金额" value="${customerInvoiceInfo.money}" name="customerInvoiceInfoFormMap.money"
                           id="money">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">投放平台</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="投放平台" value="${customerInvoiceInfo.platform}" name="customerInvoiceInfoFormMap.platform"
                           id="platform">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">费用发生日期</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="费用发生日期" value="${customerInvoiceInfo.payTime}" name="customerInvoiceInfoFormMap.payTime"
                           id="payTime">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">发票号</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="发票号" value="${customerInvoiceInfo.invoiceCode}" name="customerInvoiceInfoFormMap.invoiceCode"
                           id="invoiceCode">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">开票日期</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="开票日期" value="${customerInvoiceInfo.openTime}" name="customerInvoiceInfoFormMap.openTime"
                           id="openTime">
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