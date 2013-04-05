<%-- 
    Document   : index
    Created on : 2013-4-3, 0:21:53
    Author     : tigerpeasant
--%>

<%@page import="java.math.BigDecimal"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="dbquery.Books"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Boolean loggedin = (Boolean) session.getAttribute("loggedin");
    if (loggedin == null || !loggedin) {
        loggedin = new Boolean(false);
    }

    String bookname = request.getParameter("bookname");
%>
<!DOCTYPE html>
<html xmlns:h="http://java.sun.com/jsf/html" xmlns:f="http://java.sun.com/jsf/core">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

        <title>当当网</title>
        <link href="./res/home2012.css" type="text/css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="./res/smart_new.css">
        <script language="javascript" src="js/jquery-1.9.1.js"></script>
    </head>
    <body>
        <div id="hd">
            <div class="tools" id="db">
                <div class="ddnewhead_operate">
                    <ul class="ddnewhead_operate_nav">
                        <li class="ddnewhead_cart">
                            <a href="#" name="gwc">购物车<span id="cart_items_count" class="cart_num"></span></a>
                        </li>
                    </ul>
                    <p id="nickname"><a name="shoucang" class="collect" href="javascript:void(0);" ><span class="c"></span><span class="t">收藏我</span></a><span class="gray">|</span>
                        <% if (!loggedin) {%>
                        欢迎光临书斋网，请<a name="dl" href="login.html" target="_self" class="login_link">登录</a><a name="zc" href="register.html" target="_self" class="login_link">免费注册</a>
                        <% } else {%>
                        您好，<%= (String) session.getAttribute("username")%> [<a name="tc" href="logout.jsp" target="_self" >退出登录</a>]
                        <% }%>
                    </p>
                </div>
            </div>
            <div class="logo_line">
                <div class="logo">
                    <a href="#" title="返回首页" name="ddnav_logo"><img src="./res/dangdang_logo.jpg" width="101" height="48" alt="当当网"></a>
                </div>
            </div>
            <div class="search_box" id="fl">

                <div class="search">
                    <form action="index_2.jsp" name="searchform" id="form_search_new" method="GET">
                        <%
                            String style;
                            String search_value;
                            if (bookname == null) {
                                style = "text gray";
                                search_value = "想搜什么书就告诉我吧";
                            } else {
                                style = "text";
                                search_value = bookname;
                            }
                        %>
                        <input type="text" class="<%=style%>" value="<%=search_value%>" name="bookname" id="key_S" autocomplete="off" onFocus="search_bar_onfocus(this)" onBlur="search_bar_onblur(this)">
                        <input type="submit" id="search_btn" style="display:none">
                    </form>
                    <input type="button" class="button btn" onClick="javascript:document.getElementById('search_btn').click();">
                </div>        
                <div id="suggest_key" class="suggest_key" style="display: none;">
                </div>
            </div>
            <div class="content">
                <%
                    if (null != bookname) {
                        Books books = new Books();
                        ResultSet rs = books.querylike("name", bookname);
                        String isbn = "Orz~ ，没有这本书啊~";
                        while (rs.next()) {
                            isbn = rs.getString("isbn1");
                            String name = rs.getString("name");
                            BigDecimal price = rs.getBigDecimal("price");
                %>
                <%=name%> <%=price%>元 ISBN: <%=isbn%> <a href="#" onclick="add2cart('<%=isbn%>')">加入购物车</a><br/>
                <%
                        }
                        rs.close();
                    }
                %>
            </div>
        </div>

        <link href="./res/smart.css" rel="stylesheet" type="text/css">
        <script language="javascript">
                            function search_bar_onfocus(e) {
                                e.className = 'text';
                                if (e.value != '想搜什么书就告诉我吧') {
                                    e.className = 'text';
                                } else {
                                    e.value = '';
                                    e.className = 'text';
                                }
                            }
                            function search_bar_onblur(e) {
                                if (e.value == '') {
                                    e.value = '想搜什么书就告诉我吧';
                                    e.className = 'text gray';
                                }
                            }
                            function ajaxSuccess(data){}
                            function add2cart(isbn, number) {
                                number = arguments[1] ? arguments[1] : 1;
                                $.get("add2cart.jsp?isbn="+isbn+"&number="+number, function(data, status) {
                                    if (status == "success")
                                        ajaxSuccess(data);
                                    else
                                        prompt("网址访问出错", url);
                                });
                            }
        </script>
    </body>
</html>
