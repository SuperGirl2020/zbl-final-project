<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.easyui.min.js"></script>
    <title>音频列表</title>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/js/themes/icon.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/js/themes/default/easyui.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/js/IconExtension.css">
</head>
<body>

<table id="musicdg${param.aid }"></table>
<div id="addmusicdiv${param.aid }" style="width: 350px;height: 300px;display: none">
    <form id="musicaddform${param.aid }" method="post" enctype="multipart/form-data">
        <div style="font-family: 楷体;font-size: 30px;color: blue;position: absolute;left: 85px;top: 55px;">
            添加音频信息
        </div>
        <div style="position: absolute;top: 120px;left: 45px;">
            <input class="easyui-textbox" name="name" style="width: 250px;" data-options="label:'歌名',labelWidth:'40px'">
        </div>
        <input type="hidden" value="${param.aid }" name="album.id">
        <input type="hidden" value="${param.count }" name="album.count">
        <div style="position: absolute;top: 170px;left: 45px;">
            <input class="easyui-filebox" name="musicfile" style="width: 250px;" data-options="label:'音频',labelWidth:'40px',buttonText:'选择音频'">
        </div>
        <div style="position: absolute;top: 230px;left: 145px;" >
            <a id="musicaddsub${param.aid }" style="width: 80px;height: 27px;" class="easyui-linkbutton" data-options="text:'提交',iconCls:'icon-image_star'"></a>
            <a id="musicaddclo${param.aid }" style="width: 80px;height: 27px;margin-left: 10px;" class="easyui-linkbutton" data-options="text:'关闭',iconCls:'icon-html_delete'"></a>
        </div>
    </form>
</div>
<script type="text/javascript">
    $(function(){
        $("#musicaddsub${param.aid }").click(function(){
            $("#musicaddform${param.aid }").form("submit",{
                url:"${pageContext.request.contextPath }/chapter/add.do",
                success:function(data){
                    $("#musicdg${param.aid}").datagrid("reload");
                    $("#addmusicdiv${param.aid}").dialog("close");
                    if($("#centertabs").tabs("exists","专辑回收站")){
                        $("#deletealbumlistdg").datagrid("reload");
                    }
                    if($("#centertabs").tabs("exists","专辑列表")){
                        $("#albumlistdg").datagrid("reload");
                    }
                }
            });
        });
        $("#musicaddclo${param.aid}").click(function(){
            $("#addmusicdiv${param.aid}").dialog("close");
        });
    });

    $("#musicdg${param.aid}").datagrid({
        url:"${pageContext.request.contextPath }/chapter/queryByPage.do?aid=${param.aid}",
        fitColumns:true,
        fit:true,
        striped:true,
        loadMsg:"玩命加载中............",
        rownumbers:true,
        singleSelect:true,
        pagination:true,
        pageSize:5,
        pageList:[5,10,15,20],
        toolbar:toobar,
        columns:[[
            {field:"id",title:"编号",align:"center",width:100},
            {field:"title",title:"音频名",align:"center",width:100},
            {field:"audioPath",title:"音频",align:"center",width:200,
                formatter:function(value,rows,index){
                    return "<audio style='width:100%' src='${pageContext.request.contextPath}/music/" + value + "' controls='controls'>您的浏览器不支持 audio 标签.</audio>";
                    //return value;
                }
            },
            {field:"size",title:"大小",align:"center",width:100,
                formatter:function(value,rows,index){
                    return value+" M";
                },
            },
            {field:"ddd",title:"操作",align:"center",width:100,
                formatter:function(value,row,index){
                    return "<a class='dowloadbtn' href='${pageContext.request.contextPath }/chapter/down.do?url="+row.audioPath+"'>下载</a>&nbsp;&nbsp;&nbsp;"+
                        "<a class='deletemusic' onClick=deleteMusic('"+row.id+"','"+row.album.id+"','"+row.album.count+"')>删除</a>";
                }
            }
        ]],
        onLoadSuccess:function(data){
            $(".dowloadbtn").linkbutton({
                iconCls:"icon-arrow_down",
            });
            $(".deletemusic").linkbutton({
                iconCls:"icon-arrow_in_longer",
            });
        },
        toolbar:[{
            text:"添加音频",
            width:"110px",
            height:"28px",
            iconCls:"icon-group_add",
            handler:function(){
                $("#addmusicdiv${param.aid}").dialog({
                    title:"添加音频",
                    closeable:true
                });
            }
        }],
    });
    function deleteMusic(i,k,j){
        $.post("${pageContext.request.contextPath}/chapter/delete.do",{id:i,aid:k,count:j},function(data){
            $("#musicdg${param.aid}").datagrid("reload");
            if($("#centertabs").tabs("exists","专辑回收站")){
                $("#deletealbumlistdg").datagrid("reload");
            }
            if($("#centertabs").tabs("exists","专辑列表")){
                $("#albumlistdg").datagrid("reload");
            }
        });
    }
</script>
</body>
</html>