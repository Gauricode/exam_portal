package model;

import java.io.Serializable;

public class Student implements Serializable {
    private static final long serialVersionUID = 1L;
    private int studentId;
    private String name;
    private String email;

    public Student(){}

    // constructor used after login/lookup
    public Student(int studentId, String name, String email) {
        this.studentId = studentId;
        this.name = name;
        this.email = email;
    }

    // convenience constructor when id not known yet
    public Student(String name, String email) {
        this.name = name;
        this.email = email;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public String getName(){ return name; }
    public void setName(String name){ this.name = name; }

    public String getEmail(){ return email; }
    public void setEmail(String email){ this.email = email; }
}
