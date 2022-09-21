package service.movie;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import domain.MovieDAO;
import domain.MovieDTO;
import domain.ReservDAO;
import domain.ReservDTO;
import service.Service;
import sqlmapper.SqlSessionManager;

public class ReservService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int id = Integer.parseInt(request.getParameter("id"));
		// *이 단계에서 parameter 검증해야 한다
		
		SqlSession sqlSession = null;
		ReservDAO dao = null;
		MovieDAO mdao = null;
		int len = 0;
		
		List<String> list = null;
		List<MovieDTO> mov = null;
		
		try {
			sqlSession = SqlSessionManager.getInstance().openSession();
			dao = sqlSession.getMapper(ReservDAO.class);
			mdao = sqlSession.getMapper(MovieDAO.class);
			
			list = dao.seatCheck(id);
			mov = mdao.selectById(id);
			len = list.size();
			
			request.setAttribute("mov", mov);
			request.setAttribute("list", list);
			request.setAttribute("len", len);
			request.setAttribute("id", id);
			
			sqlSession.commit();
		} catch (SQLException e) {  
			e.printStackTrace();
		} finally {
			if(sqlSession!= null) sqlSession.close();
		}
	}
}
