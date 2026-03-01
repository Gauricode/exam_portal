package dao;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;
import java.sql.SQLException;

public class DBConnection {

    private static HikariDataSource dataSource = null;

    private static synchronized void initDataSource() {
        if (dataSource != null) return;

        HikariConfig config = new HikariConfig();

        String url = System.getenv().getOrDefault("DB_URL",
                "jdbc:mysql://localhost:3306/online_exam?serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true");
        String user = System.getenv().getOrDefault("DB_USER", "hero");
        String pass = System.getenv().getOrDefault("DB_PASS", "mysql1845@");

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
