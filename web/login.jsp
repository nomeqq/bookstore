<%-- 
    Document   : login
    Created on : 2013-4-3, 0:05:13
    Author     : Zhc
--%>
<%@page contentType="text/html" language="java" import="java.sql.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String name = request.getParameter("username");
            String pw = request.getParameter("password");

        %>
        <%  Class.forName("org.apache.derby.jdbc.ClientDriver").newInstance();
            String url = "jdbc:derby://localhost:1527/bookstore";
            String user = "abc";
            String passWord = "abc";
            Connection conn = DriverManager.getConnection(url, user, passWord);
            Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "select * from USERS where username='" + name + "'";
            ResultSet rs = stmt.executeQuery(sql);
            int userid;
            if (rs.next()) {
                userid = rs.getInt(1);
                String sql1 = "select * from PASSWORD where uid = "+userid+"";
                ResultSet rs1 = stmt.executeQuery(sql1);
                String userpw;
                if(rs1.next()){
                    userpw = rs1.getString("PW");
                    if(userpw.equals(pw))
                    {
                        out.write("登陆成功！");
                        session.setAttribute("loggedin", (Boolean)true);
                        session.setAttribute("userid", userid);
                        session.setAttribute("username", name);
                        response.sendRedirect("index_2.jsp");
                    }
                    else
                    {
                        out.write("密码错误！");
                    }
                }
            }
            else {
                out.write("No such account！");
            }

        %>
        <%
            rs.close();
            stmt.close();
            conn.close();
        %>


        <h1></h1>
    </body>
</html>
