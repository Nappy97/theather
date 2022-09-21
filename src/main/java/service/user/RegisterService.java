package service.user;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import common.C;
import domain.UserDAO;
import domain.UserDTO;
import service.Service;
import sqlmapper.SqlSessionManager;

public class RegisterService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //입력한 값을 받아오기
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String re_password = request.getParameter("re_password");
        String name = request.getParameter("name");
        
		username = username.trim();
		password = password.trim();
		re_password = re_password.trim();
		name = name.trim();
        
		String conPath = request.getContextPath();
		// password와 re-password는 같아야 한다
		if (!password.equals(re_password)) {			
			// redirect 에 전달할 값들
			C.addRedirectAttribute(request, "error", "비밀번호와 비밀번호확인 입력값은 같아야 합니다");
			C.addRedirectAttribute(request, "username", username);
			C.addRedirectAttribute(request, "name", name);
			
			response.sendRedirect(conPath + "/user/register");
			return;
		}

		SqlSession sqlSession = null;
		UserDAO dao = null;
		
		int cnt = 0;
		UserDTO dto = UserDTO.builder()
				.name(name)
				.username(username.toUpperCase()) //대문자로 저장
				.password(password)
				.build();
		
		try {
			sqlSession = SqlSessionManager.getInstance().openSession();
			dao = sqlSession.getMapper(UserDAO.class);
			
			// 이미 존재하는 아이디(username)인 경우
			List<UserDTO> list = dao.selectByUsername(dto);
			if (list.size() > 0) {
		        C.addRedirectAttribute(request, "error", "이미 존재하는 아이디(username) 입니다");
		        C.addRedirectAttribute(request, "username", username);
		        C.addRedirectAttribute(request, "name", name);
		        response.sendRedirect(conPath + "/user/register");
		        return;  // 종료
		    }
			
			// 새로운 회원 등록
			cnt = dao.register(dto);
						
			sqlSession.commit();
		} catch (SQLException e) {  
			e.printStackTrace();
		} finally {
			if(sqlSession!= null) sqlSession.close();
		}
		request.setAttribute("result", cnt);
		request.setAttribute("dto", dto); 
		// ↑ auto-generated key(id)도 담겨 있음


	}

}