<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title><%=request.getParameter("flatName")%></title>
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
</head>
<body>
<%@include  file="navbar.jsp" %>

<h1><%=request.getParameter("flatName")%></h1>


</body>
</html>
