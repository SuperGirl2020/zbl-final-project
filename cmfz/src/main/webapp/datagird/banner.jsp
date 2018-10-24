<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/24 0024
  Time: 20:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<script type="text/javascript">
    $(function () {
        var toolbar = [{
            iconCls: 'icon-add',
            text: "添加",
            handler: function () {
                $("#dd").dialog("open");
            }
        }, '-', {
            text: "删除",
            iconCls: 'icon-delete',
            handler: function () {
                var row = $("#dg").edatagrid("getSelected");
                if(row!=null){
                    var index = $("#dg").edatagrid("getRowIndex", row);
                    $("#dg").edatagrid("deleteRow", index)
                }else{
                    alert("请先选中行")
                }
            }
        }, '-', {
            text: "修改",
            iconCls: 'icon-edit',
            handler: function () {
                /*
                 *使当前选中行可编辑模式
                 * */
                var row = $("#dg").edatagrid("getSelected");
                if (row != null) {

                    var index = $("#dg").edatagrid("getRowIndex", row)
                    //当前行可编辑
                    $("#dg").edatagrid("editRow", index)

                } else {
                    alert("请先选中行")
                }


            }
        }, '-', {
            text: "保存",
            iconCls: 'icon-edit',
            handler: function () {
                $("#dg").edatagrid("saveRow")
            }
        }]

        $('#dg').edatagrid({
            url: '${pageContext.request.contextPath}/banner/queryByPage.do',
            method:'post',
            columns: [[
                {field: 'id', title: '编号', width: 88},
                {field: 'title', title: '名称', width: 88},
                {field: 'imgPath', title: '图片路径', width: 88},
                {field: 'description', title: '描述', width: 88},
                {
                    field: 'status', title: '状态', width: 88, editor: {
                    type: "text",
                    options: {
                        required: true
                    },
                }
                },
                {field: 'createDate', title: '时间', width: 88},
                {field:'operate',title:'操作',width:88,align:'center',
                    formatter: function(value,row,index){
                        var temp=JSON.stringify(row).replace(/\"/g,"'");
                        return '<a class="del"  style="color: darkblue;" onclick="del('+temp+')"> 删除 </a>';
                    }
                },
            ]],
            striped:true,
            fit:true,
            singleSelect:true,
            loadMsg:"玩命加载中.......",
            fitColumns: true,
            fit: true,
            rownumbers:true,// 显示行号
            pagination: true,
            pagePosition:'both',
            pageSize: 5,
            pageList: [5, 10,15,20],
            toolbar: toolbar,
            view: detailview,
            detailFormatter: function (rowIndex, rowData) {
                return '<table><tr>' +
                    '<td rowspan=2 style="border:0"><img src="${pageContext.request.contextPath}' + rowData.imgPath + '" style="height:50px;"></td>' +
                    '<td style="border:0">' +
                    '<p>Attribute: ' + rowData.createDate + '</p>' +
                    '<p>Status: ' + rowData.status + '</p>' +
                    '</td>'+
                    '</tr></table>';
            }

        });
    })
    function submit() {
        $("#ff").form("submit", {
            url: "${pageContext.request.contextPath}/banner/uploadFile.do"
        })
    }
</script>
<table id="dg">
    <h1 style="text-align: center;color: #000;background-color: darkred">
        Don't forget, a person's greatest emotional need is to feel appreciated.
        <p>莫忘记，人类情感上最大的需要是感恩。-----好</p>
    </h1>
</table>
<div id="dd" class="easyui-dialog" title="Make America peace!" style="width:400px;height:200px;"
     data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true,buttons:[{
				text:'保存',
				handler:function(){
                     submit();
                      $('#dd').dialog('close');
                      $('#dg').edatagrid('reload')
				}
			},{
				text:'关闭',
				handler:function(){
                     $('#dd').dialog('close');
				}
			}]">
    <form id="ff" method="post" enctype="multipart/form-data">
        <div>
            <label for="title">title:</label>
            <input class="easyui-validatebox" id="title" type="text" name="title" data-options="required:true"/>
        </div>
        <div>
            <label for="content">description:</label>
            <input class="easyui-textbox" type="text" id="content" name="content" data-options=""/>
        </div>
        <div>
            <select id="cc" class="easyui-combobox" name="status" style="width:200px;">
                <option value="Y">展示</option>
                <option value="N">不展示</option>
            </select>
        </div>
        <div>
            <input class="easyui-filebox" name="imgPath" style="width:300px">
        </div>
    </form>
</div>

