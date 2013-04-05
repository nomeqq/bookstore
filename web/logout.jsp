<%-- 
    Document   : logout
    Created on : 2013-4-4, 22:18:50
    Author     : Zhc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
             session.invalidate();
        %>
        <h1>已退出登录！</h1>
    </body>
</html>
