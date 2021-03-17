<%@ page import="com.example.holiday_booking.DBConnection" %>
<%@ page import="com.example.holiday_booking.Flat" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Wohnungen</title>
    <link rel="stylesheet" href="css/main.css">
</head>
<%
    Flat flat = null;
    try {
        flat = Flat.readOne(1);
    } catch (SQLException throwables) {
        throwables.printStackTrace();
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }
%>

<body>
<%@include  file="navbar.jsp" %>
<h1>
<%=flat.name%>
</h1>
</body>
</html>
