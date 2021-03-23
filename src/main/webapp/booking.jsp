<%@ page import="com.example.holiday_booking.Flat" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.example.holiday_booking.Reservation" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Buchung</title>
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
</head>

<body>
<%@include  file="navbar.jsp" %>

<%
    if(session.getAttribute("prüfungerfolgreich") != null && request.getParameter("startdate") != null && request.getParameter("enddate") != null && request.getParameter("wohnung") != null) {

        String email = (String) session.getAttribute("loginemail");
        try {
            Reservation.writeOne(email, request.getParameter("wohnung"), request.getParameter("startdate"), request.getParameter("enddate"));
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    if(request.getParameter("wohnung") != null && session.getAttribute("prüfungerfolgreich") == null) {
        System.out.println("prüfen");
        System.out.println(request.getParameter("wohnung"));
        System.out.println(request.getParameter("startdate"));
        System.out.println(request.getParameter("enddate"));
        session.setAttribute("prüfungerfolgreich", "Geilo");
    }


%>


<div><h1>Buchung</h1></div>
<div>
    <div>
        <h3>Nutzerdaten</h3>
    </div>

    <%
        if(session.getAttribute("loginemail") == null ) {
    %>
    <div>Wie es scheint bist du noch nicht eingeloggt. Logge dich hier ein!<a href="login.jsp"><button>Zum Login</button></a></div>
    <%}else{%>
    <div>
        <h4>Angemeldet als <%=session.getAttribute("loginfirstname")%> <%=session.getAttribute("loginlastname")%></h4>
    </div>
    <%}%>

</div>
<hr>
<FORM ACTION="booking.jsp" METHOD="POST">
<div>
    <div>
        <h3>Wohnung?</h3>
    </div>
    <div>

        <label>Wohnung:
            <select id="wohnung" name="wohnung">
                <%
                    ArrayList<Flat> flatlist = new ArrayList<Flat>();
                    try {
                        flatlist=Flat.readAll();
                    } catch (SQLException throwables) {
                        throwables.printStackTrace();
                    } catch (ClassNotFoundException e) {
                        e.printStackTrace();
                    }
                    for (Flat flat : flatlist) {%>
                <option <%if (request.getParameter("id") != null && Integer.parseInt(request.getParameter("id"))==flat.id){%>selected<% }%>><%=flat.name%></option>
                <%  }%>
            </select>
        </label>
    </div>
</div>
<hr>
<div>
    <div>
        <h3>Von Wann bis Wann?</h3>
    </div>
    <div>

        <label>
            <input type="date" name="startdate"> Startdatum</label><br>
        <label>
            <input type="date" name="enddate"> Enddatum</label><br>
        <%
            if(session.getAttribute("prüfungerfolgreich") == null ) {
        %>
        <input type="submit" name="prüfen" value="Verfügbarkeit prüfen">
        </FORM>
        <%}else{%>
        <input type="submit" name="jetztbuchen" value="Jetzt buchen">
        </FORM>
        <%  }%>
    </div>
</div>



</body>
</html>