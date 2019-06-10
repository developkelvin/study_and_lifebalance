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
	
	/**
	 * 전체 스터디 목록을 limit 수 만큼 가져오는 메소드
	 * @param limit
	 * @return 스터디 목록
	 */
	public ResultSet getStudyList(int limit) {
		
		Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            con = pool.getConnection();
            con.prepareStatement("SET NAMES utf8mb4").executeQuery();
			String getStudyListQuery = "SELECT u.user_name, s.study_idx, s.study_name, s.study_desc FROM study AS s INNER JOIN study_member AS sm ON s.study_idx = sm.study_idx INNER JOIN user AS u ON sm.user_idx = u.user_idx WHERE sm.is_master = 1 LIMIT ?";
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
	/**
	 * 스터디에 가입한 회원 리스트를 가져오는 메소드
	 * @param studyIdx
	 * @return 스터디 멤버들의 이름, 연락처, 개설자 여부
	 */
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
	
	/**
	 * 스터디에 대한 자세한 정보(이름, 설명)를 가져오는 함수.
	 * @param studyIdx
	 * @return 스터디 이름과 설명
	 */
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
	
	/**
	 * 스터디에 가입되어있는지 여부를 확인하는 메소드
	 * @param userId
	 * @param studyIdx
	 * @return 스터디 가입 여부
	 */
	public boolean checkJoinStudy(String userId, int studyIdx) {
		Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean isStudyJoined = false;
        try {
            con = pool.getConnection();
			String query = "SELECT count(*) FROM study_member WHERE study_idx = ? AND user_idx = (SELECT user_idx FROM user WHERE user_id = ?)";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, studyIdx);
            pstmt.setString(2, userId);
            rs = pstmt.executeQuery();
            if(rs.next()&&rs.getInt(1)>0) 
            	isStudyJoined =true;
        }catch(Exception ex) {
            System.out.println("Exception" + ex);
        }finally{
             pool.freeConnection(con,pstmt,rs);
        }
        return isStudyJoined;
	}
	
	/**
	 * 스터디 가입 여부 반환
	 * @param userId
	 * @param studyIdx
	 * @return 스터디 정상 가입 여부
	 */
	public boolean joinStudy(String userId, int studyIdx) {
		Connection con = null;
        PreparedStatement pstmt = null;
        int insertResult = 0;
        boolean joinResult = false;
        try {
            con = pool.getConnection();
			String query = "insert into study_member(user_idx, study_idx, is_master) values ((SELECT user_idx FROM user WHERE user_id = ?), ?, 0)";
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, userId);
            pstmt.setInt(2, studyIdx);
            insertResult = pstmt.executeUpdate();
            if(insertResult > 0) 
            	joinResult =true;
        }catch(Exception ex) {
            System.out.println("Exception" + ex);
        }finally{
             pool.freeConnection(con,pstmt);
        }
        return joinResult;
	}
	
	
	
}
