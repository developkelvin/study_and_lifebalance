package db;

import java.sql.*;

public class StudyProcess {
	
	private DBConnectionMgr pool;

	public StudyProcess(){
		try{
			pool = DBConnectionMgr.getInstance();
		}catch(Exception e){
			System.out.println("Error : DB Connect Failed");			
		}
	}
	
	public boolean createStudy(String title, String desc, String userId) {
		
		Connection con = null;
        PreparedStatement pstmt = null;
        int isInsertStudyOK = 0;
        int isInsertMasterOK = 0;
        boolean createStudyResult = false;
//        boolean insertStudyResult = false;
//        boolean masterSettingResult = false;
        try {
            con = pool.getConnection();
            con.prepareStatement("SET NAMES utf8mb4").executeQuery();
			String query = "insert into study(study_name, study_desc) values (?, ?)";
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, title);
            pstmt.setString(2, desc);
            isInsertStudyOK = pstmt.executeUpdate();
            pstmt.close();
            String masterInsertQuery = "insert into study_member(user_idx, study_idx, is_master) "
            		+ "values ("
            		+ "(select user_idx from user where user_id = ?),"
            		+ "(select max(study_idx) from study),"
            		+ "1)";
            pstmt = con.prepareStatement(masterInsertQuery);
            pstmt.setString(1, userId);
            isInsertMasterOK = pstmt.executeUpdate();
            
            if(isInsertMasterOK == 1 && isInsertStudyOK == 1) {
            	createStudyResult = true;
            }
            
        }catch(Exception ex) {
            System.out.println("Exception" + ex);
        }finally{
             pool.freeConnection(con);
        }
        return createStudyResult;
		
	}

}