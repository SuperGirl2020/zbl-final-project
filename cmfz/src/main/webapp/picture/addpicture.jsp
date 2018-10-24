<%@ page isELIgnored="false" pageEncoding="UTF-8" %>
<script type="text/javascript">

    $('#picName').validatebox({
        required: true
    });

    $('#uploadPicture').form({
        url: "${pageContext.request.contextPath}/Picture/fileupload",
        onSubmit: function () {
            var isValid = $("#uploadPicture").form('validate');
            return isValid;	// 返回false终止表单提交
        },
        success: function (data) {
            if ("success" == data) {
                alert("提交成功...");
                $('#addpictureWin').window('close');
                $('#tt2').datagrid('load');
            } else {
                alert("提交失败：服务器繁忙或数据有误，请稍后再试...");
            }
        }
    });

    $('#btn1').linkbutton({
        width: 70,
        onClick: function () {
            $('#uploadPicture').form('submit');
        }
    });

    $('#btn2').linkbutton({
        width: 70,
        onClick: function () {
            $('#addpictureWin').window('close');
        }
    });


</script>

<form id="uploadPicture" method="post" enctype="multipart/form-data">
    <div style="text-align: center;margin-top: 30px">
        <div>
            <b>图片名称:</b>&nbsp;&nbsp;<input class="easyui-validatebox" name="pictureName" data-options="required:true"/>
        </div>
        <br/>
        <div>
            <b>图片备注:</b>&nbsp;&nbsp;<input class="easyui-validatebox" name="message" data-options="required:true"/>
        </div>
        <br/>
        <div>
            <input class="easyui-filebox" name="uploadFile" data-options="required:true" style="width:230px">
        </div>
        <br/><br/><br/>
        <div>
            <a id="btn1">提交</a>
            &nbsp;&nbsp;
            <a id="btn2">关闭</a>
        </div>
    </div>
</form>