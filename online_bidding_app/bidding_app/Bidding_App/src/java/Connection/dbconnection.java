/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Vector;
import javax.swing.JOptionPane;
/**
 *
 * @author admin
 */
public class dbconnection {
    private ResultSetMetaData rsm = null;
    private Connection con = null;
    private Vector rowData = null;
    private Statement st = null;
    private ResultSet rs = null;
    public dbconnection() {
        try {
            if (con == null) {
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bidding","root","");
                st = con.createStatement();
            }
        } catch (ClassNotFoundException | SQLException er) {
            System.out.println("db Access failed.." + er);
        }
    }    
    //PUTDATA
    public int putData(String qry) {
        try {
            return st.executeUpdate(qry);
        } catch (SQLException e) {
            System.out.println("Access failed.." + e);
        }
        return 0;
    }
    //GET DATA
    public Vector getData(String qry) {
        try {
            rowData = new Vector();
            rs = st.executeQuery(qry);
            rsm = rs.getMetaData();
            int colCount = rsm.getColumnCount();
            while (rs.next()) {
                Vector colVector = new Vector();
                for (int i = 0; i < colCount; i++) {
                    colVector.add(rs.getString((i +1)));
                }
                rowData.add(colVector);
            }
            return rowData;
        } catch (SQLException e) {
            System.out.println("Access failed.." + e);
        }
        return rowData;
    }
}