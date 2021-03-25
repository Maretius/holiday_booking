<%@ page import="com.example.holiday_booking.Reservation" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.sql.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--<%--%>
<%--    Reservation reservation = new Reservation();--%>
<%--    try {--%>
<%--       reservation=Reservation.readOne(2);--%>
<%--    } catch (SQLException throwables) {--%>
<%--        throwables.printStackTrace();--%>
<%--    } catch (ClassNotFoundException e) {--%>
<%--        e.printStackTrace();--%>
<%--    }--%>

<%--        %>--%>
<html>
<head>
    <title>Belegung</title>
    <link rel="stylesheet" href="css/main.css">
</head>
<body>
<%@include  file="navbar.jsp" %>

<%
    int dateYear = LocalDate.now().getYear();
    int dateMonth = LocalDate.now().getMonthValue();
    int dateDay = LocalDate.now().getDayOfMonth();
    int startDay = LocalDate.now().getDayOfWeek().getValue();
    int test = dateDay;
    while (test > 7) {

    }
    System.out.println("Year: " + dateYear + " Month: " + dateMonth + " Day: " + dateDay + " Day2: " + startDay);

    String[] monthName = {"Januar","Februar","März","April","Mai","Juni","Juli","August","September","Oktober","November","Dezember"};
    String[] dayName = {"Mo", "Di", "Mi", "Do", "Fr", "Sa", "So"};
   // int startDay = ((LocalDate.of(dateYear,dateMonth+1,1)).getDayOfMonth()+6)%7;
    int endday = 31;
    int calendarDay = 1;
    // ...April (4), Juni (6), September (9) und November (11) haben nur 30 Tage...
    if (dateMonth == 4 || dateMonth == 6 || dateMonth == 9 || dateMonth == 11) --endday;
    // ...und der Februar nur 28 Tage...
    if (dateMonth == 2) {
        endday = endday-3;
        // ...außer in Schaltjahren
        if (dateYear %   4 == 0) endday++;
        if (dateYear % 100 == 0) endday--;
        if (dateYear % 400 == 0) endday++;
    }%>
<table id="kalender">
    <caption><%=monthName[dateMonth-1] + " " + dateYear%></caption>
    <tr>
<%
    for(int i=0; i < 7; i++) {%>
        <th class="table-day"><%=dayName[i]%></th>
    <%}%>
    </tr>
    <%for(int i=0; calendarDay <= endday; i++) {%>
    <tr><%
        for(int j=0; j< 7; j++){
            if(((i == 0) && (j < dateDay)) || (calendarDay > endday)){%>
                <td></td>
        <%  } else { %>
                <td class="table-calendarday"><%=calendarDay%></td>
        <%      calendarDay++;
            }
        }
    %></tr>
    <%}%>
</table>
<%
%>
<script>
    function x() {
        // ermittle Tag und schreibe Zeile
        let Tageszahl = 1;
        // Monate können 4 bis 6 Wochen berühren. Darum laufen, bis die Tageszahl hinter dem Monatsletzen liegt.
        for (let i = 0; Tageszahl <= Stop; i++) {
            let row = tabelle.insertRow(1 +i);
            for (let j = 0; j < 7; j++) {
                let cell = row.insertCell(j);
                // Zellen vor dem Start-Tag in der ersten Zeile und Zeilen nach dem Stop-Tag werden leer aufgefüllt
                if ( ((i == 0) && (j < Start)) || (Tageszahl > Stop) ) {
                    cell.innerHTML = ' ';
                } else {
                    // normale Zellen werden mit der Tageszahl befüllt und mit der Klasse Kalendertag markiert
                    cell.innerHTML = Tageszahl;
                    cell.className = 'tabelle-kalendertag'
                    // und der aktuelle Tag (heute) wird noch einmal speziell mit der Klasse "heute" markiert
                    if ( Tageszahl === DieserTag ) {
                        cell.className = cell.className+' tabelle-heute';
                    }
                    Tageszahl++;
                }
            }
        }
        return true;
    }
</script>
</body>
</html>
