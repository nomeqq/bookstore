/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package dbquery;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author tigerpeasant
 */
public class Books {
    private final Connection conn;
    private final Statement stmt;
    public Books() throws ClassNotFoundException, InstantiationException, InstantiationException, IllegalAccessException, SQLException{
        Class.forName("org.apache.derby.jdbc.ClientDriver").newInstance(); 
        String url = "jdbc:derby://localhost:1527/abc"; 
        String user = "abc"; 
        String passWord = "abc"; 
        conn = DriverManager.getConnection(url, user, passWord);
        stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
    }
                
    /**
     *
     * @param query
     */
    public ResultSet raw_query(String query) throws SQLException{
        ResultSet rs = stmt.executeQuery(buildQuery(query));
        return rs;
    }
    
    public ResultSet query(String name,String value) throws SQLException{
        return raw_query(name+"='"+value+"'");
    }
    
    public ResultSet querylike(String name,String value) throws SQLException{
        return raw_query(name+" like "+"'%"+value+"%'");
    }

    private String buildQuery(String query) {
        return "select * from BOOKS where " + query;
    }
}
