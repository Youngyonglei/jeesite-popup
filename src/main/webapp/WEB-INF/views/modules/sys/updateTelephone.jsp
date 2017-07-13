<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>修改密码</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
            jQuery.validator.addMethod("isMobile", function(value, element) {
                var length = value.length;
                var mobile = /^((1[0-9]{1})+\d{9})$/;
                return this.optional(element) || (length == 11 && mobile.test(value));
            }, "请输入有效的手机号");
            $("#oldPassword").focus();
			$("#inputForm").validate({
				rules: {
                    password:{required:true,remote:"${ctx}/sys/user/checkPwd"},
                    telephone:{required:true,isMobile:true}
				},
				messages: {
                    password:{required: "密码不能为空",minlength:"密码不能少于6位",remote:"密码错误"},
                    telephone: {required: "手机号不能为空"}
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
		<%--<li class="active"><a href="${ctx}/sys/user/updateTelephone">修改密码</a></li>--%>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/updateTelephone" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">密码:</label>
			<div class="controls">
				<input id="password" name="password" type="password" value="" maxlength="50" minlength="6" class="required" placeholder="请输入密码"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">新手机号:</label>
			<div class="controls">
				<input id="telephone" name="telephone" type="text" value="" maxlength="50" class="required" placeholder="请输入要绑定的新手机号"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>
		</div>
	</form:form>
</body>
</html>