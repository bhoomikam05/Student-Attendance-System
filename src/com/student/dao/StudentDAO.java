package com.student.dao;

import com.student.model.Student;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {
    private String jdbcURL      = "jdbc:mysql://localhost:3306/studentdb";
    private String jdbcUsername = "root";
    private String jdbcPassword = "ayush";

    private static final String INSERT_STUDENT_SQL =
        "INSERT INTO students (name, first_name, last_name, email, roll_no, usn, course, year, section, phone, password) " +
        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    private static final String SELECT_ALL_STUDENTS = "SELECT * FROM students";

    private static final String SELECT_BY_ROLL_AND_PASSWORD =
        "SELECT * FROM students WHERE roll_no = ? AND password = ?";


    private static final String DELETE_STUDENT_SQL = "DELETE FROM students WHERE id = ?";

    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }

    public void insertStudent(Student student) throws SQLException {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_STUDENT_SQL)) {
            ps.setString(1,  student.getName());
            ps.setString(2,  student.getFirstName());
            ps.setString(3,  student.getLastName());
            ps.setString(4,  student.getEmail());
            ps.setString(5,  student.getRollNo());
            ps.setString(6,  student.getUsn());
            ps.setString(7,  student.getCourse());
            ps.setString(8,  student.getYear());
            ps.setString(9,  student.getSection());
            ps.setString(10, student.getPhone());
            ps.setString(11, student.getPassword());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Student> selectAllStudents() {
        List<Student> students = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_ALL_STUDENTS)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                students.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }

    /** Used by API servlet to validate login */
    public Student findByRollAndPassword(String rollNo, String password) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_BY_ROLL_AND_PASSWORD)) {
            ps.setString(1, rollNo.toUpperCase());
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private Student mapRow(ResultSet rs) throws SQLException {
        Student s = new Student(
            safeGet(rs, "first_name"),
            safeGet(rs, "last_name"),
            safeGet(rs, "email"),
            safeGet(rs, "roll_no"),
            safeGet(rs, "usn"),
            safeGet(rs, "course"),
            safeGet(rs, "year"),
            safeGet(rs, "section"),
            safeGet(rs, "phone"),
            safeGet(rs, "password")
        );
        s.setId(rs.getInt("id"));
        String dbName = safeGet(rs, "name");
        if (!dbName.isEmpty()) s.setName(dbName);
        return s;
    }

    /** Returns empty string if the column doesn't exist in this ResultSet */
    private String safeGet(ResultSet rs, String col) {
        try {
            String val = rs.getString(col);
            return val != null ? val : "";
        } catch (SQLException e) {
            return ""; // column not found in old schema
        }
    }
}