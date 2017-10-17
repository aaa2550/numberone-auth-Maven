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
                    "providerInfoFormMap.providerName" : {
                        required : true
                    },
                    "providerInfoFormMap.name" : {
                        required : true
                    },
                    "providerInfoFormMap.province" : {
                        required : true,
                        digits:true
                    },
                    "providerInfoFormMap.city" : {
                        required : true,
                        digits:true
                    },
                    "providerInfoFormMap.linkmanName" : {
                        required : true
                    },
                    "providerInfoFormMap.linkmanTel" : {
                        required : true
                    }
                },
                messages : {
                    "providerInfoFormMap.providerName" : {
                        required : "公司全称不能为空"
                    },
                    "providerInfoFormMap.name" : {
                        required: "简称不能为空"
                    },
                    "providerInfoFormMap.province" : {
                        required : "请选择省份",
                        digits: "请选择城市"
                    },
                    "providerInfoFormMap.city" : {
                        required : "请选择城市",
                        digits: "请选择城市"
                    },
                    "providerInfoFormMap.linkmanName" : {
                        required : "联系人不能为空"
                    },
                    "providerInfoFormMap.linkmanTel" : {
                        required : "联系电话不能为空"
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
            $("#province").change(function(){
                var data = CommnUtil.ajax(rootPath + "/provider/providerInfo/getCity.shtml?parentId=" + $(this).val(), null,"json");
                if (data != null && data.obj != null) {
                    var h = "<option>请选择</option>";
                    for ( var i = 0; i < data.obj.length; i++) {
                        h+="<option value='" + data.obj[i].id + "'>"+ data.obj[i].name + "</option>";
                    }
                    $("#city").html(h);
                } else {
                    layer.msg("获取菜单信息错误，请联系管理员！");
                }
            });
            var url = rootPath + '/provider/providerInfo/getCity.shtml?parentId=0';
            var data = CommnUtil.ajax(url, null,"json");
            if (data && data.code === 0 && data.obj) {
                var h = "<option>请选择</option>";
                for ( var i = 0; i < data.obj.length; i++) {
                    h+="<option value='" + data.obj[i].id + "'>"+ data.obj[i].name + "</option>";
                }
                $("#province").html(h);
                init();
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
            $("#providerType").val("${providerInfo.providerType}");
            $("#province").val("${providerInfo.province}");
            var data = CommnUtil.ajax(rootPath + "/provider/providerInfo/getCity.shtml?parentId=${providerInfo.province}", null,"json");
            if (data != null && data.obj != null) {
                var h = "<option>请选择</option>";
                for ( var i = 0; i < data.obj.length; i++) {
                    h+="<option value='" + data.obj[i].id + "'>"+ data.obj[i].name + "</option>";
                }
                $("#city").html(h);
                $("#city").val("${providerInfo.city}");
            } else {
                layer.msg("获取菜单信息错误，请联系管理员！");
            }
        }
    </script>
</head>
<body>
<div class="l_err" style="width: 100%; margin-top: 2px;"></div>
<form id="form" name="form" class="form-horizontal" method="post"
      action="${pageContext.request.contextPath}/provider/providerInfo/editEntity.shtml">
    <input type="hidden" class="form-control checkacc"
           value="${providerInfo.id}" name="providerInfoFormMap.id" id="id">
    <section class="panel panel-default">
        <div class="panel-body">
            <div class="form-group">
                <label class="col-sm-3 control-label">公司全称</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="公司全称" value="${providerInfo.companyName}" name="providerInfoFormMap.companyName"
                           id="companyName">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">公司简称</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="公司简称" value="${providerInfo.name}" name="providerInfoFormMap.name" id="name">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">联系人姓名</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="联系人姓名" value="${providerInfo.linkmanName}"
                           name="providerInfoFormMap.linkmanName" id="linkmanName">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">电话</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="电话" value="${providerInfo.linkmanTel}" name="providerInfoFormMap.linkmanTel"
                           id="linkmanTel">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">邮箱</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="邮箱" value="${providerInfo.email}" name="providerInfoFormMap.email" id="email">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">省份</label>
                <div class="col-sm-9">
                    <select id="province" value="${providerInfo.province}" name="providerInfoFormMap.province"
                            class="form-control m-b"
                            tabindex="-1">
                    </select>
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">城市</label>
                <div class="col-sm-9">
                    <select id="city" name="providerInfoFormMap.city" class="form-control m-b"
                            tabindex="-1">
                    </select>
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">详细地址</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="详细地址" value="${providerInfo.address}" name="providerInfoFormMap.address"
                           id="address">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">备注</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="备注" value="${providerInfo.remark}" name="providerInfoFormMap.remark"
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