package service.user;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import domain.FileDAO;
import domain.FileDTO;
import domain.MovieDAO;
import domain.MovieDTO;
import domain.ReservDAO;
import domain.ReservDTO;
import domain.UserDAO;
import domain.UserDTO;
import service.Service;
import sqlmapper.SqlSessionManager;

public class ReserveDetailService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		
		SqlSession sqlSession = null;
		ReservDAO rdao = null;
		MovieDAO mdao = null;	
		FileDAO fileDao = null;
		UserDAO userDao = null;
		
		List<ReservDTO> list = null;
		List<MovieDTO> movielist = null;
		List<UserDTO> userlist = null;
		
		
		try {
			sqlSession = SqlSessionManager.getInstance().openSession();
			rdao = sqlSession.getMapper(ReservDAO.class);
			mdao = sqlSession.getMapper(MovieDAO.class);
			fileDao = sqlSession.getMapper(FileDAO.class);
			userDao = sqlSession.getMapper(UserDAO.class);
			
			list = rdao.selectById(id);
			int mid = rdao.selectByMovieId(id);
			int uid = rdao.selectByUserId(id);
			
			movielist = mdao.selectById(mid);
			userlist = userDao.selectById(uid);
			
			
			if(movielist != null && movielist.size() == 1) {
				List<FileDTO> filelist = fileDao.selectByMovieId(mid);
				
				//이미지 파일 여부 세팅
				String realPath = request.getServletContext().getRealPath("upload");
				
				for(FileDTO fileDto : filelist) {
					//첨부파일에 대한 File 객체
					File f = new File(realPath, fileDto.getFile());
					BufferedImage imgData = null;
					
					try {
						imgData = ImageIO.read(f);
                        // 파일이 존재 하지 않으면 IOExcepion
                        // 이미지가 아닌 경우는 return null
					} catch (IOException e) {
						System.out.println("이미지 없음: " + f.getAbsolutePath() + " [" + e.getMessage() + "]");
					}
					
					if (imgData != null) fileDto.setImage(true); //이미지 여부 true
				}
				
				request.setAttribute("filelist", filelist);
			}
			
			request.setAttribute("list", list);
			request.setAttribute("movielist", movielist);
			request.setAttribute("userlist", userlist);
			
			sqlSession.commit();
		}catch (SQLException e) {  
			e.printStackTrace();
		} finally {
			if(sqlSession!= null) sqlSession.close();
		}		


	}


	}
