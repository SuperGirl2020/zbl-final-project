<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page isELIgnored="false" %>


<script type="text/javascript">
    $(function () {
        $("#dg").edatagrid({
            url: "${pageContext.request.contextPath}/banner/queryByPage.do',",
            updateUrl: "${pageContext.request.contextPath}/banner/update.do",
            <%--destroyUrl:"${pageContext.request.contextPath}/banner/delete.do",--%>
            fitColumns: true,
            striped: true,
            fit: true,
            lect: true,
            method: 'post',

            singleSelect:true,
            ctrlSelect:true,
            rownumbers:true,// 显示行号
            pagination: true,
            /*pagePosition:'both',
            pageSize: 5,
            pageList: [5, 10,15,20,25],*/

            columns: [[
                {field: 'id', title: 'id', width: 88, sortable: true},
                {field: 'title', title: '标题', width: 88, sortable: true},
                {field: 'imgPath', title: '图片路径', width: 88},
                {field: 'description', title: '描述', width: 88},
                {
                        field: 'status', title: '状态', width: 88,
                        editor: {
                            type: 'text'
                        }
                },
                {field: 'createDate', title: '时间', width: 88},
            ]],
            toolbar: [{
                iconCls: 'icon-add',
                text: '添加',
                handler: function () {
                    $('#dd').dialog('open');
                }
            }, '-', {
                iconCls: 'icon-cut',
                text: '删除',
                handler: function () {
                    var opts = $("#dg").edatagrid('getSelections');
                    var flag = window.confirm("确定要删除吗？");
                    if (opts == null) {
                        alert("请选择行");
                    } else {
                        /*var a=$("#dg").edatagrid('destroyRow');*/
                        if (flag) {
                            $.each(opts, function (index, child) {
                                $.ajax({
                                    type: 'get',
                                    url: "${pageContext.request.contextPath}/banner/delete.do",
                                    data: 'id=' + child.id,
                                    success: function () {
                                        $("#dg").datagrid('reload');
                                    }
                                });

                            });
                        }

                    }
                }
            }, '-', {
                iconCls: 'icon-edit',
                text: '修改',
                handler: function () {
                    var opts = $("#dg").edatagrid('getSelections');
                    var opt = $("#dg").edatagrid('getSelected');
                    if (opts == null | opt == null) {
                        alert("请选择行");
                    } else if (opts.length > 1) {
                        alert("只能修改一行");
                    } else {
                        var index = $("#dg").edatagrid('getRowIndex', opt);
                        $("#dg").edatagrid('editRow', index);
                    }
                }
            }, '-', {
                iconCls: 'icon-save',
                text: '保存',
                handler: function () {
                    $("#dg").edatagrid('reload');
                }
            }],

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

    });
</script>


<table id="dg" style="width:600px;height:200px"
       title="Editable DataGrid"
       singleSelect="true">
    <thead>

    </thead>
</table>


