# Online Exam System (JAVAPROJECT)

A simple Java-based web application for administering and taking online exams.
The project is built with **Java 21**, **Maven**, **Tomcat 9**, and **MySQL**. It
includes separate views for students and administrators, with data stored in a
MySQL database and accessed via DAOs using HikariCP connection pooling.

---

## Features

- Student registration and login
- Admin authentication and dashboard
- Create exams and add multiple-choice questions
- Students can take exams and view results (includes basic proctoring – tracks tab/window switches, right-clicks, developer tools, fullscreen exit)
- Suspicious activity is counted and if a threshold is exceeded the result is flagged and a violation record is created; admins can review proctoring violations
- Admin can view students, results (shows suspicious counts), and add new questions
- Session-based security and simple JSP interface

---

##  Repository Structure

```
JAVAPROJECT/
├─ src/main/java/controller    # Servlets (LoginServlet, etc.)
├─ src/main/java/dao           # Database access objects
├─ src/main/java/model         # Data models
├─ src/main/webapp             # JSP pages and web resources
│   ├─ admin/                  # Admin pages
│   └─ student/                # Student pages (renamed from "student pages")
├─ database_schema.sql         # Creates schema and sample data
├─ pom.xml                     # Maven build definition
├─ scripts/                    # Utility scripts
└─ README_SETUP.md             # Detailed setup instructions
```

---

##  Prerequisites

Before running the application locally, ensure you have:

- **Java 21 JDK** (or newer)
- **Apache Maven** (3.9+)
- **MySQL Server** (8.0+)
- **Apache Tomcat 9** (or Tomcat 10 if you update to Jakarta namespace)

> Windows-specific instructions provided; adapt commands for other OSes.

---

##  Installation & Setup

1. **Clone the repository**:
   ```bash
   git clone <repo-url> JAVAPROJECT
   cd JAVAPROJECT
   ```

2. **Create the database**:
   Run the SQL script against your MySQL instance:
   ```powershell
   "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -p"<your-password>" < database_schema.sql
   ```

3. **Configure DB credentials** (optional):
   Edit `src/main/java/dao/DBConnection.java` or set the environment
   variables `DB_URL`, `DB_USER`, and `DB_PASS`.

4. **Build the project**:
   ```bash
   mvn clean package
   ```
   The WAR file will be generated in `target/untitled-1.0-SNAPSHOT.war`.

5. **Deploy to Tomcat**:
   ```powershell
   copy target\untitled-1.0-SNAPSHOT.war "C:\Program Files\Apache Software Foundation\Tomcat 9.0\webapps\exam.war"
   set CATALINA_HOME="C:\Program Files\Apache Software Foundation\Tomcat 9.0"
   & "%CATALINA_HOME%\bin\startup.bat"
   ```

6. **Open the application** in your browser:
   `http://localhost:8080/exam/`

---

##  Default Credentials

| Role   | Email               | Password    |
|--------|---------------------|-------------|
| Admin  | admin@example.com   | admin123    |
| Student| john@example.com    | password123 |
| Student| jane@example.com    | password123 |

---

## 🔧 Configuration

- Database pooling settings are defined in `DBConnection.java` using
  HikariCP.
- Servlets are annotated with `@WebServlet` and resolved via the context path.
- JSP pages use `${pageContext.request.contextPath}` to build form actions.

---



