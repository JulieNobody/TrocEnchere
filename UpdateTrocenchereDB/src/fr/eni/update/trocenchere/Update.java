package fr.eni.update.trocenchere;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.CallableStatement;
import java.sql.SQLException;


public class Update {
	
	public void update() {
		
	}
	public void up() throws DALException {

		String sql="EXEC dbo.updateArticle";
		
		String urlConnection = "jdbc:sqlserver://127.0.0.1;databasename=TrocEncheres_DB";
		try{
			
			Connection cnx = DriverManager.getConnection(urlConnection,"sa","Pa$$w0rd");


			CallableStatement callstmt = cnx.prepareCall(sql);
			callstmt.execute();

			callstmt.close();
			
		}catch(SQLException e) {
				e.printStackTrace();
			}
		 catch (Exception e) {
			throw new DALException("Erreur ",e);
		}
		
	}
}
