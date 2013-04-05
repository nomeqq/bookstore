<%-- 
    Document   : add2cart
    Created on : 2013-4-4, 20:50:44
    Author     : tigerpeasant
--%>

<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String isbn = request.getParameter("isbn");
            Integer number = new Integer(request.getParameter("number"));
            Map<String,Integer> cart;
            cart = (Map<String,Integer>)session.getAttribute("cart");
            if(null==cart){
                cart = new HashMap<String,Integer>();
            }
            Integer oldnumber = cart.get(isbn);
            if(oldnumber!=null){
                number += oldnumber;
            }
            cart.put(isbn, number);
            session.setAttribute("cart", cart);
        %>
        <h1>Hello World!</h1>
    </body>
</html>
