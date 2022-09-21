package service.mcomment;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import com.fasterxml.jackson.databind.ObjectMapper;

import domain.MCommentDAO;
import domain.QryMResult;
import service.Service;
import sqlmapper.SqlSessionManager;

public class CmtDeleteService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		
		QryMResult obj = new QryMResult(); // response할 java 객체
		ObjectMapper mapper = new ObjectMapper(); // JSON 매핑할 Mapper 객체
		
	    SqlSession sqlSession = null;
	    MCommentDAO dao = null;      
	    int cnt = 0;
	   
	    try {
	        sqlSession = SqlSessionManager.getInstance().openSession();
	        dao = sqlSession.getMapper(MCommentDAO.class);          
	       
	        cnt = dao.deleteById(id);
	        obj.setCount(cnt);
	        obj.setStatus("OK");

	        sqlSession.commit();
	    } catch (SQLException e) {
			e.printStackTrace();
			//예외에 대한 처리 
			obj.setStatus("댓글 작성 ERROR: " + e.getMessage());
		} finally {
			if(sqlSession!= null) sqlSession.close();
		}
	    //java 객체를 json문자열로 바꿈
	    String output = mapper.writeValueAsString(obj); 
	    response.setContentType("application/json; charset=utf-8");
	    response.getWriter().write(output);
	}
}
