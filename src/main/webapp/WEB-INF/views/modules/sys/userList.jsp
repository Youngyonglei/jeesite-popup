<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
	<meta name="decorator" content="default"/>
	<style>
		.bgRed{
			background-color:#d0f9b5 !important;
		}
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
            $("tbody tr").click(function () {
                $("tbody tr td").removeClass("bgRed");
                $(this).children().toggleClass("bgRed");
            });
            $("#btnExport").click(function(){
                top.$.jBox.confirm("确认要导出用户数据吗？","系统提示",function(v,h,f){
                    if(v=="ok"){
                        $("#searchForm").attr("action","${ctx}/sys/user/export");
                        $("#searchForm").submit();
                    }
                },{buttonsFocus:1});
                top.$('.jbox-body .jbox-icon').css('top','55px');
            });
            $("#btnImport").click(function(){
                $.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true},
                    bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
            });
		});
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctx}/sys/user/list");
			$("#searchForm").submit();
	    	return false;
	    }
        function addWindow(type,url){
            if(type==0){
                $.jBox("iframe:${ctx}/sys/user/form", {
                    title: "添加",
                    width: 800,
                    height: 450,
                    buttons: { '关闭': true }
                });
            }else if(type==1){
                $.jBox("iframe:"+url, {
                    title: "修改",
                    width: 800,
                    height: 450,
                    buttons: { '关闭': true }
                });
            }
        }
        function choose(id,name,loginFlag) {
            $("#change").attr('onclick',"addWindow(1,'${ctx}/sys/user/form?id="+id+"')");
            $("#delete").attr('href',"${ctx}/sys/user/delete?id="+id);
            $("#delete").attr('onclick',"return confirmx('确认要删除"+name+"吗？<br/>删除后用户将不能登录！', this.href)");
            $("#updatepsw").attr('onclick',"return confirmx('确认要重置"+name+"的密码吗？', '${ctx}/sys/user/updatepsw?id="+id+"')");
          	if(loginFlag == 0){
                $("#loginflg").attr('onclick',"return confirmx('确认要激活账户"+name+"吗？', '${ctx}/sys/user/loginflg?id="+id+"')");
            }else if(loginFlag == 1){
                $("#loginflg").attr('onclick',"return confirmx('确认要冻结账户"+name+"吗？<br/>冻结后用户将不能登录！', '${ctx}/sys/user/loginflg?id="+id+"')");
            }
        }
        function nochoose(){
            $.jBox("未选中！", {
                title: "提示"
            });
        }
	</script>
</head>
<body>
	<div id="importBox" class="hide">
		<form id="importForm" action="${ctx}/sys/user/import" method="post" enctype="multipart/form-data"
			class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
			<input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　　
			<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
			<a href="${ctx}/sys/user/import/template">下载模板</a>
		</form>
	</div>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/sys/user/list">用户列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="user" action="${ctx}/sys/user/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>归属公司：</label><sys:treeselect id="company" name="company.id" value="${user.company.id}" labelName="company.name" labelValue="${user.company.name}"
				title="公司" url="/sys/office/treeData?type=1" cssClass="input-small" allowClear="true"/></li>
			<li><label>登录名：</label><form:input path="loginName" htmlEscape="false" maxlength="50" class="input-medium"/></li>
			<li class="clearfix"></li>
			<li><label>归属部门：</label><sys:treeselect id="office" name="office.id" value="${user.office.id}" labelName="office.name" labelValue="${user.office.name}"
				title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/></li>
			<li><label>姓&nbsp;&nbsp;&nbsp;名：</label><form:input path="name" htmlEscape="false" maxlength="50" class="input-medium"/></li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
				<%--<input id="btnExport" class="btn btn-primary" type="button" value="导出"/>--%>
				<%--<input id="btnImport" class="btn btn-primary" type="button" value="导入"/>--%>
			</li>

			<shiro:hasPermission name="sys:user:edit"><li class="btns"><input onclick="addWindow(0,'')" class="btn btn-primary" type="button" value="添加"/></li></shiro:hasPermission>
			<shiro:hasPermission name="sys:user:edit"><li class="btns"><input id="change" class="btn btn-primary" type="button" onclick="nochoose()" value="修改"></li></shiro:hasPermission>
			<shiro:hasPermission name="sys:user:delete"><li class="btns"><a id="delete" class="btn btn-primary" href="javascript:void(0)" onclick="nochoose()">删除</a></li></shiro:hasPermission>
			<shiro:hasPermission name="sys:user:edit"><li class="btns"><a id="loginflg" class="btn btn-primary" href="javascript:void(0)" onclick="nochoose()">冻结／激活</a></li></shiro:hasPermission>
			<shiro:hasPermission name="sys:user:edit"><li class="btns"><a id="updatepsw" class="btn btn-primary" href="javascript:void(0)" onclick="nochoose()">重置密码</a></li></shiro:hasPermission>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr>
			<%--<th class="sort-column login_name">登录名</th>--%>
			<th>登录名</th>
			<th>用户角色</th>
			<th>状态</th><th>真实姓名</th><th>手机号</th><th>邮箱</th><th>添加时间</th></tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="user">
			<tr onclick="choose('${user.id}','${user.name}','${user.loginFlag}')">
				<!--<td>${user.company.name}</td>
				<td>${user.office.name}</td>-->
				<td>
					${user.loginName}
				</td>
				<td>${user.rolename}</td>
				<td>${fns:getDictLabel(user.loginFlag,'user_status','')}</td>
				<td>${user.name}</td>
				<td>${user.mobile}</td>
				<td>${user.email}</td>
				<td><fmt:formatDate value="${user.createDate}" type="both"/></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>