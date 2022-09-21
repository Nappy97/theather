package service.cmt;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import com.fasterxml.jackson.databind.ObjectMapper;

import domain.QryCommentList;
import domain.SCommentDAO;
import domain.SCommentDTO;
import service.Service;
import sqlmapper.SqlSessionManager;

public class CmtListService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int id = Integer.parseInt(request.getParameter("id")); // 특정 글의 id

		QryCommentList obj = new QryCommentList(); // reponse 할 자바 객체
		ObjectMapper mapper = new ObjectMapper(); // Json 으로 매핑할 Mapper 객체

		SqlSession sqlSession = null;
		SCommentDAO dao = null;

		try {
			sqlSession = SqlSessionManager.getInstance().openSession();
			dao = sqlSession.getMapper(SCommentDAO.class);

			List<SCommentDTO> list = dao.selectByWrite(id);
			obj.setList(list);
			obj.setCount(list.size());
			obj.setStatus("OK");

			sqlSession.commit();
		} catch (SQLException e) {
			e.printStackTrace();
			obj.setStatus("댓글목록 ERROR: " + e.getMessage());
		} finally {
			if (sqlSession != null)
				sqlSession.close();
		}

//		String output = mapper.writeValueAsString(obj);  // 포매팅 x
		String output = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(obj); // 포매팅
//		System.out.println(output);
		response.setContentType("application/json; charset=utf-8"); // MIME 설정
		response.getWriter().write(output); // reponse에 보내기
	}

}
