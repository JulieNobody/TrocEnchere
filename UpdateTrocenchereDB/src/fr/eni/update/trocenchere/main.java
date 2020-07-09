package fr.eni.update.trocenchere;
import fr.eni.update.trocenchere.Update;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;


import fr.eni.update.trocenchere.ConnectionProvider;


public class main {

	
	public static void main(String[] args) {

	try {	
		Update update= new Update();
		while(true) {
			System.out.println("Mise a jour");
			 synchronized(update) {
			      update.wait(10000);
			    }
		update.up();
		}
	}catch(DALException e) {
		e.printStackTrace();
	}
	catch(InterruptedException e) {
		e.printStackTrace();
	}
	}
	
	
}
