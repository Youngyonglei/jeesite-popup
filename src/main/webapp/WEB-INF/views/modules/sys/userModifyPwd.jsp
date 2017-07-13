<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>修改密码</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
            jQuery.validator.addMethod("isInit", function(value, element) {
				if(value=="111111"){
				    return false;
				}else{
				    return true;
				}
            }, "不能修改为初始密码");
			$("#oldPassword").focus();
			$("#inputForm").validate({
				rules: {
                    password:{required:true,remote:"${ctx}/sys/user/checkPwd"},
                    newPassword:{required:true,remote:"${ctx}/sys/user/checkNewPwd",isInit:true}
				},
				messages: {
                    password:{required: "旧密码不能为空",minlength:"密码不能少于6位",remote:"旧密码错误"},
                    newPassword:{required: "密码不能为空",minlength:"密码不能少于6位",remote:"新密码不能和旧密码相同"},
					confirmNewPassword:{required: "密码不能为空",minlength:"密码不能少于6位",equalTo:"两次输入的密码不相同"}
				},
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<%--<li><a href="${ctx}/sys/user/info">个人信息</a></li>--%>
		<%--<li class="active"><a href="${ctx}/sys/user/modifyPwd">修改密码</a></li>--%>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/modifyPwd" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">旧密码:</label>
			<div class="controls">
				<input id="oldPassword" name="password" type="password" value="" maxlength="50" minlength="6" class="required" placeholder="请输入旧密码"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">新密码:</label>
			<div class="controls">
				<input id="newPassword" name="newPassword" type="password" value="" maxlength="50" minlength="6" class="required" placeholder="请输入新密码"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">确认新密码:</label>
			<div class="controls">
				<input id="confirmNewPassword" name="confirmNewPassword" type="password" value="" maxlength="50" minlength="6" class="required" equalTo="#newPassword" placeholder="请再次输入新密码"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>
		</div>
	</form:form>
</body>
</html>