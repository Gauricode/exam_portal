package dao;

import java.sql.*;
import java.util.*;
import model.Result;

public class ResultDAO {

    private boolean hasColumn(ResultSet rs, String columnName) throws SQLException {
        ResultSetMetaData metaData = rs.getMetaData();
        int columnCount = metaData.getColumnCount();
        for (int i = 1; i <= columnCount; i++) {
            if (columnName.equalsIgnoreCase(metaData.getColumnLabel(i))
                    || columnName.equalsIgnoreCase(metaData.getColumnName(i))) {
                return true;
            }
        }
        return false;
    }

    private boolean hasSuspiciousCountColumn(Connection con) {
        try {
            DatabaseMetaData metaData = con.getMetaData();
            try (ResultSet rs = metaData.getColumns(con.getCatalog(), null, "results", "suspiciousCount")) {
                return rs.next();
            }
        } catch (Exception e) {
            return false;
        }
    }

    public List<Result> getResultsByStudentId(int studentId) {
        List<Result> results = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();
            if (con == null) return results;

            String sql = "SELECT * FROM results WHERE studentId=? ORDER BY resultDate DESC";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, studentId);

                try (ResultSet rs = ps.executeQuery()) {
                    boolean hasSuspiciousColumn = false;
                    boolean checkedColumn = false;
                    while (rs.next()) {
                        if (!checkedColumn) {
                            hasSuspiciousColumn = hasColumn(rs, "suspiciousCount");
                            checkedColumn = true;
                        }
                        Result r = new Result(
                                rs.getInt("resultId"),
                                rs.getInt("studentId"),
                                rs.getInt("examId"),
                                rs.getInt("score"),
                                rs.getInt("totalQuestions"),
                                rs.getString("resultDate"),
                                rs.getString("status")
                        );
                        if (hasSuspiciousColumn) {
                            r.setSuspiciousCount(rs.getInt("suspiciousCount"));
                        } else {
                            r.setSuspiciousCount(0);
                        }
                        results.add(r);
                    }
                }
            }
            if (con != null) {
                con.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return results;
    }

    public List<Result> getAllResults() {
        List<Result> results = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();
            if (con == null) return results;

            String sql = "SELECT * FROM results ORDER BY resultDate DESC";
            try (PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                boolean hasSuspiciousColumn = false;
                boolean checkedColumn = false;
                while (rs.next()) {
                    if (!checkedColumn) {
                        hasSuspiciousColumn = hasColumn(rs, "suspiciousCount");
                        checkedColumn = true;
                    }
                    Result r = new Result(
                            rs.getInt("resultId"),
                            rs.getInt("studentId"),
                            rs.getInt("examId"),
                            rs.getInt("score"),
                            rs.getInt("totalQuestions"),
                            rs.getString("resultDate"),
                            rs.getString("status")
                    );
                    if (hasSuspiciousColumn) {
                        r.setSuspiciousCount(rs.getInt("suspiciousCount"));
                    } else {
                        r.setSuspiciousCount(0);
                    }
                    results.add(r);
                }
            }
            if (con != null) {
                con.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return results;
    }

    public boolean addResult(Result result) {
        try {
            Connection con = DBConnection.getConnection();
            if (con == null) return false;

            boolean hasSuspiciousCount = hasSuspiciousCountColumn(con);
            String sql;
            if (hasSuspiciousCount) {
                sql = "INSERT INTO results (studentId, examId, score, totalQuestions, resultDate, status, suspiciousCount) VALUES (?, ?, ?, ?, ?, ?, ?)";
            } else {
                sql = "INSERT INTO results (studentId, examId, score, totalQuestions, resultDate, status) VALUES (?, ?, ?, ?, ?, ?)";
            }

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, result.getStudentId());
                ps.setInt(2, result.getExamId());
                ps.setInt(3, result.getScore());
                ps.setInt(4, result.getTotalQuestions());
                ps.setString(5, result.getResultDate());
                ps.setString(6, result.getStatus());
                if (hasSuspiciousCount) {
                    ps.setInt(7, result.getSuspiciousCount());
                }

                int res = ps.executeUpdate();
                con.close();
                return res > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}
