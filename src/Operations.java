import javax.swing.*;
import java.sql.*;


public class Operations {

    //Возвращает объект подключения к БД
    private static Connection getConn() throws SQLException{
        final String url = "jdbc:postgresql://localhost/postgres";
        final String user = "postgres";
        final String password = "avuzero4";
        return DriverManager.getConnection(url, user, password);
    }
    //Вставка в таблицу
    public void InsertInTable(int id, String product, String cena) throws SQLException {

        Connection conn = Operations.getConn();
        String SQL = "INSERT INTO magazin VALUES(?,?,?)";

        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setInt(1, id);
            pstmt.setString(2, product);
            pstmt.setString(3,cena);
            pstmt.executeUpdate();
            System.out.println("Succes insert");
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }
    //Обновление табицы
    public void UpdateTable(String col, String value, int id) throws SQLException{
        Connection conn = Operations.getConn();
        String SQL = "UPDATE magazin SET " + col + " = ? WHERE id = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {

            pstmt.setString(1, value);
            pstmt.setInt(2, id);
            pstmt.executeUpdate();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }
    //Удаление строки по id
    public void DeleteFromTable(int id) throws SQLException{
        Connection conn = Operations.getConn();
        String SQL = "DELETE FROM magazin WHERE id = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    //Откат на количество операций num
    public void backNum(int num) throws SQLException{
        Connection conn = Operations.getConn();
        String SQL = "SELECT func_back_num(?);";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setInt(1,num);
            pstmt.executeQuery();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    //откат по времени
    public void backTime(Timestamp t) throws SQLException{
        Connection conn = Operations.getConn();
        String SQL = "SELECT func_back_time(?);";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setTimestamp(1,t);
            pstmt.executeQuery();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    //Восстановление отката
    public void func_return(int num) throws SQLException{
        Connection conn = Operations.getConn();
        String SQL = "SELECT func_return(?);";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setInt(1,num);
            pstmt.executeQuery();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    //Возвращает таблицу с данными для обновления таблицы
    public JTable getData(String nameTable) throws SQLException{
        Connection conn = Operations.getConn();
        String SQL = "";
        if (nameTable.equals("journal_history")) SQL = "SELECT * FROM journal_history ORDER BY time_action ASC";
        else  SQL = "SELECT * FROM " + nameTable;
        JTable table = null;
        try (Statement stmt = conn.createStatement(
                ResultSet.TYPE_SCROLL_INSENSITIVE,
                ResultSet.CONCUR_READ_ONLY);) {
            ResultSet rs = stmt.executeQuery(SQL);
            ResultSetMetaData rsmd = rs.getMetaData();
            int count_col = rsmd.getColumnCount();
            int count_line = 0;
            String[] nameOfColumns = new String[count_col];
            for (int i = 1; i <= count_col ; i++) {
                nameOfColumns[i - 1] = rsmd.getColumnName(i);
            }
            while (rs.next()){
                count_line++;
            }
            rs.beforeFirst();
            String[][] data = new String[count_line][count_col];
            for (int k = 0; k < count_line; k++) {
                if (rs.next()) {
                    for (int l = 0; l < count_col; l++) {
                        data[k][l] = rs.getString(l + 1);
                    }
                }
            }
            table = new JTable(data, nameOfColumns);
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return table;
    }

}
