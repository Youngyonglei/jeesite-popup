<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>子系统管理</title>
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
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		function addWindow(type,url){
			if(type==0){
				$.jBox("iframe:${ctx}/sys/subsystem/form", {
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
		function choose(id,name) {
			$("#change").attr('onclick',"addWindow(1,'${ctx}/sys/subsystem/form?id="+id+"')");
            $("#delete").attr('href',"${ctx}/sys/subsystem/delete?id="+id);
            $("#delete").attr('onclick',"return confirmx('确认要删除"+name+"吗？', this.href)");
        }
        function nochoose(){
            $.jBox("未选中！", {
                title: "提示"
            });
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/sys/subsystem/">子系统列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="subsystem" action="${ctx}/sys/subsystem/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>子系统：</label>
				<form:input path="name" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<shiro:hasPermission name="sys:subsystem:edit"><li class="btns"><input onclick="addWindow(0,'')" class="btn btn-primary" type="button" value="添加"/></li></shiro:hasPermission>
			<shiro:hasPermission name="sys:subsystem:edit"><li class="btns"><input id="change" onclick="nochoose()" class="btn btn-primary" type="button" value="修改"/></li></shiro:hasPermission>
			<shiro:hasPermission name="sys:subsystem:delete"><li class="btns"><a id="delete" href="javascript:void(0)" class="btn btn-primary" onclick="nochoose()">删除</a></li></shiro:hasPermission>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>子系统</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="subsystem">
			<tr  onclick="choose('${subsystem.id}','${subsystem.name}')">
				<td>
					${subsystem.name}
				</a></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>