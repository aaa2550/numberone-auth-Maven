<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@include file="/common/common.jspf" %>
    <%--<script type="text/javascript" src="${ctx}/js/customer/customerRebatesInfo/add.js"></script>--%>
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
                    "customerRebatesInfoFormMap.startTime" : {
                        required : true
                    },
                    "customerRebatesInfoFormMap.endTime" : {
                        required : true
                    },
                    "customerRebatesInfoFormMap.rebates" : {
                        required : true
                    },
                    "customerRebatesInfoFormMap.contractId" : {
                        required : true
                    }
                },
                messages : {
                    "customerRebatesInfoFormMap.startTime" : {
                        required : "返点开始时间不能为空"
                    },
                    "customerRebatesInfoFormMap.endTime" : {
                        required : "返点结束时间不能为空"
                    },
                    "customerRebatesInfoFormMap.rebates" : {
                        required : "返点不能为空"
                    },
                    "customerRebatesInfoFormMap.contractId" : {
                        required : "请选择合同"
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
                if ('${customerRebatesInfo}') {
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
            $("#customerType").val("${customerRebatesInfo.customerType}");
            $("#businessType").val("${customerRebatesInfo.businessType}");
        }
    </script>
</head>
<body>
<div class="l_err" style="width: 100%; margin-top: 2px;"></div>
<form id="form" name="form" class="form-horizontal" method="post"
      action="${pageContext.request.contextPath}/customer/customerRebatesInfo/editEntity.shtml">
    <input type="hidden" class="form-control checkacc"
           value="${customerRebatesInfo.id}" name="customerRebatesInfoFormMap.id" id="id">
    <section class="panel panel-default">
        <div class="panel-body">
            <div class="form-group">
                <label class="col-sm-3 control-label">返点开始时间</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="返点开始时间" value="${customerRebatesInfo.startTime}" name="customerRebatesInfoFormMap.startTime"
                           id="startTime">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">返点结束时间</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="返点结束时间" value="${customerRebatesInfo.endTime}" name="customerRebatesInfoFormMap.endTime"
                           id="endTime">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">返点</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="返点" value="${customerRebatesInfo.rebates}" name="customerRebatesInfoFormMap.rebates"
                           id="rebates">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">对应合同</label>
                <select id="contractId" name="customerRebatesInfoFormMap.contractId" class="form-control m-b"
                        tabindex="-1">
                </select>
            </div>
        </div>
        <footer class="panel-footer text-right bg-light lter">
            <button type="submit" class="btn btn-success btn-s-xs">提交</button>
        </footer>
    </section>
</form>

</body>
</html>