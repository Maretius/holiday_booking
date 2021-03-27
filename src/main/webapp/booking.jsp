<%@ page import="com.example.holiday_booking.Flat" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.example.holiday_booking.Reservation" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Buchung</title>
    <link rel="stylesheet" href="css/main.css">
</head>

<body>
<%@include  file="navbar.jsp" %>

<%
    if(session.getAttribute("prüfungerfolgreich") != null && session.getAttribute("loginemail") != null) {

            String email = (String) session.getAttribute("loginemail");
            try {
                Reservation.writeOne(email, Integer.parseInt(request.getParameter("wohnung")), request.getParameter("startdate"), request.getParameter("enddate"));
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
    }

    if(request.getParameter("wohnung") != null && session.getAttribute("prüfungerfolgreich") == null && !request.getParameter("startdate").equals("") && !request.getParameter("enddate").equals("")) {
        System.out.println("prüfen");
        System.out.println(request.getParameter("wohnung"));
        System.out.println(request.getParameter("startdate"));
        System.out.println(request.getParameter("enddate"));
        if(!Reservation.checkReserved(Integer.parseInt(request.getParameter("wohnung")), request.getParameter("startdate"), request.getParameter("enddate"))){
            session.setAttribute("prüfungerfolgreich", "Geilo");
            session.removeAttribute("bereitsbelegt");
        }else{
            session.setAttribute("bereitsbelegt", "Geilo");
            session.removeAttribute("prüfungerfolgreich");
        }
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
                <option <%if(request.getParameter("id") != null && Integer.parseInt(request.getParameter("id"))==flat.id){%>selected<%}%> <%if (session.getAttribute("prüfungerfolgreich") != null && Integer.parseInt(request.getParameter("wohnung"))!=flat.id){%>disabled<%;}%>  value="<%=flat.id%>"><%=flat.name%></option>
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
            <input <%if (session.getAttribute("prüfungerfolgreich") != null){%>readonly<%;}%> type="date" name="startdate" value="<%if( request.getParameter("startdate") != null ){%><%=request.getParameter("startdate")%><%}%>" > Startdatum</label><br>
        <label>
            <input <%if (session.getAttribute("prüfungerfolgreich") != null){%>readonly<%;}%> type="date" name="enddate" value="<%if( request.getParameter("enddate") != null ){%><%=request.getParameter("enddate")%><%}%>" > Enddatum</label><br>

        <input type="submit" name="jetztbuchen"  value="<%if(session.getAttribute("prüfungerfolgreich") != null){%>Jetzt buchen<%;}else{%>Verfügbarkeit prüfen<%}%>">
    </div>
    <%if (session.getAttribute("bereitsbelegt") != null){ out.println("<p>Die Wohnung ist nicht verfügbar an diesem Datum </p>") ;}%>
</div>
</FORM>
<%
    if (session.getAttribute("prüfungerfolgreich") != null){
%>
<div><a href="booking.jsp"><button onclick="<%session.removeAttribute("prüfungerfolgreich");%>">Daten ändern</button></a></div>

<%}%>
</body>
</html>