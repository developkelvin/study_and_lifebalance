package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class SearchProcess {
	private DBConnectionMgr pool;

	public SearchProcess(){
		try{
			pool = DBConnectionMgr.getInstance();
		}catch(Exception e){
			System.out.println("Error : DB Connect Failed");			
		}
	}
	
	public ResultSet getStudyList(int limit) {
		
		Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            con = pool.getConnection();
            con.prepareStatement("SET NAMES utf8mb4").executeQuery();
			String getStudyListQuery = "SELECT u.user_name, s.study_idx, s.study_name, s.study_desc FROM study AS s INNER JOIN study_member AS sm ON s.study_idx = sm.study_idx INNER JOIN user AS u ON sm.user_idx = u.user_idx LIMIT ?";
            pstmt = con.prepareStatement(getStudyListQuery);
            pstmt.setInt(1, limit);
            
            rs = pstmt.executeQuery();
            
            
        }catch(Exception ex) {
            System.out.println("Exception" + ex);
        }finally{
             pool.freeConnection(con);
        }
		
		return rs;
		
	}
	
	public ResultSet getStudyMemberList(int studyIdx) {

		Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            con = pool.getConnection();
            con.prepareStatement("SET NAMES utf8mb4").executeQuery();
			String getStudyMemberQuery = "SELECT u.user_name, u.user_contact, sm.is_master FROM study_member AS sm INNER JOIN user AS u on sm.user_idx = u.user_idx WHERE sm.study_idx = ?";
            pstmt = con.prepareStatement(getStudyMemberQuery);
            pstmt.setInt(1, studyIdx);
            
            rs = pstmt.executeQuery();
            
            
        }catch(Exception ex) {
            System.out.println("Exception" + ex);
        }finally{
             pool.freeConnection(con);
        }
		
		return rs;
	}
	
	public ResultSet getStudyDetail(int studyIdx) {
		Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            con = pool.getConnection();
            con.prepareStatement("SET NAMES utf8mb4").executeQuery();
			String getStudyDetailQuery = "SELECT study_name, study_desc FROM study WHERE study_idx = ?";
            pstmt = con.prepareStatement(getStudyDetailQuery);
            pstmt.setInt(1, studyIdx);
            
            rs = pstmt.executeQuery();
            
            
        }catch(Exception ex) {
            System.out.println("Exception" + ex);
        }finally{
             pool.freeConnection(con);
        }
		
		return rs;
	}
	
	
}
