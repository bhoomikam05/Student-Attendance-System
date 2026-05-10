<%@ page import="java.sql.*" %>

<table border="1">
<tr>
<th>ID</th><th>Name</th><th>Email</th><th>Course</th>
</tr>

<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/studentdb", "root", "password");

    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("SELECT * FROM students");

    while(rs.next()){
%>
<tr>
<td><%= rs.getInt("id") %></td>
<td><%= rs.getString("name") %></td>
<td><%= rs.getString("email") %></td>
<td><%= rs.getString("course") %></td>
</tr>
<%
    }
} catch(Exception e){
    out.println(e);
}
%>
</table>