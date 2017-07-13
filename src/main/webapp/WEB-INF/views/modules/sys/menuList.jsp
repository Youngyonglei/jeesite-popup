<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>菜单管理</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/treetable.jsp" %>
    <style>
        .bgRed{
            background-color:#d0f9b5 !important;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#treeTable").treeTable({expandLevel: 3}).show();
            $("tbody tr").click(function () {
                $("tbody tr td").removeClass("bgRed");
                $(this).children().toggleClass("bgRed");
            });
        });
        function updateSort() {
            loading('正在提交，请稍等...');
            $("#listForm").attr("action", "${ctx}/sys/menu/updateSort");
            $("#listForm").submit();
        }
        function page(n, s) {
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
        function addWindow(type, url) {
            if (type == 0) {
                $.jBox("iframe:${ctx}/sys/menu/form", {
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
            $("#change").attr('onclick',"addWindow(1,'${ctx}/sys/menu/form?id="+id+"')");
            $("#add").attr('onclick',"addWindow(1,'${ctx}/sys/menu/form?parent.id="+id+"')");
            $("#delete").attr('href',"${ctx}/sys/menu/delete?id="+id);
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
    <li class="active"><a href="${ctx}/sys/menu/">菜单列表</a></li>
</ul>
<form:form id="searchForm" modelAttribute="menu" action="${ctx}/sys/menu/" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <ul class="ul-form">
        <shiro:hasPermission name="sys:role:edit"><li class="btns"><input onclick="addWindow(0,'')" class="btn btn-primary" type="button" value="添加"/></li></shiro:hasPermission>
        <shiro:hasPermission name="sys:role:edit"><li class="btns"><input id="change" onclick="nochoose()" class="btn btn-primary" type="button" value="修改"/></li></shiro:hasPermission>
        <shiro:hasPermission name="sys:role:edit"><li class="btns"><input id="add" onclick="nochoose()" class="btn btn-primary" type="button" value="添加下级菜单"/></li></shiro:hasPermission>
        <shiro:hasPermission name="sys:role:delete"><li class="btns"><a id="delete" href="javascript:void(0)" class="btn btn-primary" onclick="nochoose()">删除</a></li></shiro:hasPermission>
        <li class="clearfix"></li>
    </ul>
</form:form>
<sys:message content="${message}"/>
<form id="listForm" method="post">
    <table id="treeTable" class="table table-striped table-bordered table-condensed hide">
        <thead>
        <tr>
            <th>菜单名称</th>
            <th>访问路径</th>
            <th style="text-align:center;">排序</th>
            <th>可见</th>
            <th>权限标识</th>
            <th>图标</th>
            <%--<shiro:hasPermission name="sys:menu:edit">--%>
                <%--<th>操作</th>--%>
            <%--</shiro:hasPermission></tr>--%>
        </thead>
        <tbody><c:forEach items="${list}" var="menu">
            <tr id="${menu.id}" pId="${menu.parent.id ne '1'?menu.parent.id:'0'}"  onclick="choose('${menu.id}','${menu.name}')" style="cursor:pointer">
                    <%--<td nowrap><i class="icon-${not empty menu.icon?menu.icon:' hide'}"></i><a href="${ctx}/sys/menu/form?id=${menu.id}">${menu.name}</a></td>--%>
                <td><a onclick="addWindow(1,'${ctx}/sys/menu/form?id=${menu.id}')" href="javascript:void(0)">
                        ${menu.name}
                <td title="${menu.href}">${fns:abbr(menu.href,30)}</td>
                <td style="text-align:center;">
                    <shiro:hasPermission name="sys:menu:edit">
                        <input type="hidden" name="ids" value="${menu.id}"/>
                        <input name="sorts" type="text" value="${menu.sort}"
                               style="width:50px;margin:0;padding:0;text-align:center;">
                    </shiro:hasPermission><shiro:lacksPermission name="sys:menu:edit">
                    ${menu.sort}
                </shiro:lacksPermission>
                </td>
                <td>${menu.isShow eq '1'?'显示':'隐藏'}</td>
                <td title="${menu.permission}">${fns:abbr(menu.permission,30)}</td>
                <td></td>
                <%--<shiro:hasPermission name="sys:menu:edit">--%>
                    <%--<td nowrap>--%>
                        <%--<a href="${ctx}/sys/menu/form?id=${menu.id}">修改</a>--%>
                        <%--<a href="${ctx}/sys/menu/delete?id=${menu.id}"--%>
                           <%--onclick="return confirmx('要删除该菜单及所有子菜单项吗？', this.href)">删除</a>--%>
                        <%--<a onclick="addWindow(1,'${ctx}/sys/menu/form?parent.id=${menu.id}')" href="javascript:void(0)">添加下级菜单</a>--%>
                    <%--</td>--%>
                <%--</shiro:hasPermission>--%>
            </tr>
        </c:forEach></tbody>
    </table>
    <shiro:hasPermission name="sys:menu:edit">
        <div class="form-actions pagination-left">
            <input id="btnSubmit" class="btn btn-primary" type="button" value="保存排序" onclick="updateSort();"/>
        </div>
    </shiro:hasPermission>
</form>
</body>
</html>