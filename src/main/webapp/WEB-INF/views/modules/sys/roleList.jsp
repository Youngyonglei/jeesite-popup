]
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>角色管理</title>
    <meta name="decorator" content="default"/>
    <style>
        .bgRed{
            background-color:#d0f9b5 !important;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            $("tbody tr").click(function () {
                $("tbody tr td").removeClass("bgRed");
                $(this).children().toggleClass("bgRed");
            });
        });
        function page(n, s) {
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
        function addWindow(type, url) {
            if (type == 0) {
                $.jBox("iframe:${ctx}/sys/role/form", {
                    title: "添加",
                    width: 800,
                    height: 450,
                    buttons: {'关闭': true}
                });
            } else if (type == 1) {
                $.jBox("iframe:" + url, {
                    title: "修改",
                    width: 800,
                    height: 450,
                    buttons: {'关闭': true}
                });
            }
        }
        function choose(id,name) {
            $("#change").attr('onclick',"addWindow(1,'${ctx}/sys/role/form?id="+id+"')");
            $("#delete").attr('href',"${ctx}/sys/role/delete?id="+id);
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
    <li class="active"><a href="${ctx}/sys/role/">角色列表</a></li>
</ul>
<form:form id="searchForm" modelAttribute="role" action="${ctx}/sys/role/" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <ul class="ul-form">
        <li><label>角色名称：</label>
            <form:input path="name" htmlEscape="false" maxlength="64" class="input-medium"/>
        </li>
        <li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
        <shiro:hasPermission name="sys:role:edit"><li class="btns"><input onclick="addWindow(0,'')" class="btn btn-primary" type="button" value="添加"/></li></shiro:hasPermission>
        <shiro:hasPermission name="sys:role:edit"><li class="btns"><input id="change" class="btn btn-primary" type="button" onclick="nochoose()" value="修改"></li></shiro:hasPermission>
        <shiro:hasPermission name="sys:role:delete"><li class="btns"><a id="delete" class="btn btn-primary" href="javascript:void(0)" onclick="nochoose()">删除</a></li></shiro:hasPermission>
        <li class="clearfix"></li>
    </ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <tr>
        <th>角色名称</th>
        <%--<th>英文名称</th>--%>
        <%--<th>归属机构</th>--%>
        <th>数据范围</th>
        <%--<shiro:hasPermission name="sys:role:edit">--%>
            <%--<th>操作</th>--%>
        <%--</shiro:hasPermission></tr>--%>
    <c:forEach items="${list}" var="role">
        <tr onclick="choose('${role.id}','${role.name}')">
                <%--<td><a href="form?id=${role.id}">${role.name}</a></td>--%>
            <td><a onclick="addWindow(1,'${ctx}/sys/role/form?id=${role.id}')" href="javascript:void(0)">
                    ${role.name}
            </a></td>
            <%--<td><a href="form?id=${role.id}">${role.enname}</a></td>--%>
            <%--<td>${role.office.name}</td>--%>
            <td>${fns:getDictLabel(role.dataScope, 'sys_data_scope', '无')}</td>
            <%--<shiro:hasPermission name="sys:role:edit">--%>
                <%--<td>--%>
                    <%--<a href="${ctx}/sys/role/assign?id=${role.id}">分配</a>--%>
                    <%--<c:if test="${(role.sysData eq fns:getDictValue('是', 'yes_no', '1') && fns:getUser().admin)||!(role.sysData eq fns:getDictValue('是', 'yes_no', '1'))}">--%>
                        <%--<a href="${ctx}/sys/role/form?id=${role.id}">修改</a>--%>
                    <%--</c:if>--%>
                    <%--<a href="${ctx}/sys/role/delete?id=${role.id}"--%>
                       <%--onclick="return confirmx('确认要删除该角色吗？', this.href)">删除</a>--%>
                <%--</td>--%>
            <%--</shiro:hasPermission>--%>
        </tr>
    </c:forEach>
</table>
</body>
</html>