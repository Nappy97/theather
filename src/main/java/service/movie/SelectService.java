package service.movie;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import common.C;
import domain.FileDAO;
import domain.FileDTO;
import domain.MovieDAO;
import domain.MovieDTO;
import domain.UserDTO;
import service.Service;
import sqlmapper.SqlSessionManager;

public class SelectService implements Service {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException{
		int id = Integer.parseInt(request.getParameter("id"));
		// *이 단계에서 parameter 검증해야 한다

		SqlSession sqlSession = null;
		MovieDAO dao = null;	
		FileDAO fileDao = null;
		
		List<MovieDTO> list = null;
		List<FileDTO> fileList = null;
		
		try {
			sqlSession = SqlSessionManager.getInstance().openSession();
			dao = sqlSession.getMapper(MovieDAO.class);
			fileDao = sqlSession.getMapper(FileDAO.class);
			
			//읽기 only
			list = dao.selectById(id);
			fileList = fileDao.selectByMovieId(id);
			
			for (MovieDTO i : list) {
				for (FileDTO j : fileList) {
					i.setFileName(j.getFile());
				}
			}
			
			
			// admin 아니면 여기서 redirect해야 한다
			UserDTO loggedUser = (UserDTO)request.getSession().getAttribute(C.PRINCIPAL);
			if(!loggedUser.getAuthorities().contains("ROLE_ADMIN")) {
				response.sendRedirect(request.getContextPath() + "/user/rejectAuth");
				return;
			}
			
			request.setAttribute("list", list);
			request.setAttribute("fileList", fileList);
			
			sqlSession.commit();
		} catch (SQLException e) {  
			e.printStackTrace();
		} finally {
			if(sqlSession!= null) sqlSession.close();
		}
	}
}
