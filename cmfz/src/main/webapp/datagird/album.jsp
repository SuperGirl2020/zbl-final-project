<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript">
    $(function(){
    var toolbar = [{
        iconCls: 'icon-edit',
        text: "专辑详情",
        handler: function () {
            //获取选中行的数据
            var row = $("#table").treegrid("getSelected");
            if (row != null) {//代表选中行
                if (row.author != null) {//判断是否为专辑
                    $("#album_dd").dialog("open");
                    $('#album_ff').form('load', row);//点击专辑所在行，获取专辑数据
                    //获取响应标签的属性prop,属性名：src,属性值：coverImg(数据库)
                    $('#coverImg').prop('src', "${pageContext.request.contextPath}" + row.coverImg);
                } else {
                    alert("请选中专辑");
                }
            } else {
                alert("请选中行");
            }
        }
    }, '-', {
        text: "添加专辑",
        iconCls: 'icon-add',
        handler: function () {
            $("#dd").dialog("open");
            $.messager.progress();	// 显示进度条
            $('#album_ff').form('submit', {
                url:'${pageContext.request.contextPath}/album/add.do',
                onSubmit: function(){
                    var isValid = $(this).form('validate');
                    if (!isValid){
                        $.messager.progress('close');	// 如果表单是无效的则隐藏进度条
                    }
                    return isValid;	// 返回false终止表单提交
                },
                success: function(){
                    $.messager.progress('close');	// 如果提交成功则隐藏进度条
                }
            });


        }
    }, '-', {
        iconCls: 'icon-add',
        text: "添加章节",
        handler: function () {
            $("#chapteradd").dialog("open");
            $.messager.progress();	// 显示进度条
            $('#chapterff').form('submit', {
                url:'${pageContext.request.contextPath}/chapter/add.do',
                onSubmit: function(){
                    var isValid = $(this).form('validate');
                    if (!isValid){
                        $.messager.progress('close');	// 如果表单是无效的则隐藏进度条
                    }
                    return isValid;	// 返回false终止表单提交
                },
                success: function(){
                    $.messager.progress('close');	// 如果提交成功则隐藏进度条
                }
            });


        }
    }, '-', {
        text: "下载音频",
        iconCls: 'icon-help',
        handler: function () {
            var row = $("#table").treegrid("getSelected");
            if (row != null) {
                if (row.author == null) {
                    location.href = "${pageContext.request.contextPath}/chapter/down.do?url=" + row.audioPath + "&name=" + row.title
                } else {
                    alert("请选中专辑");
                }
            } else {
                alert("请选中行");
            }
        }
    }]
        $.fn.datebox.defaults.formatter = function(date){
            var y = date.getFullYear();
            var m = date.getMonth()+1;
            var d = date.getDate();
            return y+"-"+m+"-"+d;
        };
    $('#table').treegrid({
        onDblClickRow:function(row){
            $("#audio_dd").dialog("open");
            $("#audio").prop("src","${pageContext.request.contextPath}"+row.audioPath)
        },
        url:'${pageContext.request.contextPath}/album/queryByPage.do',
        idField:'id',
        treeField:'title',
        pagination:true,
        animate:true,
        toolbar:toolbar,
        columns:[[
            {title:'编号',field:'id',width:100,align:'center'},
            {title:'标题',field:'title',width:100,align:'center'},
            {title:'播放时长',field:'duration',width:100,align:'center'},
            {title:'大小',field:'size',width:100,align:'center'},
            {title:'音频路径',field:'audioPath',width:100,align:'center'}
        ]],
        detailFormatter: function (rowIndex, rowData) {
            return '<table><tr>' +
                '<td rowspan=2 style="border:0"><img src="${pageContext.request.contextPath}' + rowData.coverImg + '" style="height:50px;"></td>' +
                '<td style="border:0">' +
                '<p>Attribute: ' + rowData.createDate + '</p>' +
                '<p>Status: ' + rowData.status + '</p>' +
                '</td>'+
                '</tr></table>';
        }

    });
    })
</script>
<table id="table" width=""></table>
<div id="album_dd" class="easyui-dialog" title="带我离开！" style="width:800px;height:510px;"
     data-options="iconCls:'icon-add',resizable:true,modal:true,closed:true">
    <form id="album_ff" method="post"><!-- 专辑详情-->
        <div>
            <label for="title">title:</label>
            <input class="easyui-validatebox" type="text" id="title" name="title" data-options=""/>
        </div>
        <div>
            <label for="count">count:</label>
            <input class="easyui-validatebox" type="text" id="count" name="count" data-options=""/>
        </div>
        <div>
            <label for="brief">brief:</label>
            <input class="easyui-validatebox" type="text" id="brief" name="brief" data-options=""/>
        </div>
        <div>
            <label for="coverImg">coverImg:</label>
            <img src="" id="coverImg" alt="">
        </div>
    </form>

    <div id="audio_dd" class="easyui-dialog" title="音乐播放器" style="width:400px;height:200px;align-content: center"
         data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true">
        <audio src="" id="audio" controls="controls" autoplay="loop">
                <!--  controlls,loop,preload-->
        </audio>
    </div>
