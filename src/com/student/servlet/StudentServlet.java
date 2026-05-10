package com.student.servlet;

import com.student.dao.StudentDAO;
import com.student.model.Student;
import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/student")
public class StudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private StudentDAO studentDAO;

    @Override
    public void init() {
        studentDAO = new StudentDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "insert";

        try {
            switch (action) {
                case "insert":
                    insertStudent(request, response);
                    break;
                default:
                    response.sendRedirect("index.jsp");
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void insertStudent(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        String firstName = nullSafe(request.getParameter("firstName"));
        String lastName  = nullSafe(request.getParameter("lastName"));
        String name      = nullSafe(request.getParameter("name"));
        // Fallback: if name is empty but firstName+lastName exist, combine them
        if (name.isEmpty()) name = (firstName + " " + lastName).trim();

        String email    = nullSafe(request.getParameter("email"));
        String rollNo   = nullSafe(request.getParameter("rollNo")).toUpperCase();
        String usn      = nullSafe(request.getParameter("usn")).toUpperCase();
        String course   = nullSafe(request.getParameter("course"));
        String year     = nullSafe(request.getParameter("year"));
        String section  = nullSafe(request.getParameter("section")).toUpperCase();
        String phone    = nullSafe(request.getParameter("phone"));
        String password = nullSafe(request.getParameter("password"));
        if (password.isEmpty()) password = "student123"; // default

        Student newStudent = new Student(firstName, lastName, email,
                                         rollNo, usn, course, year, section, phone, password);
        newStudent.setName(name);
        studentDAO.insertStudent(newStudent);
        response.sendRedirect("view.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("view.jsp");
    }

    private String nullSafe(String s) {
        return s != null ? s.trim() : "";
    }
}