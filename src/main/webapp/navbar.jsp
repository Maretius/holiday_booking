<div class="navbar">
    <ul class="navbar-ul">
        <li class ="navbar-li"><a class ="active" href="index.jsp">Home</a></li>
        <li class ="navbar-li"><a href="flats.jsp">Wohnungen</a></li>
        <li class ="navbar-li"><a href="occupancy.jsp">Belegung</a></li>
        <li class ="navbar-li"><a href="booking.jsp">Buchung</a></li>
        <li class ="navbar-li"><a href="contact.jsp">Kontakt</a></li>
        <%if(session.getAttribute("loginemail") == null ) {%>
        <li class ="navbar-li"><a href="login.jsp">Login</a></li>
        <%}else{%>
        <li class ="navbar-li"><a href="login.jsp"><%=session.getAttribute("loginemail")%></a></li>
        <%}%>
    </ul>
</div>

