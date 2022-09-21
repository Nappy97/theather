package service.srv;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import domain.ServiceDAO;
import domain.ServiceDTO;
import service.Service;
import sqlmapper.SqlSessionManager;

public class UpdateService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 입력한 값 (parameter) 받아오기
		int id = Integer.parseInt(request.getParameter("id"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		// ※ 이 단계에서 parameter 검증 해야 한다.
		
		SqlSession sqlSession = null;
		ServiceDAO dao = null;		
		
		int cnt = 0;

//		WriteDTO dto = new WriteDTO();
//		dto.setId(id);
//		dto.setSubject(subject);
//		dto.setContent(content);

		// Builder 사용한 생성  Property가 많을때사용
		ServiceDTO dto = ServiceDTO.builder()
			.id(id)
			.title(title)
			.content(content)
			.build()
			;
		
		try {
			sqlSession = SqlSessionManager.getInstance().openSession();
			dao = sqlSession.getMapper(ServiceDAO.class);
			
			cnt = dao.update(dto);
			
			sqlSession.commit();
		} catch (SQLException e) {  
			e.printStackTrace();
		} finally {
			if(sqlSession!= null) sqlSession.close();
		}
		
		request.setAttribute("result", cnt);
		request.setAttribute("dto", dto);	// id 값을 전달하기 위해


	}

}
