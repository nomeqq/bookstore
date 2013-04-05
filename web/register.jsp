<%-- 
    Document   : register
    Created on : 2013-4-4, 17:08:51
    Author     : Zhc
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String uname = request.getParameter("username");
            String pw1 = request.getParameter("password1");
            String pw2 = request.getParameter("password2");
            if (uname != null && pw1 != null && pw2 != null) {
                if (pw1.equals(pw2)) {
                    Class.forName("org.apache.derby.jdbc.ClientDriver").newInstance();
                    String url = "jdbc:derby://localhost:1527/bookstore";
                    String user = "abc";
                    String passWord = "abc";
                    Connection conn = DriverManager.getConnection(url, user, passWord);
                    Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                    ResultSet rs1 = stmt.executeQuery("select * from USERS where username='" + uname + "'");
                    if (rs1.next()) {
                        out.write("用户名已存在！");
                    } else {
                        stmt.executeUpdate("insert into USERS (username) values ('" + uname + "')");
                        ResultSet rs2 = stmt.executeQuery("select * from USERS where username ='" + uname + "'");
                        if (rs2.next()) {
                            int uid = rs2.getInt(1);
                            stmt.executeUpdate("insert into PASSWORD values (" + uid + ",'" + pw1 + "')");
                            out.write("注册成功！");
                            response.sendRedirect("index_1.jsp");
                        } else {
                            out.write("Error！");
                        }
                        rs2.close();
                        stmt.close();
                        conn.close();
                    }
                } else {
                    out.write("两次密码不一致！");

                }
            }
        %>
        <a href="register.html">返回！</a>
        <h1>Hello World!</h1>
    </body>
</html>
