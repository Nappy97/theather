package service.movie;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.imageio.ImageIO;
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

public class ListService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		SqlSession sqlSession = null;
		MovieDAO dao = null;		
		List<MovieDTO> list = null;
		FileDAO fileDao = null;
		
		try {
			sqlSession = SqlSessionManager.getInstance().openSession();
			dao = sqlSession.getMapper(MovieDAO.class);
			fileDao = sqlSession.getMapper(FileDAO.class);
			
			list = dao.select();			
			for(MovieDTO m : list) {
				//평균 평점 설정
				m.setStar(
					getMean(dao.selectStars(m.getId()))
				);
				
				//특정 글 1개(id)에 대한 첨부파일 목록 가져오기
				List<FileDTO> fileList = fileDao.selectByMovieId(m.getId());
				
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
					
					if (imgData != null) {
						fileDto.setImage(true);
						m.setFileName(fileDto.getFile());
					} //이미지 여부 true
				}
			}

			sqlSession.commit();
		} catch (SQLException e) {  
			e.printStackTrace();
		} finally {
			if(sqlSession!= null) sqlSession.close();
		}
		request.setAttribute("dtolist", list);
	}
	public float getMean(int[] list) {
		int sum = 0;
		int len = list.length;
		
		for (int i : list) sum += i;
		
		return (int)(((float)sum / len) * 10) / (float)10;
	}
}
