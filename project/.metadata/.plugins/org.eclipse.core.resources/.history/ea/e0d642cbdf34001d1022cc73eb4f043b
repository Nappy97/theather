package service.user;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import common.C;
import domain.ReservDAO;
import domain.ReservDTO;
import domain.UserDAO;
import domain.UserDTO;
import service.Service;
import sqlmapper.SqlSessionManager;

public class ReserveDeleteService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		UserDTO user = (UserDTO)request.getSession().getAttribute(C.PRINCIPAL);
		int id = user.getId();
		SqlSession sqlSession = null;
		ReservDAO dao = null;
		
		int cnt = 0;
		
		try {
			sqlSession = SqlSessionManager.getInstance().openSession();
			dao = sqlSession.getMapper(ReservDAO.class);

			
			int uid = dao.selectByUserId(id);
			
			
			UserDTO loggedUser = (UserDTO)request.getSession().getAttribute(C.PRINCIPAL); // 현재로그인한 사용자 정보가 담겨있따
			int reservedUser = uid;		// 읽어온 글의 작성자
			if(loggedUser.getId() != reservedUser) {
				response.sendRedirect(request.getContextPath() + "/user/rejectAuth");
				return;
			}
			
			cnt = dao.delete(id);
			

			sqlSession.commit();
		} catch (SQLException e) {  
			e.printStackTrace();
		} finally {
			if(sqlSession!= null) sqlSession.close();
		}
 
		request.setAttribute("result", cnt);


	}



	}

