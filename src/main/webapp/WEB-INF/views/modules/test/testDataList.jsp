<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>单表管理</title>
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
				$.jBox("iframe:${ctx}/test/testData/form", {
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
			$("#change").attr('onclick',"addWindow(1,'${ctx}/test/testData/form?id="+id+"')");
            $("#delete").attr('href',"${ctx}/test/testData/delete?id="+id);
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
		<li class="active"><a href="${ctx}/test/testData/">单表列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="testData" action="${ctx}/test/testData/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>归属用户：</label>
				<sys:treeselect id="user" name="user.id" value="${testData.user.id}" labelName="user.name" labelValue="${testData.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>归属部门：</label>
				<sys:treeselect id="office" name="office.id" value="${testData.office.id}" labelName="office.name" labelValue="${testData.office.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>归属区域：</label>
				<sys:treeselect id="area" name="area.id" value="${testData.area.id}" labelName="area.name" labelValue="${testData.area.name}"
					title="区域" url="/sys/area/treeData" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>性别：</label>
				<form:radiobuttons path="sex" items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li>
			<li><label>加入日期：</label>
				<input name="beginInDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${testData.beginInDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> - 
				<input name="endInDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${testData.endInDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<shiro:hasPermission name="test:testData:edit"><li class="btns"><input onclick="addWindow(0,'')" class="btn btn-primary" type="button" value="添加"/></li></shiro:hasPermission>
			<shiro:hasPermission name="test:testData:edit"><li class="btns"><input id="change" onclick="nochoose()" class="btn btn-primary" type="button" value="修改"/></li></shiro:hasPermission>
			<shiro:hasPermission name="test:testData:delete"><li class="btns"><a href="javascript:void(0)" class="btn btn-primary" onclick="nochoose()">删除</a></li></shiro:hasPermission>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>归属用户</th>
				<th>归属部门</th>
				<th>归属区域</th>
				<th>名称</th>
				<th>性别</th>
				<th>更新时间</th>
				<th>备注信息</th>

			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="testData">
			<tr  onclick="choose('${testData.id}','${testData.name}')">
				<td>
					${testData.user.name}
				</a></td>
				<td>
					${testData.office.name}
				</td>
				<td>
					${testData.area.name}
				</td>
				<td>
					${testData.name}
				</td>
				<td>
					${fns:getDictLabel(testData.sex, 'sex', '')}
				</td>
				<td>
					<fmt:formatDate value="${testData.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${testData.remarks}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>