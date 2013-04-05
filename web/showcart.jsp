<%-- 
    Document   : showcart
    Created on : 2013-4-4, 21:25:43
    Author     : tigerpeasant
--%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            Map<String, Integer> cart;
            cart = (Map<String, Integer>) session.getAttribute("cart");
            if(cart==null){
                cart = new HashMap<String,Integer>();
                session.setAttribute("cart", cart);
            }
            Iterator iter = cart.entrySet().iterator();
            while (iter.hasNext()) {
                Map.Entry entry = (Map.Entry) iter.next();
                String isbn = (String)entry.getKey();
                Integer number = (Integer)entry.getValue();
        %>
        isbn = <%=isbn%>, number = <%=number%><br/>
        <%
            }
        %>
    </body>
</html>
