<%@ page import="com.example.holiday_booking.Flat" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Flat flat = new Flat();
    try {
        flat = Flat.readOne(Integer.parseInt(request.getParameter("id")));
    } catch (SQLException throwables) {
        throwables.printStackTrace();
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }

%>
<html>
<head>
    <title><%=flat.name%></title>
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
</head>
<body>
<%@include  file="navbar.jsp" %>

<!-- Für die Bilder Galerie https://www.w3schools.com/howto/howto_js_tab_img_gallery.asp -->

<div class="center-middle">
    <div class="flat-header">
        <h1><%=flat.name%></h1>
    </div>
    <div class="flat-image">
        <img src="images/flats/<%=flat.id%>/Bild1.jpg" alt="Bild">
    </div>
    <div>
        <div>
            <p>Zimmer:</p>
        </div>
        <div>
            <p>Größe: <%=flat.size%> m&sup2 Einzelbett(en): <%=flat.singlebed%>; Doppelbett(en): <%=flat.doublebed%></p>
        </div>
    </div>
    <hr>
    <div>
        <div>
            <p>Weitere Infos:</p>
        </div>
        <div class="flat-infos">
            <p><%=flat.info%></p>
        </div>
    </div>
    <hr>
    <div>
        <div>
            <p>Ausstattung:</p>
        </div>
        <div class="flat-furnishing">
            <ul>
                <%
                    if (flat.wifi == 1) out.println("<li>WiFi <span class=\"material-icons\">wifi</span></li>");
                    if(flat.tv == 1) out.println("<li>TV <span class=\"material-icons\">personal_video</span></li>");
                    if(flat.shower == 1) out.println("<li>Dusche <span class=\"material-icons\">shower</span></li>");
                    if(flat.kitchen == 1) out.println("<li>Küche <span class=\"material-icons\">countertops</span></li>");
                    if(flat.washer == 1) out.println("<li>Waschmaschine <span class=\"material-icons\">local_laundry_service</span></li>");
                %>
            </ul>
        </div>
    </div>
    <hr>
    <div>
        <div>
            <p>Zur Buchung:</p>
        </div>
        <div class="flat-booking">
            <p>Jetzt ab <%=flat.price%> € pro Nacht buchen <a href="booking.jsp?id=<%=flat.id%>"><button class="booking-button">Zur Buchung</button></a></p>
        </div>
    </div>
</div>
</body>
</html>
