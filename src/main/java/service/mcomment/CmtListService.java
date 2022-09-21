package service.mcomment;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

import domain.MCommentDAO;
import domain.MCommentDTO;
import domain.QryMCommentList;
import service.Service;
import sqlmapper.SqlSessionManager;

public class CmtListService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		int id = Integer.parseInt(request.getParameter("id")); // 글의 id
		int start = Integer.parseInt(request.getParameter("start")); // 글의 id
		
		QryMCommentList obj = new QryMCommentList();// response할 Java 객체
		ObjectMapper mapper = new ObjectMapper(); // Json으로 매핑할 Mapper 객체
		
		SqlSession sqlSession = null;
		MCommentDAO dao = null;		
		
		try {
			sqlSession = SqlSessionManager.getInstance().openSession();
			dao = sqlSession.getMapper(MCommentDAO.class);
			
			List<MCommentDTO> list = dao.selectByMovie(id, start * 5);
			obj.setList(list);
			obj.setCount(list.size());
			obj.setStatus("OK");
			
			sqlSession.commit();
		} catch (SQLException e) {  
			e.printStackTrace();
			obj.setStatus("댓글목록 ERROR : " + e.getMessage());
		} finally {
			if(sqlSession!= null) sqlSession.close();
		}



		
		//String output = mapper.writeValueAsString(obj); // formatting x
		//String output = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(obj); //formatting o
		String output = mapper.registerModule(new JavaTimeModule()).writeValueAsString(obj); //formatting o
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().write(output); //response 에 내보내기
	}
}
