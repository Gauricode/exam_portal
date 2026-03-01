# Setup and Run Instructions for Online Exam Application

This document outlines the steps required to set up the environment and run the Online Exam web application from scratch.

## Prerequisites

1. **Operating System**
   - Windows (instructions tailored for Windows). Adapt accordingly for Linux/macOS.
2. **Java JDK**
   - Install JDK 21 or later.
   - Add `JAVA_HOME` environment variable pointing to the JDK installation directory.
   - Add `%JAVA_HOME%\bin` to the `PATH`.
3. **Apache Maven**
   - Download Maven (3.9.x recommended).
   - Unzip to a folder and add the `bin` directory to the `PATH`.
   - Verify with `mvn -v` which should print Maven version and Java details.
4. **MySQL Server**
   - Install MySQL Server 8.0+.
   - During installation note the root password.
   - (Optional) create a user `hero` with password `mysql1845@` or adjust DBConnection configuration.
5. **Apache Tomcat**
   - Download Tomcat 9 (or 10 if using Jakarta namespace) from the Apache archive.
   - Extract to a directory such as `C:\Program Files\Apache Software Foundation\Tomcat 9.0`.
   - Set `CATALINA_HOME` environment variable to the Tomcat installation path.

## Database Setup

1. Open a command prompt or PowerShell and navigate to the project root.
2. Run the SQL script to create the database and insert sample data:
   ```powershell
   "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -p"<your-root-password>" < database_schema.sql
   ```
3. Check that the `online_exam` database and tables exist:
   ```sql
   USE online_exam;
   SHOW TABLES;
   ```

## Configure Application

1. Open `src/main/java/dao/DBConnection.java` and ensure the JDBC URL, user, and password match your MySQL setup.
   - Default user is `hero`, password `mysql1845@`.
   - You can also set environment variables `DB_URL`, `DB_USER`, and `DB_PASS` to override.

## Build and Deploy

1. From project root run:
   ```bash
   mvn clean package
   ```
   This produces `target/untitled-1.0-SNAPSHOT.war`.
2. Copy the WAR to Tomcat's webapps directory and rename as desired (e.g. `exam.war`):
   ```powershell
   copy target\untitled-1.0-SNAPSHOT.war "C:\Program Files\Apache Software Foundation\Tomcat 9.0\webapps\exam.war"
   ```
3. Start Tomcat:
   ```powershell
   set CATALINA_HOME="C:\Program Files\Apache Software Foundation\Tomcat 9.0"
   & "%CATALINA_HOME%\bin\startup.bat"
   ```
4. Access the application at `http://localhost:8080/exam/`.

## User Credentials

- **Admin**
  - Email: `admin@example.com`
  - Password: `admin123`
- **Students** (sample accounts)
  - `john@example.com` / `password123`
  - `jane@example.com` / `password123`

## App Structure and Notes

- `src/main/java/controller` contains servlets mapped via `@WebServlet`.
- JSP pages are under `src/main/webapp` including `student pages` (note space) and `admin` directory.
- Database connections use HikariCP with configuration in `DBConnection.java`.
- Tomcat 9 uses `javax.servlet` API; code imports have been adjusted accordingly.

## Running Locally

- After Tomcat starts, use a browser to navigate to the app.
- Student login: submit credentials on the main page.
- Admin login: go to `http://localhost:8080/exam/admin/adminLogin.jsp` and use admin credentials.

## Troubleshooting

- **404 errors for servlets**: ensure context path is included in form `action` (use `${pageContext.request.contextPath}`).
- **Database connection errors**: check `DBConnection` credentials and that MySQL server is running.
- **Tomcat environment variables**: set `CATALINA_HOME` before running startup/shutdown.

---

These steps should allow anyone to recreate the entire environment and run the application from a fresh machine.