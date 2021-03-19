<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
</head>

<body>
<%@include  file="navbar.jsp" %>

<div>
    <h3>Login</h3>
</div>


<div>
    <div>
        <label>
            <input type="email" id="emaillogin"> E-Mail</label><br>
        <label>
            <input type="password" id="passwordlogin"> Passwort</label><br>
        <input type="submit" value="Anmelden">
    </div>

    <div>
        <h4>Noch kein Konto? Hier Registrieren!</h4>
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




<div>
    <div>
        <label>
            <input type="email" id="useremail"> E-Mail</label><br>
        <label>
            <input type="password" id="userfirstname"> Vorname</label><br>
        <label>
            <input type="password" id="userlastname"> Nachname</label><br>
        <input type="submit" value="Abmelden">
    </div>
</div>



</body>
</html>
