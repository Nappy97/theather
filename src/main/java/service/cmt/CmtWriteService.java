package service.cmt;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import com.fasterxml.jackson.databind.ObjectMapper;

import domain.QryResult;
import domain.SCommentDAO;
import domain.SCommentDTO;
import domain.ServiceDTO;
import domain.UserDTO;
import service.Service;
import sqlmapper.SqlSessionManager;

public class CmtWriteService implements Service{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		 // parameter 받아오기
	    int servId = Integer.parseInt(request.getParameter("serv_id"));  // 어느글에 대한 댓글인지
	    int userId = Integer.parseInt(request.getParameter("user_id"));  // 누가 작성한 댓글인지
	    String content = request.getParameter("content");  // 댓글 내용
	    
	    ServiceDTO serv = new ServiceDTO();
	    serv.setId(servId);
	    UserDTO user = new UserDTO();
	    user.setId(userId);

	    SCommentDTO dto = SCommentDTO.builder()
	    		.serv(serv)
	    		.user(user)
	    		.content(content)
	    		.build();
	    
	    QryResult obj = new QryResult();// response 할 Java 객체
	    ObjectMapper mapper = new ObjectMapper();  // Json 매핑할 Mapper객체
	    
	    SqlSession sqlSession = null;
	    SCommentDAO dao = null;
	    int cnt = 0;
	   
	    try {
	        sqlSession = SqlSessionManager.getInstance().openSession();
	        dao = sqlSession.getMapper(SCommentDAO.class);          
	       
	        cnt = dao.insert(dto);
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
	   
	    String output = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(obj);  // 포맷팅 ○          
	    response.setContentType("application/json; charset=utf-8");  // MIME 설정
	    response.getWriter().write(output);  // response에 보내기!   IOException

		
	}

}
