<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@include file="/common/common.jspf" %>
    <%--<script type="text/javascript" src="${ctx}/js/customer/customerInfo/add.js"></script>--%>
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
                    "customerContractInfoFormMap.customerType" : {
                        required : true,
                        digits: true
                    },
                    "customerContractInfoFormMap.businessType" : {
                        required : true,
                        digits: true
                    },
                    "customerContractInfoFormMap.contractCode" : {
                        required : true,
                    },
                    "customerContractInfoFormMap.statisticsShortName" : {
                        required : true,
                    },
                    "customerContractInfoFormMap.ourCompanyName" : {
                        required : true
                    },
                    "customerContractInfoFormMap.contractStartTime" : {
                        required : true
                    },
                    "customerContractInfoFormMap.contractEndTime" : {
                        required : true
                    },
                    "customerContractInfoFormMap.rebates" : {
                        required : true,
                        percent : true
                    },
                    "customerContractInfoFormMap.orderfrom" : {
                        required : true,
                        number: true
                    }
                },
                messages : {
                    "customerContractInfoFormMap.customerType" : {
                        required : "请选择客户类型",
                        digits: "请选择客户类型"
                    },
                    "customerContractInfoFormMap.businessType" : {
                        required : "业务类型不能为空",
                        digits: "请选择业务类型"
                    },
                    "customerContractInfoFormMap.contractCode" : {
                        required : "合同编号不能为空",
                    },
                    "customerContractInfoFormMap.statisticsShortName" : {
                        required : "统计简称不能为空",
                    },
                    "customerContractInfoFormMap.ourCompanyName" : {
                        required : "我方主体名称不能为空"
                    },
                    "customerContractInfoFormMap.contractStartTime" : {
                        required : "合同开始时间不能为空"
                    },
                    "customerContractInfoFormMap.contractEndTime" : {
                        required : "合同结束时间不能为空"
                    },
                    "customerContractInfoFormMap.rebates" : {
                        required : "返点不能为空",
                        digits: "返点为整数"
                    },
                    "customerContractInfoFormMap.orderfrom" : {
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
           value="${customerInfo.id}" name="customerContractInfoFormMap.id" id="id">
    <section class="panel panel-default">
        <div class="panel-body">
            <div class="form-group">
                <label class="col-sm-3 control-label">合同编号</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="合同编号" value="${customerContractInfo.contractCode}" name="customerContractInfoFormMap.contractCode"
                           id="contractCode">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">统计简称</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="统计简称" value="${customerContractInfo.statisticsShortName}" name="customerContractInfoFormMap.statisticsShortName"
                           id="statisticsShortName">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">我方主体名称</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="我方主体名称" value="${customerContractInfo.ourCompanyName}" name="customerContractInfoFormMap.ourCompanyName"
                           id="ourCompanyName">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">返点</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="返点" value="${customerContractInfo.rebates}" name="customerContractInfoFormMap.rebates"
                           id="rebates">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">账期（天）</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="合同编号" value="${customerContractInfo.orderfrom}" name="customerContractInfoFormMap.orderfrom"
                           id="orderfrom">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">客户类型</label>
                <div class="col-sm-9">
                    <select id="customerType" name="customerContractInfoFormMap.customerType" class="form-control m-b"
                            tabindex="-1">
                        <option selected value="0">------ 直客 ------</option>
                        <option value="1">------ 子客 ------</option>
                    </select>
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">业务类型</label>
                <div class="col-sm-9">
                    <select id="businessType" name="customerContractInfoFormMap.businessType" class="form-control m-b"
                            tabindex="-1">
                    </select>
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">合同起始时间</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="合同起始时间" onclick="WdatePicker()" value="${customerContractInfo.contractStartTime}" name="customerContractInfoFormMap.contractStartTime"
                           id="contractStartTime">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">合同结束时间</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="合同起始时间" onclick="WdatePicker()" value="${customerContractInfo.contractEndTime}" name="customerContractInfoFormMap.contractEndTime"
                           id="contractEndTime">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">备注</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="备注" value="${customerContractInfo.remark}" name="customerContractInfoFormMap.remark"
                           id="remark">
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