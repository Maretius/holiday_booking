package com.example.holiday_booking;

import java.io.*;
import java.sql.SQLException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "FlatsServlet", value = "/flats")
public class FlatsServlet extends HttpServlet{
    private String flat1;
    private String flat2;

    public void init() {

    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        // Hello
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h1>" + flat1 + "</h1>");
        out.println("</body></html>");

    }

    public void destroy() {
    }
}
