package service.movie;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import common.C;
import domain.MovieDAO;
import domain.MovieDTO;
import domain.ReservDAO;
import domain.ReservDTO;
import domain.UserDTO;
import service.Service;
import sqlmapper.SqlSessionManager;

public class ReservOKService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int id = Integer.parseInt(request.getParameter("id"));
		String[] seats = request.getParameterValues("seats");
		// *이 단계에서 parameter 검증해야 한다
		
		UserDTO user = (UserDTO)request.getSession().getAttribute(C.PRINCIPAL);
		
		int cnt = 0;			// insert된 예매좌석개수 카운트
		
		
		SqlSession sqlSession = null;
		ReservDAO dao = null;
		MovieDAO mdao = null;
		MovieDTO movie = null;
		
		try {
			sqlSession = SqlSessionManager.getInstance().openSession();
			dao = sqlSession.getMapper(ReservDAO.class);
			
			mdao = sqlSession.getMapper(MovieDAO.class);
			movie = (MovieDTO)mdao.selectByIdForSeat(id);
			
			for (String i : seats) {
				ReservDTO dto = new ReservDTO();
				dto.setUser(user);
				dto.setMovie(movie);
				dto.setSeat(i);
				cnt = dao.insert(dto);
			}
			sqlSession.commit();
		} catch (SQLException e) {  
			e.printStackTrace();
		} finally {
			if(sqlSession!= null) sqlSession.close();
		}
		request.setAttribute("result", cnt);
		request.setAttribute("dto", movie);
	}
}
