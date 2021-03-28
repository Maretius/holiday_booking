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
<%@include file="navbar.jsp" %>

<%
    if (request.getParameter("buttonchange") != null) {
        session.removeAttribute("prüfungerfolgreich");
        System.out.println("Session Variable entfernt");
    }
    if (session.getAttribute("prüfungerfolgreich") != null && session.getAttribute("loginemail") != null) {
        int userID = (Integer) session.getAttribute("loginid");
        try {
            Reservation.writeOne(userID, Integer.parseInt(request.getParameter("wohnung")), request.getParameter("startdate"), request.getParameter("enddate"));
            session.removeAttribute("prüfungerfolgreich");
            response.sendRedirect("login.jsp");
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    if (request.getParameter("wohnung") != null && session.getAttribute("prüfungerfolgreich") == null && !request.getParameter("startdate").equals("") && !request.getParameter("enddate").equals("")) {
        System.out.println("prüfen");
        if (!Reservation.checkReserved(Integer.parseInt(request.getParameter("wohnung")), request.getParameter("startdate"), request.getParameter("enddate"))) {
            session.setAttribute("prüfungerfolgreich", "Geilo");
            session.removeAttribute("bereitsbelegt");
        } else {
            session.setAttribute("bereitsbelegt", "Geilo");
            session.removeAttribute("prüfungerfolgreich");
        }
    }

%>


<div class="center-middle">
    <h1>Buchung</h1>
    <hr>
    <div>
        <% if (session.getAttribute("loginemail") == null) { %>
        <div>Wie es scheint bist du noch nicht eingeloggt. Logge dich hier ein!<a href="login.jsp">
            <button>Zum Login</button>
        </a></div>
        <%} else {%>
        <div>
            <h5>Angemeldet als <%=session.getAttribute("loginfirstname")%> <%=session.getAttribute("loginlastname")%></h5>
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
                                flatlist = Flat.readAll();
                            } catch (SQLException throwables) {
                                throwables.printStackTrace();
                            } catch (ClassNotFoundException e) {
                                e.printStackTrace();
                            }
                            for (Flat flat : flatlist) {%>
                        <option <%if(request.getParameter("id") != null && Integer.parseInt(request.getParameter("id"))==flat.id){%>selected<%}%>
                                <%if (session.getAttribute("prüfungerfolgreich") != null && Integer.parseInt(request.getParameter("wohnung"))!=flat.id){%>disabled<%
                                ;
                            }
                        %> value="<%=flat.id%>"><%=flat.name%>
                        </option>
                        <% }%>
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
                    <input <%if (session.getAttribute("prüfungerfolgreich") != null){%>readonly<%;}%> type="date" name="startdate" value="<%if( request.getParameter("startdate") != null ){%><%=request.getParameter("startdate")%><%}%>">Startdatum</label>
                <br>
                <label>
                    <input <%if (session.getAttribute("prüfungerfolgreich") != null){%>readonly<%;}%> type="date" name="enddate" value="<%if( request.getParameter("enddate") != null ){%><%=request.getParameter("enddate")%><%}%>">Enddatum</label>
                <br>
                <input type="submit" name="jetztbuchen" value="<%if(session.getAttribute("prüfungerfolgreich") != null){%>Jetzt buchen<%;}else{%>Verfügbarkeit prüfen<%}%>">
            </div>
            <% if (session.getAttribute("bereitsbelegt") != null) out.println("<p>Die Wohnung ist nicht verfügbar an diesem Datum </p>"); %>
        </div>
    </FORM>
    <% if (session.getAttribute("prüfungerfolgreich") != null) { %>
    <FORM ACTION="booking.jsp" METHOD="POST">
        <input type="hidden" name="buttonchange" value="changeData">
        <input type="submit" id="changebutton" value="Daten ändern">
    </FORM>
    <%}%>
</div>
</body>
</html>