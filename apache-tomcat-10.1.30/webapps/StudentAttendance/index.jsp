<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>RRIT — Add Student</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #4CAF50; --primary-dark: #45a049;
            --accent: #6c63ff;
            --bg: #f0f4f8; --card: #ffffff;
            --text: #1a1a2e; --muted: #64748b; --border: #e2e8f0;
            --error: #ef4444;
        }
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family:'Inter',Arial,sans-serif; background:var(--bg); min-height:100vh; }

        /* NAV */
        .top-nav {
            background:#1a1a2e; padding:14px 32px;
            display:flex; align-items:center; justify-content:space-between; flex-wrap:wrap; gap:12px;
        }
        .nav-brand { color:#fff; font-size:1.1rem; font-weight:800; }
        .nav-links { display:flex; gap:8px; flex-wrap:wrap; }
        .nav-links a {
            padding:7px 16px; border-radius:8px; text-decoration:none;
            font-size:0.85rem; font-weight:600; transition:all 0.2s;
        }
        .nav-links a.active { background:var(--primary); color:#fff; }
        .nav-links a.leave-link { background:linear-gradient(135deg,#6c63ff,#43e97b); color:#fff; }
        .nav-links a.secondary { color:#a0aec0; border:1px solid #2d3748; }
        .nav-links a.secondary:hover { color:#fff; border-color:#4a5568; }

        /* INFO BANNER */
        .info-banner {
            background:linear-gradient(135deg,#6c63ff15,#43e97b10);
            border-bottom:1px solid #6c63ff33;
            padding:12px 32px;
            display:flex; align-items:center; gap:10px; flex-wrap:wrap;
        }
        .info-banner span { font-size:0.88rem; color:#4a5568; }
        .info-banner strong { color:#6c63ff; }

        /* FORM */
        .page-wrap { display:flex; justify-content:center; padding:40px 20px; }
        .container {
            width:100%; max-width:580px;
            background:var(--card); padding:40px 36px;
            border-radius:16px; box-shadow:0 4px 24px rgba(0,0,0,0.08);
            border:1px solid var(--border);
        }
        .container-header { text-align:center; margin-bottom:32px; }
        .container-header .icon { font-size:2.5rem; display:block; margin-bottom:10px; }
        h2 { font-size:1.5rem; color:var(--text); font-weight:800; }
        .container-header p { color:var(--muted); font-size:0.88rem; margin-top:6px; }

        .section-divider {
            display:flex; align-items:center; gap:12px; margin:24px 0 20px;
        }
        .section-divider::before, .section-divider::after {
            content:''; flex:1; height:1px; background:var(--border);
        }
        .section-divider span { color:var(--muted); font-size:0.78rem; font-weight:700; text-transform:uppercase; letter-spacing:0.8px; white-space:nowrap; }

        .form-row { display:flex; gap:14px; }
        .form-group { margin-bottom:18px; flex:1; }
        label {
            display:block; margin-bottom:7px;
            font-size:0.8rem; font-weight:700; color:var(--muted);
            text-transform:uppercase; letter-spacing:0.5px;
        }
        label .required { color:var(--error); margin-left:2px; }
        input[type="text"], input[type="email"], input[type="password"], input[type="tel"], select {
            width:100%; padding:11px 14px;
            border:1.5px solid var(--border); border-radius:10px;
            font-family:'Inter',sans-serif; font-size:0.92rem; color:var(--text);
            transition:all 0.2s; outline:none; background:#fafbfc;
            -webkit-appearance:none;
        }
        input:focus, select:focus {
            border-color:var(--primary); background:#fff;
            box-shadow:0 0 0 3px rgba(76,175,80,0.12);
        }
        input::placeholder { color:#b0bac5; }
        select option { background:#fff; color:var(--text); }

        .pw-wrap { position:relative; }
        .toggle-pw { position:absolute; right:12px; top:50%; transform:translateY(-50%); background:none; border:none; cursor:pointer; color:var(--muted); font-size:1rem; }

        .note-box {
            background:rgba(108,99,255,0.07); border:1px solid rgba(108,99,255,0.25);
            border-radius:10px; padding:12px 16px; margin-bottom:20px;
            font-size:0.84rem; color:#5a52d5; line-height:1.5;
            display:flex; align-items:flex-start; gap:8px;
        }

        button[type="submit"] {
            width:100%; padding:13px;
            background:linear-gradient(135deg,var(--primary),var(--primary-dark));
            color:white; border:none; border-radius:10px;
            cursor:pointer; font-size:0.95rem; font-weight:700;
            font-family:'Inter',sans-serif; transition:all 0.2s; margin-top:4px;
        }
        button[type="submit"]:hover { transform:translateY(-2px); box-shadow:0 6px 20px rgba(76,175,80,0.35); }

        .bottom-links {
            display:flex; justify-content:center; gap:24px; margin-top:22px; flex-wrap:wrap;
        }
        .bottom-links a {
            color:var(--muted); text-decoration:none; font-size:0.88rem; font-weight:500;
            display:flex; align-items:center; gap:5px; transition:color 0.2s;
        }
        .bottom-links a:hover { color:var(--text); }
        .bottom-links a.highlight { color:#6c63ff; font-weight:700; }

        /* Success toast */
        .toast {
            position:fixed; bottom:24px; right:24px; z-index:1000;
            background:#4CAF50; color:#fff; font-weight:700;
            padding:14px 24px; border-radius:12px;
            box-shadow:0 8px 30px rgba(76,175,80,0.4);
            transform:translateY(80px); opacity:0;
            transition:all 0.4s; font-family:'Inter',sans-serif; font-size:0.9rem;
        }
        .toast.show { transform:translateY(0); opacity:1; }
    </style>
</head>
<body>

    <nav class="top-nav">
        <div class="nav-brand">🎓 RRIT — Student Management</div>
        <div class="nav-links">
            <a href="index.jsp" class="active">Add Student</a>
            <a href="view.jsp" class="secondary">View Students</a>
            <a href="leave-system/index.html" class="leave-link">📋 Leave & Attendance</a>
        </div>
    </nav>

    <div class="info-banner">
        <span>ℹ️ Students added here are saved to the <strong>MySQL database</strong> AND automatically registered for the <strong>Leave & Attendance Portal</strong>. They can login to the leave portal using their Roll No. and password set below.</span>
    </div>

    <div class="page-wrap">
        <div class="container">
            <div class="container-header">
                <span class="icon">🧑‍🎓</span>
                <h2>Add New Student</h2>
                <p>Student will be saved to the server database and can login to the Leave Portal</p>
            </div>

            <div class="note-box">
                🔑 The <strong>Roll Number</strong> and <strong>Password</strong> you set here will be used by the student to login to the <strong>Leave & Attendance System</strong>.
            </div>

            <form id="addStudentForm" action="student" method="post" onsubmit="saveToLeaveSystem(event)">
                <input type="hidden" name="action" value="insert">

                <!-- Basic Info -->
                <div class="section-divider"><span>Basic Information</span></div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="firstName">First Name <span class="required">*</span></label>
                        <input type="text" id="firstName" name="firstName" placeholder="Ayush" required>
                    </div>
                    <div class="form-group">
                        <label for="lastName">Last Name <span class="required">*</span></label>
                        <input type="text" id="lastName" name="lastName" placeholder="Sharma" required>
                    </div>
                </div>

                <!-- Hidden combined name for old servlet -->
                <input type="hidden" id="name" name="name">

                <div class="form-group">
                    <label for="email">Email Address <span class="required">*</span></label>
                    <input type="email" id="email" name="email" placeholder="student@college.edu" required>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="rollNo">Roll Number <span class="required">*</span></label>
                        <input type="text" id="rollNo" name="rollNo" placeholder="CS2024001" required>
                    </div>
                    <div class="form-group">
                        <label for="usn">USN <span class="required">*</span></label>
                        <input type="text" id="usn" name="usn" placeholder="e.g. 1RR21CS001" required
                            style="text-transform:uppercase;"
                            title="University Serial Number assigned by the institution">
                    </div>
                </div>

                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input type="tel" id="phone" name="phone" placeholder="10-digit mobile number" maxlength="10">
                </div>

                <!-- Academic Info -->
                <div class="section-divider"><span>Academic Details</span></div>

                <div class="form-group">
                    <label for="course">Course <span class="required">*</span></label>
                    <select id="course" name="course" required>
                        <option value="">Select Course</option>
                        <option>B.Tech CSE</option>
                        <option>B.Tech IT</option>
                        <option>B.Tech ECE</option>
                        <option>B.Tech Mechanical</option>
                        <option>BCA</option>
                        <option>MCA</option>
                        <option>MBA</option>
                    </select>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="year">Year <span class="required">*</span></label>
                        <select id="year" name="year" required>
                            <option value="">Year</option>
                            <option>1st Year</option>
                            <option>2nd Year</option>
                            <option>3rd Year</option>
                            <option>4th Year</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="section">Section <span class="required">*</span></label>
                        <input type="text" id="section" name="section" placeholder="e.g. A" required>
                    </div>
                </div>

                <!-- Leave Portal Password -->
                <div class="section-divider"><span>Leave Portal Login Password</span></div>

                <div class="form-group">
                    <label for="password">Set Password <span class="required">*</span></label>
                    <div class="pw-wrap">
                        <input type="password" id="password" name="password" placeholder="Min 6 characters" required minlength="6">
                        <button type="button" class="toggle-pw" onclick="togglePw()">👁</button>
                    </div>
                </div>

                <button type="submit">Add Student & Register for Leave Portal →</button>
            </form>

            <div class="bottom-links">
                <a href="view.jsp">📋 View All Students</a>
                <a href="leave-system/index.html" class="highlight">📝 Leave System →</a>
            </div>
        </div>
    </div>

    <div class="toast" id="toast">✅ Student added to DB and Leave Portal!</div>

    <script>
        function togglePw() {
            const inp = document.getElementById('password');
            inp.type = inp.type === 'password' ? 'text' : 'password';
        }

        function saveToLeaveSystem(e) {
            // Set combined name for the servlet
            const first = document.getElementById('firstName').value.trim();
            const last  = document.getElementById('lastName').value.trim();
            document.getElementById('name').value = first + ' ' + last;

            const rollNo   = document.getElementById('rollNo').value.trim().toUpperCase();
            const usn      = document.getElementById('usn').value.trim().toUpperCase();
            const email    = document.getElementById('email').value.trim().toLowerCase();
            const course   = document.getElementById('course').value;
            const year     = document.getElementById('year').value;
            const section  = document.getElementById('section').value.trim().toUpperCase();
            const phone    = document.getElementById('phone').value.trim();
            const password = document.getElementById('password').value;

            // Load existing students from localStorage
            const students = JSON.parse(localStorage.getItem('eduLeave_students') || '[]');

            // Check for duplicate roll
            const dupRoll = students.find(s => s.rollNo === rollNo);
            if (dupRoll) {
                e.preventDefault();
                alert('⚠️ A student with Roll No. "' + rollNo + '" is already registered in the Leave Portal.');
                return false;
            }

            // Save this student to localStorage so they can login to the leave portal
            const newStudent = {
                id: Date.now().toString(),
                firstName: first,
                lastName: last,
                name: first + ' ' + last,
                rollNo, usn, email, course, year, section, phone, password,
                registeredAt: new Date().toISOString(),
                addedByAdmin: true,   // flag: registered via admin (index.jsp)
                profileComplete: false // student must fill extra details on first login
            };
            students.push(newStudent);
            localStorage.setItem('eduLeave_students', JSON.stringify(students));

            // Show toast briefly (form will submit and page will reload)
            const toast = document.getElementById('toast');
            toast.classList.add('show');
            // Allow form to continue submitting to servlet
            return true;
        }
    </script>
</body>
</html>