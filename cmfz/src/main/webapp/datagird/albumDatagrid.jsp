<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" type="text/css" href="../themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="../themes/IconExtension.css">
<link rel="stylesheet" type="text/css" href="../themes/icon.css">

<script type="text/javascript">
    $(function () {
        $("#adg").treegrid({
            idField: 'id',
            treeField: 'title',
            url: "${pageContext.request.contextPath}/album/queryByPage.do",
            updateUrl: "${pageContext.request.contextPath}/album/update.do",
            fitColumns: true,
            fit: true,
            pagination: true,
            lect: true,
            method: 'post',
            singleSelect: true,
            ctrlSelect: true,
            /*onLoadSuccess:function(){
                $("#adg").treegrid('collapseAll');
            },*/
            onDblClickRow: function (chapter) {
                $("#album_paly").dialog('open');
                $("#audio").prop('src', "${pageContext.request.contextPath}"+chapter.audioPath);
            },
            striped: true,
            columns: [[
                {field: 'title', title: '专辑名称', width: 40},
                {field: 'size', title: '章节大小', width: 40},
                {field: 'duration', title: '时长', width: 40},
                {field: 'audioPath', title: '下载路径', width: 40}
            ]],
            toolbar: [{
                iconCls: 'icon-add',
                text: '添加专辑',
                handler: function () {
                    $("#album").dialog('open');
                }
            }, '-', {
                iconCls: 'icon-cut',
                text: '删除',
                handler: function () {
                    var opt = $("#adg").treegrid('getSelected');
                    var flag = window.confirm("确定要删除吗？");
                    if (opt == null) {
                        alert("请选择要删除的章节或者专辑");
                    } else {
                        if (opt.size == null) {
                            if (flag) {
                                $.ajax({
                                    url: ' ${pageContext.request.contextPath}/album/delete.do',
                                    type: 'post',
                                    data: 'id=' + opt.id,
                                    success: function () {
                                        $("#adg").treegrid('reload');
                                    }
                                });
                            }
                        } else {
                            if (flag) {
                                $.ajax({
                                    url: ' ${pageContext.request.contextPath}/chapter/deleteOne.do',
                                    type: 'post',
                                    data: 'id=' + opt.id,
                                    success: function () {
                                        $("#adg").treegrid('reload');
                                    }
                                });
                            }
                        }
                    }
                }
            }, '-', {
                iconCls: 'icon-edit',
                text: '专辑详情',
                handler: function () {
                    var album = $("#adg").treegrid('getSelected');
                    if (album != null) {//代表选中行
                        if (album.author != null) {//判断是否为专辑
                            $("#album_info").dialog('open');
                            $("#album_intro").form('load', album);//点击专辑所在行，获取专辑数据
                            //获取响应标签的属性prop,属性名：src,属性值：coverImg(数据库)
                            $("#coverImg").prop('src', "${pageContext.request.contextPath}" +album.coverImg);
                        } else {
                            alert("请选择要查看的专辑");
                        }
                    } else {
                        alert("请选中行");
                    }

                }
            }, '-', {
                iconCls: 'icon-save',
                text: '下载音频',
                handler: function () {
                    var chapter = $("#adg").treegrid('getSelected');
                    if (chapter == null) {
                        alert("请先选择章节");
                    } else {
                        if (chapter.title == null) {
                            alert("请先选择专辑");
                        } else {
                            location.href = "${pageContext.request.contextPath}/chapter/download.do?name=" + chapter.title + "&url=" + chapter.audioPath;
                            /*$.ajax({
                                url: ' {pageContext.request.contextPath}/section/download',
                                type: 'post',
                                data: 'name=' + section.name + "&url=" + section.url,
                                success: function () {
                                    alert("===================");
                                }
                            });*/
                        }
                    }

                }
            }, '-', {
                iconCls: 'icon-add',
                text: '添加章节',
                handler: function () {
                    var album = $("#adg").treegrid('getSelected');
                    if (album != null) {
                        if (album.title != null) {
                            alert("请选择要添加的专辑");
                        } else {
                            $("#chapter").dialog('open');
                            $("#al_id").textbox('setValue', album.id);
                        }
                    }else{
                        alert("请先选中专辑");
                    }

                }
            }]
        });

        $("#album").dialog({
            width: 400,
            height: 300,
            closed: true,
            closed: true,
            cache: false,
            modal: true,
            pagination:true,
            buttons: [{
                text: '添加',
                iconCls: 'icon-add',
                handler: function () {
                    $("#alb").form('submit', {
                        url: '${pageContext.request.contextPath}/album/add.do',
                        success: function () {
                            $("#album").dialog('close');
                            $("#adg").treegrid('reload');
                        }
                    });
                }
            }, {
                text: '取消',
                iconCls: 'icon-redo',
                handler: function () {
                    $("#album").dialog('close');
                }
            }]
        });
        $("#chapter").dialog({
            width: 400,
            height: 300,
            closed: true,
            closed: true,
            cache: false,
            modal: true,
            buttons: [{
                text: '添加',
                iconCls: 'icon-add',
                handler: function () {
                    $("#sect").form('submit', {
                        url: '${pageContext.request.contextPath}/chapter/add.do',
                        success: function () {
                            $("#chapter").dialog('close');
                            $("#adg").treegrid('reload');
                        }
                    });
                }
            }, {
                text: '取消',
                iconCls: 'icon-redo',
                handler: function () {
                    $("#chapter").dialog('close');
                }
            }]
        });
        $("#album_info").dialog({
            width: 800,
            height: 630,
            closed: true,
            cache: false,
            closable: true,
            modal: true

        });
        $("#alb_name").textbox({
            iconCls: 'icon-man',
            prompt: '专辑名称'
        })
        $("#alb_info").textbox({
            iconCls: 'icon-man',
            prompt: '作者'
        })
        $("#alb_image").filebox({
            iconCls: 'icon-man',
            prompt: '封面图片'
        });
        /*$("#al_id").textbox({})

        $("#s_url").filebox({
            iconCls: 'icon-man'
        })
        $("#album_paly").dialog({
            iconCls: 'icon-save',
            resizable: true,
            modal: true,
            closed: true
        });*/

    });
