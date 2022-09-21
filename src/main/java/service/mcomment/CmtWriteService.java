package service.mcomment;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import com.fasterxml.jackson.databind.ObjectMapper;

import domain.MCommentDAO;
import domain.MCommentDTO;
import domain.MovieDTO;
import domain.QryMResult;
import domain.UserDTO;
import service.Service;
import sqlmapper.SqlSessionManager;

public class CmtWriteService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
	    // parameter 받아오기
	    int movieId = Integer.parseInt(request.getParameter("movie_id"));  // 어느글에 대한 댓글인지
	    int userId = Integer.parseInt(request.getParameter("user_id"));  // 누가 작성한 댓글인지
	    String content = request.getParameter("content");  // 댓글 내용
	    int star = Integer.parseInt(request.getParameter("star")); // 평점
	    
	    MovieDTO movie = new MovieDTO();
	    movie.setId(movieId);
	    UserDTO user = new UserDTO();
	    user.setId(userId);
	    
	    MCommentDTO dto = MCommentDTO.builder()
	    	.movie(movie)
	    	.user(user)
	    	.content(content)
	    	.star(star)
	    	.build();
	    
	    QryMResult obj = new QryMResult();// response 할 Java 객체
	    ObjectMapper mapper = new ObjectMapper();  // Json 매핑할 Mapper객체

	    SqlSession sqlSession = null;
	    MCommentDAO dao = null;
	    int cnt = 0;
	   
	    try {
	        sqlSession = SqlSessionManager.getInstance().openSession();
	        dao = sqlSession.getMapper(MCommentDAO.class);          
	       
	        System.out.println("나나나나나나나나나나나나나나");
	        cnt = dao.insert(dto);
	        obj.setCount(cnt);
	        obj.setStatus("OK");
	        
	        sqlSession.commit();
	    } catch (SQLException e) {
	        e.printStackTrace();
	        //예외에 대한 처리
	        obj.setStatus("댓글 작성 ERROR : " + e.getMessage());
	    } finally {
	        if(sqlSession!= null) sqlSession.close();
	    }
	   
	    String output = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(obj);  // 포맷팅 ○          
	    response.setContentType("application/json; charset=utf-8");  // MIME 설정
	    response.getWriter().write(output);  // response에 보내기!   IOException


	}

}
