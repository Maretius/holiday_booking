<%@ page import="com.example.holiday_booking.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
</head>

<body>
<%@include  file="navbar.jsp" %>

<%
    if(request.getParameter("emaillogin") != null && request.getParameter("passwordlogin") != null) {
        User user = User.readOne(request.getParameter("emaillogin"), request.getParameter("passwordlogin"));
        session.setAttribute("loginfirstname", user.firstname);
        session.setAttribute("loginlastname", user.lastname);
        session.setAttribute("loginemail", user.email);
    }
    if(request.getParameter("firstnameregister") != null && request.getParameter("lastnameregister") != null && request.getParameter("emailregister") != null && request.getParameter("passwordregister") != null) {
        User.writeOne(request.getParameter("firstnameregister"), request.getParameter("lastnameregister"), request.getParameter("emailregister"), request.getParameter("passwordregister"), "guest");
        Thread.sleep(1000);
        User user = User.readOne(request.getParameter("emailregister"), request.getParameter("passwordregister"));
        session.setAttribute("loginfirstname", user.firstname);
        session.setAttribute("loginlastname", user.lastname);
        session.setAttribute("loginemail", user.email);
    }
    if(request.getParameter("loggedinemail") != null){
        session.removeAttribute("loginfirstname");
        session.removeAttribute("loginlastname");
        session.removeAttribute("loginemail");
    }

    if(session.getAttribute("loginemail") == null ) {
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
<%}else{%>
<div>
    <h3>Hallo, <%=session.getAttribute("loginfirstname")%> <%=session.getAttribute("loginlastname")%> !</h3>
</div>
<div>
    <div>
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
</div>
<%};%>


</body>
</html>
