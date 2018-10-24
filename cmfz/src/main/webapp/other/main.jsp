<%@page contentType="text/html; UTF-8" isELIgnored="false" pageEncoding="UTF-8" %>
<html>
    <%--需要easyui相关文件--%>
    <head>
        <%--引入goeasy的js文件--%>
        <script src="http://cdn-hangzhou.goeasy.io/goeasy.js"></script>
        <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/themes/icon.css">
        <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/themes/default/easyui.css">
        <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/themes/IconExtension.css">
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.easyui.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/easyui-lang-zh_CN.js"></script>
        <script charset="utf-8" src="${pageContext.request.contextPath}/js/echarts.js"></script>
        <script charset="utf-8" src="${pageContext.request.contextPath}/js/china.js"></script>
        <script type="text/javascript">
            /*创建菜单栏*/
                $(function(){
                    //加载数据库中的菜单信息
                    $.post('${pageContext.request.contextPath}/menu/queryAll.do',function(menus){
                        //menus是一个一级菜单集合  每一个一级菜单都是手风琴的面板
                            $.each(menus,function (index,menu) {
                                //让面板的content展示二级菜单内容
                                  var content = "";
                                $.each(menu.children,function (index1,child) {
                                    //构建我们的content
                                    content+="<div class=\"easyui-linkbutton\" onclick=\"addTab('"+child.title+"','"+child.iconCls+"','"+child.href+"')\" data-options=\"iconCls:'"+child.iconCls+"'\" style=\"border:1px solid green;width:90%;margin:5 5 5 5\">"+child.title+"</div>";
                                })
                                //添加面板
                                $("#m").accordion("add",{
                                    title:menu.title,
                                    iconCls:menu.iconCls,
                                    content:content
                                })
                            })
                    },"JSON");
                });
                function addTab(title,iconCls,href){
                    //判断面板是否存在
                    if(!$("#tt").tabs('exists',title)){
                        //创建新的tab
                        $("#tt").tabs('add',{
                            title:title,
                            iconCls:iconCls,
                            href:"${pageContext.request.contextPath}/"+href,
                            closable:true
                        })
                    }else{
                        $("#tt").tabs('select',title);
                    }
                }
        </script>
    </head>
    <body class="easyui-layout">
        <div data-options="region:'north',split:true" style="height:60px;background-color:#5C160C ">
            <div style="font-size: 24px;color: white;font-family: 楷体;float: left;padding-top: 10px;padding-left: 20px">驰名法洲后台管理系统</div>
            <div style="font-size: 24px;color: white;font-family: 楷体;float: right;padding-top: 10px;padding-right: 20px">欢迎您:${sessionScope.username}
                <a class="easyui-linkbutton" data-options="iconCls:'icon-edit'" >修改密码</a>
                <a class="easyui-linkbutton" data-options="iconCls:'icon-edit'" >退出系统</a>
            </div>
        </div>
        <div data-options="region:'south',split:true" style="height:40px;background-color:#5C160C ">
            <div style="text-align: center;font-family: 楷体;color: white;font-size: 15px">&copy; 百知教育 yuxb@zparkhr.com.cn</div>
        </div>
        <div data-options="region:'west',title:'导航菜单',split:true" style="width:200px;">
            <div id="m" class="easyui-accordion" data-options="fit:true"></div>
        </div>
        <div data-options="region:'center'" >
            <div id="tt" class="easyui-tabs" data-options="fit:true,pill:true,narrow:true" >
                <div title="主页" data-options="iconCls:'icon-house'">
                    <img src="${pageContext.request.contextPath}/main/image/shouye.jpg" style="width: 100%;height: 100%;"/>
                </div>
            </div>
        </div>
    </body>
</html>
