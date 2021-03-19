<%@ page import="com.example.holiday_booking.Flat" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Buchung</title>
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
</head>

<body>
<%@include  file="navbar.jsp" %>

<div><h1>Buchung</h1></div>
<div>
    <div>
        <h3>Wohnung?</h3>
    </div>
    <div>
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

        <label>
        <input type="radio" name="wohnung" value="flat.name" <%if (flat.name.equals(request.getParameter("flatName"))){ %>checked<% }%>> <%=flat.name%></label><br>
    <%}%>
    </div>

</div>
<div>
    <div>
        <h3>Von Wann bis Wann?</h3>
    </div>
    <div>
        <label>
            <input type="date" id="startdate"> Startdatum</label><br>
        <label>
            <input type="date" id="enddate"> Enddatum</label><br>
        <input type="submit" value="Verfügbarkeit prüfen">
        <p></p>
    </div>
</div>

<div>
    <div>
        <h3>Nutzerdaten</h3>
    </div>
    <div>
        <label>
            <input type="text" id="firstname"> Vorname</label><br>
        <label>
            <input type="text" id="lastname"> Nachname</label><br>
        <label>
            <input type="email" id="email"> E-Mail</label><br>
        <label>
            <input type="password" id="password"> Passwort</label><br>
        <input type="submit" value="Konto erstellen">
    </div>

</div>


</body>
</html>
