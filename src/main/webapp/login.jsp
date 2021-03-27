<%@ page import="com.example.holiday_booking.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.holiday_booking.Reservation" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.example.holiday_booking.Flat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
</head>

<body>
<%@include file="navbar.jsp" %>

<%

    if(request.getParameter("reservationId") != null){
        int reservationId = Integer.parseInt(request.getParameter("reservationId"));
        try {Reservation.changeFlatStatus(reservationId);} catch (SQLException throwables) {throwables.printStackTrace();} catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }


    if (request.getParameter("emaillogin") != null && request.getParameter("passwordlogin") != null) {
        User user = User.readOne(request.getParameter("emaillogin"), request.getParameter("passwordlogin"));
        session.setAttribute("loginid", user.id);
        session.setAttribute("loginfirstname", user.firstname);
        session.setAttribute("loginlastname", user.lastname);
        session.setAttribute("loginemail", user.email);
        session.setAttribute("userRole", user.role);
    }
    if (request.getParameter("firstnameregister") != null && request.getParameter("lastnameregister") != null && request.getParameter("emailregister") != null && request.getParameter("passwordregister") != null) {
        User.writeOne(request.getParameter("firstnameregister"), request.getParameter("lastnameregister"), request.getParameter("emailregister"), request.getParameter("passwordregister"), "guest");
        User user = User.readOne(request.getParameter("emailregister"), request.getParameter("passwordregister"));
        session.setAttribute("loginid", user.id);
        session.setAttribute("loginfirstname", user.firstname);
        session.setAttribute("loginlastname", user.lastname);
        session.setAttribute("loginemail", user.email);
        session.setAttribute("userRole", user.role);
    }
    if (request.getParameter("loggedinemail") != null) {
        session.removeAttribute("loginid");
        session.removeAttribute("loginfirstname");
        session.removeAttribute("loginlastname");
        session.removeAttribute("loginemail");
        session.removeAttribute("userRole");
    }

    if (session.getAttribute("loginemail") == null) {
%>
<div>
    <h3>Login</h3>
</div>
<div>
    <div>
        <FORM ACTION="login.jsp" METHOD="POST">
        <label>
            <input type="email" id="emaillogin" name="emaillogin" value=""> E-Mail</label><br>
        <label>
            <input type="password" id="passwordlogin" name="passwordlogin" value=""> Passwort</label><br>
        <input type="submit" value="Anmelden">
        </FORM>
    </div>

    <div>
        <h4>Noch kein Konto? Hier Registrieren!</h4>
        <FORM ACTION="login.jsp" METHOD="POST">
        <label>
            <input type="text" id="firstname" name="firstnameregister" > Vorname</label><br>
        <label>
            <input type="text" id="lastname" name="lastnameregister"> Nachname</label><br>
        <label>
            <input type="email" id="email" name="emailregister"> E-Mail</label><br>
        <label>
            <input type="password" id="password" name="passwordregister"> Passwort</label><br>
        <input type="submit" value="Konto erstellen">
        </FORM>
    </div>
</div>
<% } else {
    ArrayList<Reservation> reservations = new ArrayList<Reservation>();
    int userId = (Integer) session.getAttribute("loginid");
    String userRole = (String) session.getAttribute("userRole");

    if (userRole.equals("admin")) {
        try {
            reservations = Reservation.readallFlats();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    } else {
        try {
            reservations = Reservation.readUserFlat(userId);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
%>
<div>
    <h3>Hallo, <%=session.getAttribute("loginfirstname")%> <%=session.getAttribute("loginlastname")%> !</h3>
</div>
<div class="center-middle">
    <div class="user-information">
        <FORM ACTION="login.jsp" METHOD="POST">
            <label>
               <input type="email" id="useremail" name="loggedinemail" value="<%=session.getAttribute("loginemail")%>" readonly> E-Mail</label><br>
            <label>
                <input type="text" id="userfirstname" value="<%=session.getAttribute("loginfirstname")%>" readonly> Vorname</label><br>
            <label>
                <input type="text" id="userlastname" value="<%=session.getAttribute("loginlastname")%>" readonly> Nachname</label><br>
            <input type="submit" value="Abmelden">
        </FORM>
    </div>
    <br>
    <div class="user-reservations">
        <table class="user-reservations-table">
            <caption>Buchungen</caption>
            <tr>
                <th>Wohnung</th>
                <th>Start</th>
                <th>Ende</th>
                <% if(userRole.equals("admin"))out.println("<th>Vorname</th><th>Nachname</th>");%>
                <th>Status</th>
            </tr>
            <%
                int idcount=0;
                for (Reservation reservation : reservations) {
                    Flat flat = new Flat();

                    try {
                        flat = Flat.readOne(reservation.flat_id);
                    } catch (SQLException throwables) {
                        throwables.printStackTrace();
                    } catch (ClassNotFoundException e) {
                        e.printStackTrace();
                    }
                    if (userRole.equals("admin")) {
                        User user = new User();
                        try {
                            user = User.readOneUser(reservation.user_id);
                        } catch (SQLException throwables) {
                            throwables.printStackTrace();
                        } catch (ClassNotFoundException e) {
                            e.printStackTrace();
                        }
                        if(reservation.status.equals("reserviert")){
                            out.println("<tr><td>"+flat.name+"</td><td>"+reservation.start+"</td><td>"+reservation.end+"</td><td>"+user.firstname+"</td><td>"+user.lastname+"</td><td>"); %>
            <FORM ACTION="login.jsp" METHOD="POST">
                <input type="hidden" name="reservationId" value="<%=reservation.id%>">
            <input type="submit"  id="<%=reservation.id%>" value="Akzeptieren"> </input>
            </FORM></td></tr>
            <%
                        } else {
                            out.println("<tr><td>"+flat.name+"</td><td>"+reservation.start+"</td><td>"+reservation.end+"</td><td>"+user.firstname+"</td><td>"+user.lastname+"</td><td>Akzeptiert</td></tr>");
                        }
                    } else {
                        out.println("<tr><td>"+flat.name+"</td><td>"+reservation.start+"</td><td>"+reservation.end+"</td><td>"+reservation.status+"</td></tr>");
                    }
                }
            %>
        </table>
    </div>
</div>
<%}%>


</body>
</html>
