import java.sql.Connection;
import java.sql.DriverManager;

public class graphJava {

	public static void main(String[] args) {
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String jdbcURL = "jdbc:mysql://localhost:3306/gonggongdb";
			String jdbcID = "gguser";
			String jdbcPW = "ggpass";
			
			Connection conn = DriverManager.getConnection(jdbcURL, jdbcID, jdbcPW);
			System.out.println("db connection ok!");
		}
		catch(Exception e) {
			e.printStackTrace();
			System.out.println("DB Driver Error!");
		} 
		
		String s = "select num from humanityinfo";
		
		System.out.println(s);
		
	}

}
