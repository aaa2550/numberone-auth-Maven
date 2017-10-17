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
                            if (data == "success") {
                                layer.confirm('添加成功!是否关闭窗口?', function(index) {
                                    parent.grid.loadData();
                                    parent.layer.close(parent.pageii);
                                    return false;
                                });
                                $("#form")[0].reset();
                            } else {
                                layer.alert('添加失败！', 3);
                            }
                        }
                    });
                },
                rules : {
                    "customerInfoFormMap.customerName" : {
                        required : true,
                        remote : { // 异步验证是否存在
                            type : "POST",
                            url : rootPath + '/customer/customerInfo/validate.shtml',
                            data : {
                                name : function() {
                                    return $("#name").val();
                                }
                            }
                        }
                    },
                    "customerInfoFormMap.name" : {
                        required : true,
                        remote : { // 异步验证是否存在
                            type : "POST",
                            url : rootPath + '/customer/customerInfo/validate.shtml',
                            data : {
                                resKey : function() {
                                    return $("#resKey").val();
                                }
                            }
                        }
                    },
                    "customerInfoFormMap.province" : {
                        required : true,
                        digits:true
                    },
                    "customerInfoFormMap.city" : {
                        required : true,
                        digits:true
                    },
                    "customerInfoFormMap.linkmanName" : {
                        required : true
                    },
                    "customerInfoFormMap.linkmanTel" : {
                        required : true
                    }
                },
                messages : {
                    "customerInfoFormMap.customerName" : {
                        required : "公司全称不能为空",
                        remote : "该公司全称已经存在"
                    },
                    "customerInfoFormMap.name" : {
                        required : "简称不能为空",
                        remote : "该简称已经存在"
                    },
                    "customerInfoFormMap.province" : {
                        required : "请选择省份",
                        digits: "请选择城市"
                    },
                    "customerInfoFormMap.city" : {
                        required : "请选择城市",
                        digits: "请选择城市"
                    },
                    "customerInfoFormMap.linkmanName" : {
                        required : "联系人不能为空"
                    },
                    "customerInfoFormMap.linkmanTel" : {
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
                var data = CommnUtil.ajax(rootPath + "/customer/customerInfo/getCity.shtml?parentId=" + $(this).val(), null,"json");
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
            var url = rootPath + '/customer/customerInfo/getCity.shtml?parentId=0';
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
            $("#customerType").val("${customerInfo.customerType}");
            $("#province").val("${customerInfo.province}");
            var data = CommnUtil.ajax(rootPath + "/customer/customerInfo/getCity.shtml?parentId=${customerInfo.province}", null,"json");
            if (data != null && data.obj != null) {
                var h = "<option>请选择</option>";
                for ( var i = 0; i < data.obj.length; i++) {
                    h+="<option value='" + data.obj[i].id + "'>"+ data.obj[i].name + "</option>";
                }
                $("#city").html(h);
                $("#city").val("${customerInfo.city}");
            } else {
                layer.msg("获取菜单信息错误，请联系管理员！");
            }
        }
    </script>
</head>
<body>
<div class="l_err" style="width: 100%; margin-top: 2px;"></div>
<form id="form" name="form" class="form-horizontal" method="post"
      action="${pageContext.request.contextPath}/customer/customerInfo/editEntity.shtml">
    <input type="hidden" class="form-control checkacc"
           value="${customerInfo.id}" name="customerInfoFormMap.id" id="id">
    <section class="panel panel-default">
        <div class="panel-body">
            <div class="form-group">
                <label class="col-sm-3 control-label">公司全称</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="公司全称" value="${customerInfo.companyName}" name="customerInfoFormMap.companyName"
                           id="companyName">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">公司简称</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="公司简称" value="${customerInfo.name}" name="customerInfoFormMap.name" id="name">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">客户类型</label>
                <div class="col-sm-9">
                    <select id="customerType" name="customerInfoFormMap.customerType" class="form-control m-b"
                            tabindex="-1" onchange="but(this)">
                        <option value="0">------ 直客 ------</option>
                        <option value="1">------ 子客 ------</option>
                    </select>
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">联系人姓名</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="联系人姓名" value="${customerInfo.linkmanName}"
                           name="customerInfoFormMap.linkmanName" id="linkmanName">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">电话</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="电话" value="${customerInfo.linkmanTel}" name="customerInfoFormMap.linkmanTel"
                           id="linkmanTel">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">邮箱</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="邮箱" value="${customerInfo.email}" name="customerInfoFormMap.email" id="email">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">省份</label>
                <div class="col-sm-9">
                    <select id="province" value="${customerInfo.province}" name="customerInfoFormMap.province"
                            class="form-control m-b"
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
                           placeholder="详细地址" value="${customerInfo.address}" name="customerInfoFormMap.address"
                           id="address">
                </div>
            </div>
            <div class="line line-dashed line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">备注</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control checkacc"
                           placeholder="备注" value="${customerInfo.remark}" name="customerInfoFormMap.remark"
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