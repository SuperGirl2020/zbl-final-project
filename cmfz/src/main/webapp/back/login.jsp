<%@page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>持名法州后台管理中心</title>

	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="this is my page">
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">

	<link rel="icon" href="../img/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" href="../css/common.css" type="text/css"></link>
	<link rel="stylesheet" href="../css/login.css" type="text/css"></link>
	<script type="text/javascript" src="../script/jquery.js"></script>
	<script type="text/javascript" src="../script/common.js"></script>
	<script type="text/javascript">
        //点击更换验证码：
        function reloadCaptcha(obj){
            obj.src='${pageContext.request.contextPath }/captcha/createCaptcha.do?'+Math.random();
        }
	</script>
</head>
<body>

<div class="login">
	<form id="loginForm" action="${pageContext.request.contextPath}/admin/login.do" method="post">

		<table>
			<tbody>
			<tr>
				<td width="190" rowspan="2" align="center" valign="bottom">
					<img src="../img/header_logo.gif" />
				</td>
				<th>
					用户名:
				</th>
				<td>
					<input type="text"  name="username" class="text" value="xxx" maxlength="20"/>
				</td>
			</tr>
			<tr>
				<th>
					密&nbsp;&nbsp;&nbsp;码:
				</th>
				<td>
					<input type="password" name="password" class="text" value="xxx" maxlength="20" autocomplete="off"/>
				</td>
			</tr>

			<tr>
				<td valign="middle" align="right">
					验证码:
				</td>
				<td valign="middle" align="left">
					<input id="code" style="width:66px;" type="text" class="inputgri" name="captcha" />
					<img style="width:66px;height:30px;vertical-align:bottom;" id="num" src="${pageContext.request.contextPath }/captcha/createCaptcha.do" onclick="reloadCaptcha(this)"/>
					<a href="javascript:;" onclick="document.getElementById('num').src = '${pageContext.request.contextPath }/captcha/createCaptcha.do?'"+Math.random()>换一张</a>
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
				<th>
					&nbsp;
				</th>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<th>&nbsp;</th>
				<td>
					<input type="button" class="homeButton" value="" onclick="location.href='..'"><input type="submit" class="loginButton" value="登录">
				</td>
			</tr>
			</tbody></table>
		<div class="powered">COPYRIGHT © 2008-2017.</div>
		<div class="link">
			<a href="${pageContext.request.contextPath}/back/main.jspn.jsp">持名佛网首页</a> |
			<a href="http://www.chimingbbs.com/">交流论坛</a> |
			<a href="">关于我们</a> |
			<a href="">联系我们</a> |
			<a href="">授权查询</a>
		</div>
	</form>
</div>
</body>
</html>