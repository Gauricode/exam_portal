# Online Proctored Examination System

## Complete Step-by-Step Setup Guide (VS Code + MySQL + Tomcat)

------------------------------------------------------------------------

## 1. Software Requirements

Install the following software before starting:

1.  Java JDK 17 or above\
2.  Apache Tomcat 10+\
3.  MySQL Server\
4.  MySQL Workbench (optional but recommended)\
5.  VS Code\
6.  VS Code Extensions:
    -   Extension Pack for Java
    -   Tomcat for Java
    -   Language Support for Java
    -   JSP Support

------------------------------------------------------------------------

## 2. Create Project Folder Structure

Create a new folder:

OnlineProctoredExamSystem

Inside it create:

OnlineProctoredExamSystem/ │ ├── src/ │ ├── controller/ │ ├── model/ │
└── dao/ │ ├── webapp/ │ ├── css/ │ ├── js/ │ ├── images/ │ ├── admin/ │
├── student/ │ └── WEB-INF/ │ └── web.xml │ └── lib/

Open this folder in VS Code.

------------------------------------------------------------------------

## 3. Setup MySQL Database

1.  Open MySQL Workbench.
2.  Create a database:

CREATE DATABASE online_exam;

3.  Use the database:

USE online_exam;

4.  Create tables:

CREATE TABLE users ( id INT PRIMARY KEY AUTO_INCREMENT, name
VARCHAR(100), email VARCHAR(100), password VARCHAR(100), role
VARCHAR(20) );

CREATE TABLE exams ( id INT PRIMARY KEY AUTO_INCREMENT, title
VARCHAR(100), duration INT, total_marks INT );

CREATE TABLE questions ( id INT PRIMARY KEY AUTO_INCREMENT, exam_id INT,
question TEXT, option1 VARCHAR(255), option2 VARCHAR(255), option3
VARCHAR(255), option4 VARCHAR(255), correct_option INT );

CREATE TABLE results ( id INT PRIMARY KEY AUTO_INCREMENT, user_id INT,
exam_id INT, score INT, percentage DOUBLE );

------------------------------------------------------------------------

## 4. Add MySQL JDBC Driver

1.  Download MySQL Connector/J (JDBC Driver).
2.  Copy the .jar file.
3.  Paste it inside the lib/ folder.
4.  Add it to your project build path.

------------------------------------------------------------------------

## 5. Configure web.xml

Inside WEB-INF create web.xml:

`<web-app>`{=html} `<welcome-file-list>`{=html}
`<welcome-file>`{=html}index.jsp`</welcome-file>`{=html}
`</welcome-file-list>`{=html} `</web-app>`{=html}

------------------------------------------------------------------------

## 6. Create Database Connection (DAO Layer)

Inside src/dao create:

DBConnection.java

------------------------------------------------------------------------

import java.sql.\*;

public class DBConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/online_exam";
    private static final String USER = "root";
    private static final String PASSWORD = "yourpassword";

    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

}

------------------------------------------------------------------------

------------------------------------------------------------------------

## 7. Create MVC Structure

Model: - User.java - Exam.java - Question.java - Result.java

Controller (Servlet): - LoginServlet.java - ExamServlet.java -
ResultServlet.java

View (JSP): - index.jsp - adminDashboard.jsp - studentDashboard.jsp -
exam.jsp - result.jsp

------------------------------------------------------------------------

## 8. Configure Tomcat in VS Code

1.  Install Tomcat extension.
2.  Add Tomcat server path.
3.  Right click project → Run on Server.
4.  Open in browser: http://localhost:8080/OnlineProctoredExamSystem

------------------------------------------------------------------------

## 9. Implement Features

✔ User Login Authentication\
✔ Admin Dashboard\
✔ Student Dashboard\
✔ Create Exam\
✔ Start Exam with Timer\
✔ Auto Submission\
✔ Result Generation\
✔ Window Focus Monitoring using JavaScript\
✔ Webcam Permission Check

------------------------------------------------------------------------

## 10. Run the Project

1.  Start MySQL server.
2.  Start Tomcat server.
3.  Deploy project.
4.  Open browser and test login.

------------------------------------------------------------------------

## 11. MVC Flow Summary

Browser → JSP (View)\
Servlet (Controller) → Business Logic\
DAO → JDBC\
JDBC → MySQL Database

------------------------------------------------------------------------

## Project is Now Ready

You can extend this system by: - Adding webcam recording - Adding AI
cheating detection - Adding email result notification - Deploying to
cloud server

------------------------------------------------------------------------

End of Setup Guide
