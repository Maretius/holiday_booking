<%@ page import="com.example.holiday_booking.DBConnection" %>
<%@ page import="com.example.holiday_booking.Flat" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Wohnungen</title>
    <link rel="stylesheet" href="css/main.css">
</head>

<body>
<%@include  file="navbar.jsp" %>

<%
    ArrayList<Flat> flatlist = new ArrayList<Flat>();
    try {
        flatlist=Flat.readAll();
    } catch (SQLException throwables) {
        throwables.printStackTrace();
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }

    for (Flat flat : flatlist) {

%>

<div class="flat-div">
    <div class="flat-div-left"><img src="images/flats/<%=flat.name%>/Bild1.jpg" alt="Bild"></div>
    <div class="flat-div-middle">
        <div class="flat-div-middle-top"><h2><%=flat.name%></h2><p><%=flat.info%></p></div>
        <div class="flat-div-middle-bot"> </div></div>
    <div class="flat-div-right"><h2><%="ab " + flat.price + "€ pro Nacht."%></h2><button class="flat-div-right-button">Mehr Infos</button></div>
</div>
<hr>
<%}%>


</body>
</html>
