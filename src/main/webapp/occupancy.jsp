<%@ page import="com.example.holiday_booking.Flat" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.time.LocalDate" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Belegung</title>
    <link rel="stylesheet" href="css/main.css">
</head>
<body>
<%@include file="navbar.jsp" %>

<div class="center-middle">
    <%
        ArrayList<Flat> flatlist = new ArrayList<Flat>();
        try {
            flatlist = Flat.readAll();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        for (Flat flat : flatlist) {
    %>
    <div class="flat-div-calendar">
        <div>
            <h2><%=flat.name%></h2>
        </div>
        <div class="flat-div-calendar-table">
            <%
                int year = LocalDate.now().getYear();
                int month = LocalDate.now().getMonthValue();

                for (int i = 0; i < 3; i++) {
                    if((month+i) > 12){
                        year = year - 1;
                        month = month - 12;
                    }
            %>
            <jsp:include page="calendar.jsp">
                <jsp:param name="year" value="<%=year%>"/>
                <jsp:param name="month" value="<%=month+i%>"/>
                <jsp:param name="flatId" value="<%=flat.id%>"/>
            </jsp:include>
            <%}%>
        </div>
    </div>
    <%}%>
</div>

</body>
</html>
