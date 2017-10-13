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
					url : rootPath + '/resources/isExist.shtml',
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
					url : rootPath + '/resources/isExist.shtml',
					data : {
						resKey : function() {
							return $("#resKey").val();
						}
					}
				}
			},
            "customerInfoFormMap.province" : {
                required : true
            },
            "customerInfoFormMap.city" : {
                required : true
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
                required : "请选择省份"
            },
            "customerInfoFormMap.city" : {
                required : "请选择城市"
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
        data = JSON.parse(data);
        if (data != null && data.obj != null) {
            var h = "<option>请选择</option>";
            for ( var i = 0; i < data.obj.length; i++) {
                h+="<option value='" + data[i].id + "'>"+ data[i].name + "</option>";
            }
            $("#city").html(h);
        } else {
            layer.msg("获取菜单信息错误，请联系管理员！");
        }
    });
	var url = rootPath + '/customer/customerInfo/getCity.shtml?parentId=0';
	var data = CommnUtil.ajax(url, null,"json");
    if (data && data.code === 0 && data.obj) {
        alert(data.obj);
		var h = "<option>请选择</option>";
		for ( var i = 0; i < data.obj.length; i++) {
			h+="<option value='" + data[i].id + "'>"+ data[i].name + "</option>";
		}
        alert(h);
		$("#province").html(h);
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