import java.sql.Connection;
import dao.DBConnection;

public class TestConnection {
    public static void main(String[] args) {
        try {
            Connection con = DBConnection.getConnection();
            if (con != null) {
                System.out.println("Database Connected Successfully!");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
