<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title><%=request.getParameter("flatName")%></title>
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
</head>
<body>
<%@include  file="navbar.jsp" %>

<!-- Für die Bilder Galerie https://www.w3schools.com/howto/howto_js_tab_img_gallery.asp -->

<div>
    <div><h1><%=request.getParameter("flatName")%></h1></div>
    <div><div><p>Zimmer:</p></div><div><p>Größe: <%=request.getParameter("flatSize")%> m&sup2 Einzelbett(en): <%=request.getParameter("flatSinglebed")%> Doppelbett(en): <%=request.getParameter("flatDoublebed")%></p></div></div>
    <hr>
    <div><div><p>Weitere Infos:</p></div><div><p><%=request.getParameter("flatInfo")%></p></div></div>
    <hr>
    <div><div><p>Ausstattung:</p></div><div><span class="material-icons"><% if (request.getParameter("flatWifi").equals("1")){ %>wifi<% } if(request.getParameter("flatTv").equals("1")){ %>personal_video<% } if(request.getParameter("flatShower").equals("1")){ %>shower<% } if(request.getParameter("flatKitchen").equals("1")){ %>countertops<% } if(request.getParameter("flatWasher").equals("1")){ %>local_laundry_service<% } %></span></div></div>
    <hr>
    <div><div><p>Zur Buchung:</p></div><div><p>Jetzt ab <%=request.getParameter("flatPrice")%> € pro Nacht buchen <a href="booking.jsp?flatName=<%=request.getParameter("flatName")%>"><button class="booking-button">Zur Buchung</button></a></p></div></div>
</div>
</body>
</html>
