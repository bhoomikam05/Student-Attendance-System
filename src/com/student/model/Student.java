package com.student.model;

public class Student {
    private int    id;
    private String name;
    private String firstName;
    private String lastName;
    private String email;
    private String rollNo;
    private String usn;
    private String course;
    private String year;
    private String section;
    private String phone;
    private String password;

    // Constructor for old code compatibility (name, email, course)
    public Student(String name, String email, String course) {
        this.name    = name;
        this.email   = email;
        this.course  = course;
        // Split name into first/last for convenience
        String[] parts = name.trim().split("\\s+", 2);
        this.firstName = parts[0];
        this.lastName  = parts.length > 1 ? parts[1] : "";
    }

    // Full constructor
    public Student(String firstName, String lastName, String email,
                   String rollNo, String usn, String course,
                   String year, String section, String phone, String password) {
        this.firstName = firstName;
        this.lastName  = lastName;
        this.name      = firstName + " " + lastName;
        this.email     = email;
        this.rollNo    = rollNo;
        this.usn       = usn;
        this.course    = course;
        this.year      = year;
        this.section   = section;
        this.phone     = phone;
        this.password  = password;
    }

    // Getters & Setters
    public int    getId()        { return id; }
    public void   setId(int id)  { this.id = id; }

    public String getName()                { return name; }
    public void   setName(String name)     { this.name = name; }

    public String getFirstName()                     { return firstName != null ? firstName : ""; }
    public void   setFirstName(String firstName)     { this.firstName = firstName; }

    public String getLastName()                      { return lastName != null ? lastName : ""; }
    public void   setLastName(String lastName)       { this.lastName = lastName; }

    public String getEmail()               { return email; }
    public void   setEmail(String email)   { this.email = email; }

    public String getRollNo()                  { return rollNo != null ? rollNo : ""; }
    public void   setRollNo(String rollNo)     { this.rollNo = rollNo; }

    public String getUsn()                 { return usn != null ? usn : ""; }
    public void   setUsn(String usn)       { this.usn = usn; }

    public String getCourse()              { return course; }
    public void   setCourse(String course) { this.course = course; }

    public String getYear()                { return year != null ? year : ""; }
    public void   setYear(String year)     { this.year = year; }

    public String getSection()                 { return section != null ? section : ""; }
    public void   setSection(String section)   { this.section = section; }

    public String getPhone()               { return phone != null ? phone : ""; }
    public void   setPhone(String phone)   { this.phone = phone; }

    public String getPassword()                { return password != null ? password : ""; }
    public void   setPassword(String password) { this.password = password; }

    /** Returns a JSON representation of this student (without password for security) */
    public String toJson(boolean includePassword) {
        return "{"
            + "\"id\":"          + id                        + ","
            + "\"name\":\""      + esc(name)       + "\","
            + "\"firstName\":\"" + esc(firstName)  + "\","
            + "\"lastName\":\""  + esc(lastName)   + "\","
            + "\"email\":\""     + esc(email)      + "\","
            + "\"rollNo\":\""    + esc(rollNo)     + "\","
            + "\"usn\":\""       + esc(usn)        + "\","
            + "\"course\":\""    + esc(course)     + "\","
            + "\"year\":\""      + esc(year)       + "\","
            + "\"section\":\""   + esc(section)    + "\","
            + "\"phone\":\""     + esc(phone)      + "\","
            + (includePassword ? "\"password\":\"" + esc(password) + "\"," : "")
            + "\"profileComplete\":false"
            + "}";
    }

    private String esc(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}