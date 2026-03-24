package dao;

import java.sql.Connection;
import java.sql.SQLException;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;



public class DBConnection {

    private static HikariDataSource dataSource = null;

    private static synchronized void initDataSource() {
        if (dataSource != null) return;

        HikariConfig config = new HikariConfig();

        // Hardcoded database configuration for Tomcat
        String url = "jdbc:mysql://localhost:3306/online_exam?serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";
        String user = "root";
        String pass = "narangavellam";

        config.setJdbcUrl(url);
        config.setUsername(user);
        config.setPassword(pass);
        config.setDriverClassName("com.mysql.cj.jdbc.Driver");

        config.setMaximumPoolSize(10);
        config.setMinimumIdle(2);
        config.setPoolName("HikariCP-OnlineExam");

        config.addDataSourceProperty("cachePrepStmts", "true");
        config.addDataSourceProperty("prepStmtCacheSize", "250");
        config.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");

        dataSource = new HikariDataSource(config);
    }

    public static Connection getConnection() {
        try {
            if (dataSource == null) initDataSource();
            return dataSource.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static void closeDataSource() {
        if (dataSource != null) {
            dataSource.close();
            dataSource = null;
        }
    }
}
