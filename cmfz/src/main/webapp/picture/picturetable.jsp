<%@ page pageEncoding="UTF-8" isELIgnored="false" %>
<script type="text/javascript">
    $('#tt2').datagrid({
        width: 500,
        height: 250,
        remoteSort: false,
        singleSelect: true,
        nowrap: false,
        fit: true,
        fitColumns: true,
        url: "${pageContext.request.contextPath}/Picture/queryAllPictures",
        columns: [[
            {field: 'pictureId', title: '图片ID', width: 80},
            {
                field: 'pictureName', title: '图片名称', width: 100, sortable: true
                ,editor: {
                    type: 'textbox',
                    options: {
                        required: true,
                        missingMessage: '图片名必填!'
                    }
                }
            },
            {field: 'picturePath', title: '图片路径', width: 80, align: 'right', sortable: true},
            {
                field: 'message', title: '备注', width: 80, align: 'right', sortable: true
                ,editor: {
                    type: 'textbox',
                    options: {
                        required: false
                    }
                }
            },
            {field: 'uploadTime', title: '上传时间', width: 150, sortable: true},
            {
                field: 'status', title: '展示状态', width: 60, align: 'center'
               , editor: {
                    type: 'textbox',
                    options: {
                        required: true,
                        missingMessage: '展示状态必填!'
                    }
                }
            },
            {field: 'pictureSize', title: '图片大小', width: 60, align: 'center'}
        ]],
        view: detailview,
        detailFormatter: function (rowIndex, rowData) {
            return '<table><tr>' +
                '<td rowspan=2 style="border:0"><img src="http://localhost:8989/' + rowData.picturePath + '" style="height:50px;"></td>' +
                '<td style="border:0">' +
                '<p>Attribute: ' + rowData.pictureName + '</p>' +
                '<p>Status: ' + rowData.status + '</p>' +
                '</td>' +
                '</tr></table>';
        },
        toolbar: [{
            text: "添加",
            iconCls: 'icon-add',
            handler: function () {
                $('#addpictureWin').window('open');
            }
        }, '-', {
            text: "删除",
            iconCls: 'icon-cancel',
            handler: function () {
                var row = $('#tt2').datagrid('getSelected');
                if (row == null) {
                    alert("您还未选中任何数据，请选中数据行后再执行操作...");
                } else {
                    var boolean = window.confirm("您确定要删除此行数据吗？");
                    if (boolean) {
                        var index = $('#tt2').datagrid('getRowIndex', row);
                        $.ajax({
                            type:'post',
                            data:'id=' + row.pictureId,
                            url:'${pageContext.request.contextPath}/Picture/deletePictureById',
                            success:function(data){
                                if(data == "deleteOk"){
                                    $('#tt2').datagrid('deleteRow', index);
                                }else{
                                    alert("删除失败...请稍后再试");
                                }
                            }
                        });
                    }
                }
            }
        }, '-', {
            text: "修改",
            iconCls: 'icon-edit',
            handler: function () {
                var row = $('#tt2').datagrid('getSelected');
                if (row == null) {
                    alert("您还未选中任何数据，请选中数据行后再执行操作...");
                } else {
                    var index = $('#tt2').datagrid('getRowIndex', row);
                    $('#tt2').datagrid('beginEdit', index);
                }
            }
        }, '-', {
            text: "撤销",
            iconCls: 'icon-back',
            handler: function () {
                var row = $('#tt2').datagrid('getSelected');
                var index = $('#tt2').datagrid('getRowIndex', row);
                $('#tt2').edatagrid('cancelEdit', index);
            }
        }, '-', {
            text: "保存",
            iconCls: 'icon-save',
            handler: function () {
                var row = $('#tt2').datagrid('getSelected');
                var index = $('#tt2').datagrid('getRowIndex', row);
                $('#tt2').datagrid('endEdit', index);
                var newrow = $('#tt2').datagrid('getSelected');
                $.ajax({
                    type:'post',
                    data:"id="+newrow.pictureId+"&pictureName="+newrow.pictureName+"&message="+newrow.message+"&status="+newrow.status,
                    url:'${pageContext.request.contextPath}/Picture/revisePictureMessage',
                    success:function(data){
                        if(data == "reviceOk"){
                            alert("保存成功...");
                        }else{
                            alert("保存失败...请稍后再试");
                        }
                    }
                });
            }
        }]
    });

    /*$('#tt').edatagrid({
     url: 'datagrid_data.json',
     saveUrl:,
     updateUrl:,
     destroyUrl:
     });*/
</script>

<table id="tt2"></table>