</script>


<table id="adg" style="width:600px;height:200px"
       title="Editable DataGrid"
       singleSelect="true">
    <thead>

    </thead>
</table>


<div id="album" title="添加专辑" style="width:400px;height:200px;">
    <form id="alb" method="post" enctype="multipart/form-data">
        <div style="height:30px;padding-left: 20%;padding-right: 20%;margin-top: 20px">
            <input id="alb_name" name="title" style="width: 100%;height:100%;" required="true"/>
        </div>
        <div style="height:30px;padding-left: 20%;padding-right: 20%;margin-top: 20px">
            <input id="alb_info" name="author" style="width: 100%;height:100%;" required="true"/>
        </div>
        <div style="height:30px;padding-left: 20%;padding-right: 20%;margin-top: 20px">
            <input id="alb_image" name="coverImg" style="width: 100%;height:100%;">
        </div>
    </form>
</div>

<div id="chapter" title="My Dialog" style="width:400px;height:200px;">
    <form id="sect" method="post" enctype="multipart/form-data">
        <div style="height:30px;padding-left: 20%;padding-right: 20%;margin-top: 20px">
            <input class="easyui-textbox" name="albumId" id="al_id" style="width: 100%;height:100%;"
                   value="0" <%--style="display: none"--%>/>
        </div>
        <div style="height:30px;padding-left: 20%;padding-right: 20%;margin-top: 20px">
            <input id="s_url" name="sec" style="width: 100%;height:100%;">
        </div>
    </form>
</div>


<div id="album_info" class="easyui-dialog" title="专辑详情" style="width:800px;height:510px;">
    <form id="album_intro" method="post">
        <div style="height:30px;padding-left: 20%;padding-right: 20%;margin-top: 20px">
            <label>title</label>
            <input class="easyui-validatebox" name="title" style="width: 100%;height:100%;" required="true"/>
        </div>
        <div style="height:30px;padding-left: 20%;padding-right: 20%;margin-top: 20px">
            <label>count</label>
            <input class="easyui-validatebox" name="count" style="width: 100%;height:100%;" required="true"/>
        </div>
        <div style="height:30px;padding-left: 20%;padding-right: 20%;margin-top: 20px">
            <label>score</label>
            <input class="easyui-validatebox" name="score" style="width: 100%;height:100%;" required="true"/>
        </div>
        <div style="height:30px;padding-left: 20%;padding-right: 20%;margin-top: 20px">
            <label>author</label>
            <input class="easyui-validatebox" name="author" style="width: 100%;height:100%;" required="true"/>
        </div>
        <div style="height:30px;padding-left: 20%;padding-right: 20%;margin-top: 20px">
            <label>coverImg</label>
            <img src="" id="coverImg" name="coverImg"/>
        </div>
    </form>
</div>

<div id="album_paly" class="easyui-dialog" title="音乐播放器" style="width:400px;height:200px;"
     data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true">

    <audio id="audio" src="" controls="controls" autoplay="autoplay"></audio>

</div>