</div>
<div id="dd" class="easyui-dialog" title="Make America peace!" style="width:400px;height:200px;"
     data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true,buttons:[{
				text:'保存',
				handler:function(){
                     $('#album_ff').submit();
                      $('#dd').dialog('close');
                      $('#table').edatagrid('reload');
				}
			},{
				text:'关闭',
				handler:function(){
                     $('#dd').dialog('close');
				}
			}]">
    <form id="ff" method="post" enctype="multipart/form-data">
        <div>
            <label for="id">id:</label>
            <input class="easyui-validatebox" id="id" type="text" name="id" data-options="required:true"/>
        </div>
        <div>
            <label for="title">title:</label>
            <input class="easyui-validatebox" id="t" type="text" name="title" data-options="required:true"/>
        </div>
        <div>
            <label for="count">count:</label>
            <input class="easyui-textbox" type="text" id="c" name="content" data-options="required:true"/>
        </div>
        <div>
            <label for="coverImg">coverImg:</label>
            <input class="easyui-textbox" type="text" id="Img" name="coverImg" data-options=""/>
        </div>
        <div>
            <label for="score">score:</label>
            <input class="easyui-textbox" type="text" id="score" name="score" data-options=""/>
        </div>
        <div>
            <label for="author">author:</label>
            <input class="easyui-textbox" type="text" id="author" name="author" data-options="required:true"/>
        </div>
        <div>
            <label for="broadCast">broadCast:</label>
            <input class="easyui-textbox" type="text" id="broadCast" name="broadCast" data-options="required:true"/>
        </div>
        <div>
            <label for="brief">brief:</label>
            <input class="easyui-textbox" type="text" id="b" name="brief" data-options="required:true"/>
        </div>
        <div>
            <label for="createDate">createDate:</label>
            <input class="easyui-textbox" type="text" id="createDate" name="createDate" data-options="required:true"/>
        </div>
        <div>
            <label for="publishDate">publishDate:</label>
            <input class="easyui-textbox" type="text" id="publishDate" name="publishDate" data-options="required:true"/>
        </div>
        <div>
            <select id="status" class="easyui-combobox" id="status" name="status" style="width:200px;">
                <option value="Y">展示</option>
                <option value="N">不展示</option>
            </select>
        </div>
        <div>
            <input class="easyui-filebox" name="imgPath" style="width:300px">
        </div>
        <div style="text-align: center;margin-top: 10px">
            <a id="btn1" href="javascript:void(0)" class="easyui-linkbutton"
               data-options="iconCls:'icon-tab_blue',width:80" style="margin-right:25px;">提交</a>
            <a id="btn2" href="javascript:void(0)" class="easyui-linkbutton"
               data-options="iconCls:' icon-css_delete',width:80">关闭</a>
        </div>
    </form>
</div>
<div id="chapteradd" class="easyui-dialog" title="I came,I saw,I Conquered!" style="width:400px;height:200px;"
     data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true,buttons:[{
				text:'保存',
				handler:function(){
                    $('#chapterff').form('submit');
                      $('#chapteradd').dialog('close');
                      $('#table').edatagrid('reload');
				}
			},{
				text:'关闭',
				handler:function(){
                     $('#chapteradd').dialog('close');
				}
			}]">
    <form id="chapterff" method="get" enctype="multipart/form-data">
        <div>
            <label for="id">id:</label>
            <input class="easyui-validatebox" id="i" type="text" name="id" data-options="required:true"/>
        </div>
        <div>
            <label for="title">title:</label>
            <input class="easyui-validatebox" id="topic" type="text" name="title" data-options="required:true"/>
        </div>
        <div>
            <label for="duration">duration:</label>
            <input class="easyui-textbox" type="text" id="duration" name="duration" data-options="required:true"/>
        </div>
        <div>
            <label for="audioPath">audioPath:</label>
            <input class="easyui-textbox" type="text" id="audioPath" name="audioPath" data-options="required:true"/>
        </div>
        <div style="text-align: center;margin-top: 10px">
            <a id="btn3" href="javascript:void(0)" class="easyui-linkbutton"
               data-options="iconCls:'icon-tab_blue',width:80" style="margin-right:25px;">提交</a>
            <a id="btn4" href="javascript:void(0)" class="easyui-linkbutton"
               data-options="iconCls:' icon-css_delete',width:80">关闭</a>
        </div>
    </form>
</div>