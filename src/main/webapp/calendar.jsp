<%@ page import="com.example.holiday_booking.Reservation" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    int dateYear = Integer.parseInt(request.getParameter("year"));
    int dateMonth = Integer.parseInt(request.getParameter("month"));
    int flatId = Integer.parseInt(request.getParameter("flatId"));

    Date date;
    SimpleDateFormat dfYearMonthDay = new SimpleDateFormat( "yyyy-MM-dd" );
    SimpleDateFormat dfDay = new SimpleDateFormat( "dd" );
    SimpleDateFormat dfMonth = new SimpleDateFormat( "MM" );
    SimpleDateFormat dfDayOfWeek = new SimpleDateFormat( "u" );
    date = dfYearMonthDay.parse(dateYear + "-" + dateMonth + "-01");
    int dayOfWeek = Integer.parseInt(dfDayOfWeek.format(date));

    ArrayList<Reservation> reservations = new ArrayList<Reservation>();
    try {
        reservations = Reservation.readFlat(flatId, dateYear, dateMonth);
    } catch (SQLException throwables) {
        throwables.printStackTrace();
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }

String[] monthName = {"Januar","Februar","März","April","Mai","Juni","Juli","August","September","Oktober","November","Dezember"};
String[] dayName = {"Mo", "Di", "Mi", "Do", "Fr", "Sa", "So"};
String dayStatus = "";

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
}
%>

<table id="kalender" class="kalendar">
    <caption><%=monthName[dateMonth-1] + " " + dateYear%></caption>
    <tr>
        <% for(int i=0; i < 7; i++) {
        out.println("<th class=\"table-day\">" + dayName[i] + "</th>");
        }%>
    </tr>
    <% for(int i=0; calendarDay <= endday; i++) {%>
    <tr>
        <% for(int j=0; j< 7; j++){
            if(((i == 0) && (j < dayOfWeek-1)) || (calendarDay > endday)){
                out.println("<td></td>");
            } else {
                for (Reservation reservation : reservations) {
                    int reservationMonthStart = Integer.parseInt(dfMonth.format(reservation.start));
                    int reservationMonthEnd = Integer.parseInt(dfMonth.format(reservation.end));
                    int reservationDayStart = Integer.parseInt(dfDay.format(reservation.start));
                    int reservationDayEnd = Integer.parseInt(dfDay.format(reservation.end));

                    dayStatus = "table";

                    if (reservationMonthStart == dateMonth && reservationDayStart == calendarDay) {
                        dayStatus = dayStatus + "-start";
                    } else if (reservationMonthEnd== dateMonth && reservationDayEnd == calendarDay) {
                        dayStatus = dayStatus + "-end";
                    }
                    if (reservation.status.equals("reserviert")) {
                        if ((reservationMonthStart != dateMonth && reservationMonthEnd == dateMonth) && reservationDayEnd >= calendarDay) {
                            dayStatus = dayStatus + "-reserviert";
                            break;
                        } else if ((reservationMonthStart == dateMonth && reservationMonthEnd == dateMonth) && (reservationDayStart <= calendarDay && reservationDayEnd >= calendarDay)) {
                            dayStatus = dayStatus + "-reserviert";
                            break;
                        } else if ((reservationMonthStart == dateMonth && reservationMonthEnd != dateMonth) && reservationDayStart <= calendarDay) {
                            dayStatus = dayStatus + "-reserviert";
                            break;
                        }
                    } else if (reservation.status.equals("gebucht")) {
                        if ((reservationMonthStart != dateMonth && reservationMonthEnd == dateMonth) && reservationDayEnd >= calendarDay) {
                            dayStatus = dayStatus + "-gebucht";
                            break;
                            // Reservierung Start und Ende im Monat
                        } else if ((reservationMonthStart == dateMonth && reservationMonthEnd == dateMonth) && (reservationDayStart <= calendarDay && reservationDayEnd >= calendarDay)) {
                            dayStatus = dayStatus + "-gebucht";
                            break;
                        } else if ((reservationMonthStart == dateMonth && reservationMonthEnd != dateMonth) && reservationDayStart <= calendarDay) {
                            dayStatus = dayStatus + "-gebucht";
                            break;
                        }
                    } else {
                        dayStatus = dayStatus + "-calendarday";
                    }

                }
                out.println("<td class=" + dayStatus + ">" + calendarDay + "</td>");
                calendarDay++;
            }
        }%>
    </tr>
    <%}%>
</table>