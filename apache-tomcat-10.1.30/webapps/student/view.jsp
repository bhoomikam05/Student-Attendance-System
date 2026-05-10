<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.student.dao.StudentDAO" %>
<%@ page import="com.student.model.Student" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>RRIT — View Students</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #4CAF50;
            --accent: #6c63ff;
            --bg: #f0f4f8;
            --card: #ffffff;
            --text: #1a1a2e;
            --muted: #64748b;
            --border: #e2e8f0;
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Inter', Arial, sans-serif; background: var(--bg); min-height: 100vh; }

        /* ---- NAV ---- */
        .top-nav {
            background: #1a1a2e;
            padding: 14px 32px;
            display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 12px;
        }
        .nav-brand { color: #fff; font-size: 1.1rem; font-weight: 800; display: flex; align-items: center; gap: 10px; }
        .nav-links { display: flex; gap: 8px; flex-wrap: wrap; }
        .nav-links a {
            padding: 7px 16px; border-radius: 8px; text-decoration: none;
            font-size: 0.85rem; font-weight: 600; transition: all 0.2s;
        }
        .nav-links a.active { background: var(--primary); color: #fff; }
        .nav-links a.leave-link { background: linear-gradient(135deg, #6c63ff, #43e97b); color: #fff; }
        .nav-links a.secondary { color: #a0aec0; border: 1px solid #2d3748; }
        .nav-links a.secondary:hover { color: #fff; border-color: #4a5568; }

        /* ---- BANNER ---- */
        .leave-banner {
            background: linear-gradient(135deg, #6c63ff22, #43e97b18);
            border-bottom: 1px solid #6c63ff44;
            padding: 14px 32px;
            display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 12px;
        }
        .leave-banner p { font-size: 0.9rem; color: #4a5568; font-weight: 500; }
        .leave-banner p strong { color: #6c63ff; }
        .banner-btn {
            padding: 8px 18px; border-radius: 8px; font-size: 0.85rem;
            font-weight: 700; text-decoration: none; transition: all 0.2s;
        }
        .banner-btn.primary { background: #6c63ff; color: #fff; }
        .banner-btn.primary:hover { background: #5a52d5; }

        /* ---- MAIN ---- */
        .page-wrap { padding: 40px 32px; max-width: 1100px; margin: 0 auto; }

        .page-header {
            display: flex; align-items: center; justify-content: space-between;
            flex-wrap: wrap; gap: 16px; margin-bottom: 28px;
        }
        .page-header h2 { font-size: 1.6rem; font-weight: 800; color: var(--text); }
        .page-header p { color: var(--muted); font-size: 0.9rem; margin-top: 4px; }
        .header-actions { display: flex; gap: 10px; flex-wrap: wrap; }
        .btn {
            padding: 10px 20px; border-radius: 10px; font-size: 0.88rem; font-weight: 700;
            text-decoration: none; transition: all 0.2s; display: inline-block; border: none; cursor: pointer;
        }
        .btn-green { background: var(--primary); color: #fff; }
        .btn-green:hover { background: #45a049; }
        .btn-purple { background: #6c63ff; color: #fff; }
        .btn-purple:hover { background: #5a52d5; }
        .btn-outline { background: #fff; color: var(--muted); border: 1.5px solid var(--border); }
        .btn-outline:hover { color: var(--text); border-color: #aaa; }

        /* ---- TABLE ---- */
        .table-card {
            background: var(--card); border-radius: 16px;
            border: 1px solid var(--border);
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
            overflow: hidden;
        }
        table { width: 100%; border-collapse: collapse; }
        thead tr { background: #f8fafc; }
        th {
            padding: 14px 20px; text-align: left;
            font-size: 0.78rem; font-weight: 700; color: var(--muted);
            text-transform: uppercase; letter-spacing: 0.6px;
            border-bottom: 1px solid var(--border);
        }
        td { padding: 16px 20px; border-bottom: 1px solid var(--border); font-size: 0.92rem; color: var(--text); vertical-align: middle; }
        tbody tr:last-child td { border-bottom: none; }
        tbody tr:hover td { background: #f8fafc; }

        .student-id { font-size: 0.8rem; color: var(--muted); font-weight: 600; }
        .course-badge {
            display: inline-block; padding: 4px 12px; border-radius: 50px;
            background: rgba(76,175,80,0.1); color: var(--primary);
            font-size: 0.8rem; font-weight: 600; border: 1px solid rgba(76,175,80,0.2);
        }
        .actions-cell { display: flex; gap: 8px; }
        .act-btn {
            padding: 5px 14px; border-radius: 7px; font-size: 0.8rem; font-weight: 600;
            text-decoration: none; border: none; cursor: pointer; transition: all 0.2s;
        }
        .act-leave { background: rgba(108,99,255,0.1); color: #6c63ff; border: 1px solid rgba(108,99,255,0.25); }
        .act-leave:hover { background: #6c63ff; color: #fff; }

        .empty-row td { text-align: center; padding: 48px; color: var(--muted); font-size: 1rem; }

        .bottom-links {
            display: flex; gap: 16px; margin-top: 24px; flex-wrap: wrap;
        }
    </style>
</head>
<body>

    <!-- Nav -->
    <nav class="top-nav">
        <div class="nav-brand">🎓 RRIT — Student Management</div>
        <div class="nav-links">
            <a href="index.jsp" class="secondary">Add Student</a>
            <a href="view.jsp" class="active">View Students</a>
            <a href="leave-system/index.html" class="leave-link">📋 Leave & Attendance System</a>
        </div>
    </nav>

    <!-- Leave Banner -->
    <div class="leave-banner">
        <p>🔗 Connected to <strong>EduLeave</strong> — Click "View Leaves" next to any student to see their leave history.</p>
        <a href="leave-system/hod-portal.html" class="banner-btn primary">HOD Portal →</a>
    </div>

    <div class="page-wrap">
        <div class="page-header">
            <div>
                <h2>All Students</h2>
                <p>Students registered in the database via the server-side system</p>
            </div>
            <div class="header-actions">
                <a href="leave-system/student-register.html" class="btn btn-purple">📝 Leave Registration</a>
                <a href="index.jsp" class="btn btn-green">+ Add Student</a>
            </div>
        </div>

        <div class="table-card">
            <%
                StudentDAO studentDAO = new StudentDAO();
                List<Student> students = studentDAO.selectAllStudents();
            %>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Course</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (students == null || students.isEmpty()) { %>
                    <tr class="empty-row"><td colspan="5">📭 No students found. <a href="index.jsp">Add the first student →</a></td></tr>
                    <% } else { %>
                    <% for (Student student : students) { %>
                    <tr>
                        <td><span class="student-id">#<%= student.getId() %></span></td>
                        <td><strong><%= student.getName() %></strong></td>
                        <td><%= student.getEmail() %></td>
                        <td><span class="course-badge"><%= student.getCourse() %></span></td>
                        <td>
                            <div class="actions-cell">
                                <a href="leave-system/hod-portal.html" class="act-btn act-leave">📋 View Leaves</a>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                    <% } %>
                </tbody>
            </table>
        </div>

        <div class="bottom-links">
            <a href="index.jsp" class="btn btn-outline">← Add New Student</a>
            <a href="leave-system/index.html" class="btn btn-purple">Open Leave System →</a>
            <a href="leave-system/teacher-portal.html" class="btn btn-outline">👩‍🏫 Teacher Portal</a>
        </div>
    </div>

</body>
</html>