<%@page contentType="text/html; utf-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<body>
    <c:forEach var="user" items="${sessionScope.users}">
        ${user.name}
        ${user.password}
    </c:forEach>

</body>
</html>
