<%@ page import="com.example.holiday_booking.Reservation" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Belegung</title>
    <link rel="stylesheet" href="css/main.css">
</head>
<body>
<%@include file="navbar.jsp" %>

<jsp:include page="calendar.jsp">
    <jsp:param name="year" value="2021"/>
    <jsp:param name="month" value="3"/>
    <jsp:param name="flatId" value="1"/>
</jsp:include>

<jsp:include page="calendar.jsp">
    <jsp:param name="year" value="2021"/>
    <jsp:param name="month" value="4"/>
    <jsp:param name="flatId" value="1"/>
</jsp:include>

<jsp:include page="calendar.jsp">
    <jsp:param name="year" value="2021"/>
    <jsp:param name="month" value="5"/>
    <jsp:param name="flatId" value="1"/>
</jsp:include>

</body>
</html>
