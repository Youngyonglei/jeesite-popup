<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
            jQuery.validator.addMethod("stringMaxLength", function(value,element) {
                var length = value.length;
                for ( var i = 0; i < value.length; i++) {
                    if (value.charCodeAt(i) > 127) {
                        length++;
                    }
                }
                return this.optional(element) || (length <=20);
            }, $.validator.format("姓名不能超过10个字"));
            jQuery.validator.addMethod("formatLoginName", function(value,element) {
                var mobile = /^[a-zA-Z][a-zA-Z_0-9]{5,19}$/;
                return this.optional(element) || (mobile.test(value));
            }, $.validator.format("登录名必须以字母开头,可以包含数字和下划线"));
            jQuery.validator.addMethod("isMobile", function(value, element) {
                var length = value.length;
                var mobile = /^((1[0-9]{1})+\d{9})$/;
                return this.optional(element) || (length == 11 && mobile.test(value));
            }, "请输入有效的手机号");
            $("#inputForm").validate({
                rules: {
                    mobile:{isMobile:true},
                    email:{email:true},
                    loginName: {remote: "${ctx}/sys/user/checkLoginName?oldLoginName=" + encodeURIComponent('${user.loginName}'),formatLoginName:true},
					name:{stringMaxLength:true}
                },
                messages: {
                    loginName:{required:"用户名不能为空",minlength:"用户名必须在6-20个字",maxlength:"用户名必须在6-20个字",remote: "用户登录名已存在"},
					name:{required:"真实姓名不能为空",maxlength:"姓名不能超过10个字"},
                    newPassword:{required: "密码不能为空",minlength:"密码不能少于6位"},
                    mobile:{required:"请输入手机号"},
					email:{required:"请输入邮箱",email:"请输入有效的邮箱"},
                    roleIdList:{required:"请先添加角色"}
                },
                submitHandler: function(form){
                    $.ajax( {
                        url:$("#inputForm").attr('action'),
                        data:$("#inputForm").serialize(),
                        type:'post',
                        dataType:'json',
                        success:function(data) {
                            console.log(data);
                            if(data==true){
                                window.parent.location.reload()
                            }else{

                            }
                        }
                    });
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
	</ul><br/>
	<form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group hidden">
			<label class="control-label">头像:</label>
			<div class="controls">
				<form:hidden id="nameImage" path="photo" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="nameImage" type="images" uploadPath="/photo" selectMultiple="false" maxWidth="100" maxHeight="100"/>
			</div>
		</div>
		<div class="control-group hidden">
			<label class="control-label">归属公司:</label>
			<div class="controls">
                <sys:treeselect id="company" name="company.id" value="${user.company.id}" labelName="company.name" labelValue="${user.company.name}"
					title="公司" url="/sys/office/treeData?type=1" cssClass="required"/>
			</div>
		</div>
		<div class="control-group hidden">
			<label class="control-label">归属部门:</label>
			<div class="controls">
                <sys:treeselect id="office" name="office.id" value="${user.office.id}" labelName="office.name" labelValue="${user.office.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="required" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group hidden">
			<label class="control-label">工号:</label>
			<div class="controls">
				<form:input path="no" htmlEscape="false" maxlength="50" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">用户名:</label>
			<div class="controls">
				<c:if test="${empty user.id}">
					<input id="oldLoginName" name="oldLoginName" type="hidden" value="${user.loginName}">
					<form:input path="loginName" htmlEscape="false" minlength="6" maxlength="20" class="required" placeholder="请输入用户名"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</c:if>
				<c:if test="${not empty user.id}">
					<input id="oldLoginName" name="oldLoginName" type="hidden" value="${user.loginName}">
					<input path="loginName" htmlEscape="false" maxlength="50" type="hidden" class="required userName" placeholder="请输入用户名"/>
					<label class="lbl">${user.loginName}</label>
				</c:if>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">真实姓名:</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="20" class="" placeholder="请输入真实姓名(选填)"/>
				<%--<span class="help-inline"><font color="red">*</font> </span>--%>
			</div>
		</div>

		<div class="control-group hidden">
			<label class="control-label">密码:</label>
			<div class="controls">
				<input id="newPassword" name="newPassword" type="password" value="111111" maxlength="50" minlength="6" class="${empty user.id?'required':''}"/>
				<c:if test="${empty user.id}"><span class="help-inline"><font color="red">*</font> </span></c:if>
				<c:if test="${not empty user.id}"><span class="help-inline">若不修改密码，请留空。</span></c:if>
			</div>
		</div>
		<div class="control-group hidden">
			<label class="control-label">确认密码:</label>
			<div class="controls">
				<input id="confirmNewPassword" name="confirmNewPassword" type="password" value="111111" maxlength="50" minlength="6" equalTo="#newPassword"/>
				<c:if test="${empty user.id}"><span class="help-inline"><font color="red">*</font> </span></c:if>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">手机:</label>
			<div class="controls">
				<form:input path="mobile" htmlEscape="false" maxlength="100" class="" placeholder="请输入手机号码(选填)"/>
				<%--<span class="help-inline"><font color="red">*</font> </span>--%>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">邮箱:</label>
			<div class="controls">
				<form:input path="email" htmlEscape="false" maxlength="100" class="" placeholder="请输入邮箱(选填)"/>
				<%--<span class="help-inline"><font color="red">*</font> </span>--%>
			</div>
		</div>
		<div class="control-group hidden">
			<label class="control-label">电话:</label>
			<div class="controls">
				<form:input path="phone" htmlEscape="false" maxlength="100"/>
			</div>
		</div>
		<div class="control-group hidden">
			<label class="control-label">是否允许登录:</label>
			<div class="controls">
				<form:select path="loginFlag">
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> “是”代表此账号允许登录，“否”则表示此账号不允许登录</span>
			</div>
		</div>
		<div class="control-group hidden">
			<label class="control-label">用户类型:</label>
			<div class="controls">
				<form:select path="userType" class="input-xlarge">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('sys_user_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">用户角色:</label>
			<div class="controls">
				<form:radiobuttons path="roleIdList" items="${allRoles}" itemLabel="name" itemValue="id" htmlEscape="false" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group hidden">
			<label class="control-label">备注:</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="input-xlarge"/>
			</div>
		</div>
		<c:if test="${not empty user.id}">
			<div class="control-group hidden">
				<label class="control-label">创建时间:</label>
				<div class="controls">
					<label class="lbl"><fmt:formatDate value="${user.createDate}" type="both" dateStyle="full"/></label>
				</div>
			</div>
			<div class="control-group hidden">
				<label class="control-label">最后登陆:</label>
				<div class="controls">
					<label class="lbl">IP: ${user.loginIp}&nbsp;&nbsp;&nbsp;&nbsp;时间：<fmt:formatDate value="${user.loginDate}" type="both" dateStyle="full"/></label>
				</div>
			</div>
		</c:if>
		<c:if test="${empty user.id}">
			<div class="control-group">
				<label class="control-label">默认密码:</label>
				<div class="controls">
					<lable class="lbl">111111</lable>
				</div>
			</div>
		</c:if>
		<div class="form-actions">
			<shiro:hasPermission name="sys:user:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
		</div>
	</form:form>
</body>
</html>