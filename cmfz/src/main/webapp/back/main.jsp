<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>持名法州主页</title>
<link rel="stylesheet" type="text/css" href="../themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="../themes/IconExtension.css">
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.edatagrid.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/datagrid-detailview.js"></script>
    <script type="text/javascript">
        /*创建菜单栏*/
    $(function () {
        $.ajax({
            //加载数据库中的菜单信息
            url: "${pageContext.request.contextPath}/menu/queryAll.do",
            type: "post",
            dataType: "JSON",
            success: function (data) {
                $.each(data,function(index,first){
                    var c = "";

                    $.each(first.menus, function (index1, second) {
                        c+= "<p style='text-align: center'><a href='#' data-options=\"iconCls:'icon-search'\" class='easyui-linkbutton' onclick=\"addTabs('"+second.iconCls+"','"+second.title+"','"+second.href+"')\">"+second.title+"</a></p>";
                        console.log(second.title)
                    })

                    $('#aa').accordion('add', {
                        title: first.title,
                        content: c,
                        iconCls: first.iconCls,
                        selected: false
                    });
                })

            }
        })
    });
    function addTabs(iconCls,title,href) {
        /*创建选项卡*/
        var flag= $('#tt').tabs("exists",title)
        if(flag){
            $("#tt").tabs("select",title)
        }else{
            $('#tt').tabs('add',{
                title: title,
                selected: true,
                closable:true,
                href:"${pageContext.request.contextPath}"+href
            });
        }

    }

</script>

</head>
<body class="easyui-layout">
    <div data-options="region:'north',split:true" style="height:60px;background-color:  #5C160C">
    	<div style="font-size: 24px;color: #FAF7F7;font-family: 楷体;font-weight: 900;width: 500px;float:left;padding-left: 20px;padding-top: 10px" >持名法州后台管理系统</div>
    	<div style="font-size: 16px;color: #FAF7F7;font-family: 楷体;width: 300px;float:right;padding-top:15px">欢迎您:${sessionScope.username} &nbsp;<a href="${pageContext.request.contextPath}/other/admin.jsp" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">修改密码</a>&nbsp;&nbsp;<a href="${pageContext.request.contextPath}/admin/loginout.do" class="easyui-linkbutton" data-options="iconCls:'icon-01'">退出系统</a></div>
    </div>
    <div data-options="region:'south',split:true" style="height: 40px;background: #5C160C">
    	<div style="text-align: center;font-size:15px; color: #FAF7F7;font-family: 楷体" >&copy;百知教育 htf@zparkhr.com.cn</div>
    </div>

    <div data-options="region:'west',title:'导航菜单',split:true" style="width:220px;">
    	<div id="aa" class="easyui-accordion" data-options="fit:true">

        </div>
    </div>
    <div data-options="region:'center'">
    	<div id="tt" class="easyui-tabs" data-options="fit:true,narrow:true,pill:true">
		    <div title="主页" data-options="iconCls:'icon-neighbourhood',"  style="background-image:url(../main/image/shouye.jpg);background-repeat: no-repeat;background-size:100% 100%;">
                <img src="${pageContext.request.contextPath}/main/image/shouye.jpg" style="width: 100%;height: 100%;"/>
            </div>
		</div>
    </div>


</body>
</html>