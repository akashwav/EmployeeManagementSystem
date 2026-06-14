package com.ems.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = ConfigUtil.get("DB_URL");
    private static final String USER = ConfigUtil.get("DB_USER");
    private static final String PASS = ConfigUtil.get("DB_PASS");

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        // Load the MySQL JDBC Driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        // Establish and return the connection
        return DriverManager.getConnection(URL, USER, PASS);
    }
}