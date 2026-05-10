package com.student.servlet;

import com.student.dao.StudentDAO;
import com.student.model.Student;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * StudentAPIServlet — REST JSON API for the Leave & Attendance HTML system.
 *
 * Endpoints (all under /student/api):
 *   GET  ?action=all          → Returns all students as JSON array
 *   GET  ?action=verify&roll=XX&password=YY → Validates login, returns student JSON or error
 *
 * CORS is enabled for http://127.0.0.1:5500 (Live Server) and http://localhost:5500.
 */
@WebServlet("/api")
public class StudentAPIServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private StudentDAO studentDAO;

    // Allowed origins for CORS
    private static final String[] ALLOWED_ORIGINS = {
        "http://127.0.0.1:5500",
        "http://localhost:5500",
        "http://localhost:8080",
        "null"  // file:// access
    };

    @Override
    public void init() {
        studentDAO = new StudentDAO();
    }

    @Override
    protected void doOptions(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        setCORSHeaders(request, response);
        response.setStatus(HttpServletResponse.SC_OK);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        setCORSHeaders(request, response);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        PrintWriter out = response.getWriter();

        if (action == null) action = "all";

        switch (action) {

            case "all": {
                // Return all students (without passwords)
                List<Student> students = studentDAO.selectAllStudents();
                StringBuilder sb = new StringBuilder("[");
                for (int i = 0; i < students.size(); i++) {
                    sb.append(students.get(i).toJson(false));
                    if (i < students.size() - 1) sb.append(",");
                }
                sb.append("]");
                out.print(sb.toString());
                break;
            }

            case "verify": {
                // Validate student login: ?action=verify&roll=XX&password=YY
                String roll     = nullSafe(request.getParameter("roll")).toUpperCase();
                String password = nullSafe(request.getParameter("password"));

                if (roll.isEmpty() || password.isEmpty()) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    out.print("{\"error\":\"roll and password are required\"}");
                    break;
                }

                Student student = studentDAO.findByRollAndPassword(roll, password);
                if (student != null) {
                    // Return student data WITH password so leave system can cache it
                    out.print(student.toJson(true));
                } else {
                    response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                    out.print("{\"error\":\"Invalid roll number or password\"}");
                }
                break;
            }

            default:
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"error\":\"Unknown action\"}");
        }

        out.flush();
    }

    /** Sets CORS headers allowing the Leave System (Live Server) to call this API */
    private void setCORSHeaders(HttpServletRequest request, HttpServletResponse response) {
        String origin = request.getHeader("Origin");
        boolean allowed = false;
        if (origin != null) {
            for (String o : ALLOWED_ORIGINS) {
                if (o.equals(origin)) { allowed = true; break; }
            }
        } else {
            allowed = true; // same-origin request
        }

        if (allowed) {
            response.setHeader("Access-Control-Allow-Origin",
                origin != null ? origin : "*");
        }
        response.setHeader("Access-Control-Allow-Methods",  "GET, POST, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers",  "Content-Type, Authorization");
        response.setHeader("Access-Control-Allow-Credentials", "true");
        response.setHeader("Access-Control-Max-Age",        "3600");
    }

    private String nullSafe(String s) {
        return s != null ? s.trim() : "";
    }
}
