package dao;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;
import java.sql.SQLException;

public class DBConnection {

    private static HikariDataSource dataSource = null;

    private static String getEnv(String... keys) {
        for (String key : keys) {
            String value = System.getenv(key);
            if (value != null && !value.trim().isEmpty()) {
                return value.trim();
            }
        }
        return null;
    }

    private static synchronized void initDataSource() {
        if (dataSource != null) return;

        HikariConfig config = new HikariConfig();

        String url = getEnv("DB_URL");
        if (url == null) {
            String host = getEnv("DB_HOST");
            if (host != null) {
                url = "jdbc:mysql://" + host + ":3306/online_exam?serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";
            }
        }

        String user = getEnv("DB_USER");
        String pass = getEnv("DB_PASS", "DB_PASSWORD");

        if (url == null || user == null || pass == null) {
            throw new IllegalStateException("Missing database environment variables. Required: DB_URL (or DB_HOST), DB_USER, and DB_PASS (or DB_PASSWORD).");
        }

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
