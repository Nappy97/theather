package service.movie;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import domain.FileDAO;
import domain.FileDTO;
import domain.MovieDAO;
import domain.MovieDTO;
import service.Service;
import sqlmapper.SqlSessionManager;

public class DetailService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int id = Integer.parseInt(request.getParameter("id"));
		// *이 단계에서 parameter 검증해야 한다
		
		SqlSession sqlSession = null;
		MovieDAO dao = null;	
		FileDAO fileDao = null;
		
		List<MovieDTO> list = null;
		
		try {
			sqlSession = SqlSessionManager.getInstance().openSession();
			dao = sqlSession.getMapper(MovieDAO.class);
			fileDao = sqlSession.getMapper(FileDAO.class);
			
			// 글 읽기
			list = dao.selectById(id);
			for(MovieDTO m : list) {
				m.setStar(
					getMean(dao.selectStars(id))
				);
			}

			//특정 글 1개(id)에 대한 첨부파일 목록 가져오기
			if(list != null && list.size() == 1) {
				List<FileDTO> fileList = fileDao.selectByMovieId(id);
				
				//이미지 파일 여부 세팅
				String realPath = request.getServletContext().getRealPath("upload");
				
				for(FileDTO fileDto : fileList) {
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
				
				request.setAttribute("fileList", fileList);
				
			}

			request.setAttribute("list", list);
			
			sqlSession.commit();
		} catch (SQLException e) {  
			e.printStackTrace();
		} finally {
			if(sqlSession!= null) sqlSession.close();
		}
	}
	public float getMean(int[] list) {
		int sum = 0;
		int len = list.length;
		
		for (int i : list) sum += i;
		
		return (int)(((float)sum / len) * 10) / (float)10;
	}

}
