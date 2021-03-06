<%@ page import="com.example.holiday_booking.Flat" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Wohnungen</title>
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
</head>

<body>
<%@include  file="navbar.jsp" %>

<div class="center-middle">
    <h2>Finden Sie ihr passendes Objekt</h2>
    <hr>
    <%
        ArrayList<Flat> flatlist = new ArrayList<Flat>();
        try {
            flatlist = Flat.readAll();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        for (Flat flat : flatlist) {
    %>
    <div class="flat-div">
        <a href="flat.jsp?id=<%=flat.id%>"><div class="flat-div-left">
            <img src="images/flats/<%=flat.id%>/Bild1.jpg" alt="Bild">
        </div></a>
        <div class="flat-div-middle">
            <div class="flat-div-middle-top">
                <h1><%=flat.name%></h1>
                <p><%=flat.info%></p>
                <ul>
                    <li class="flat-div-middle-top-li">Größe: <%=flat.size%> m&sup2</li>
                    <li class="flat-div-middle-top-li">Betten: <%=flat.singlebed%> Einzelbett(en), <%=flat.doublebed%> Doppelbett(en)</li>
                </ul>
            </div>
            <div class="flat-div-middle-bot">
                <span class="material-icons">
                <%
                    if(flat.wifi == 1) out.println("wifi");
                    if(flat.tv == 1) out.println("personal_video");
                    if(flat.shower == 1) out.println("shower");
                    if(flat.kitchen == 1) out.println("countertops");
                    if(flat.washer == 1) out.println("local_laundry_service");
                %>
                </span>
            </div>
        </div>
        <div class="flat-div-right">
            <h2><%="ab " + flat.price + "€ pro Nacht"%></h2>
            <a href="flat.jsp?id=<%=flat.id%>"><button class="flat-div-right-button">Mehr Infos</button></a>
        </div>
    </div>
    <hr>
    <%}%>
</div>
</body>
</html>
