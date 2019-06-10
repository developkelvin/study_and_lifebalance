package db;

import java.sql.*;

public class LoginProcess{
	
	private DBConnectionMgr pool;

	public LoginProcess(){
		try{
			pool = DBConnectionMgr.getInstance();
		}catch(Exception e){
			System.out.println("Error : DB Connect Failed");			
		}
	}
	/**
	 * 회원 가입하는 메소드
	 * @param id
	 * @param pwd
	 * @param contact
	 * @param name
	 * @return 회원 가입 성공 여부
	 */
	public boolean SignIn(String id, String pwd, String contact, String name) {
		
		Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean signInResult = false;
        try {
            con = pool.getConnection();
			String query = "insert into user(user_id, user_pwd, user_contact, user_name) values (?, ?, ?, ?)";
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, id);
            pstmt.setString(2, pwd);
            pstmt.setString(3, contact);
            pstmt.setString(4, name);
            rs = pstmt.executeQuery();
            if(rs.next()&&rs.getInt(1)>0) 
            	signInResult =true;
        }catch(Exception ex) {
            System.out.println("Exception" + ex);
        }finally{
             pool.freeConnection(con,pstmt,rs);
        }
        return signInResult;
	}

	/**
	 * 로그인 성공 여부를 확인하는 메소드
	 * @param id
	 * @param pwd
	 * @return 로그인 성공 여부
	 */
	public boolean login(String id, String pwd) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean loginResult = false;
        try {
            con = pool.getConnection();
			String query = "select count(*) from user where user_id = ? and user_pwd = ?";
			System.out.println("id:"+id);
			System.out.println("pwd:"+pwd);
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, id);
            pstmt.setString(2, pwd);
            rs = pstmt.executeQuery();
            if(rs.next()&&rs.getInt(1)>0) 
            	loginResult =true;
        }catch(Exception ex) {
            System.out.println("Exception" + ex);
        }finally{
             pool.freeConnection(con,pstmt,rs);
        }
        return loginResult;
    }
	
	

}

