package domain;

import java.sql.SQLException;
import java.util.List;

public interface MovieDAO {
	// 영화 리스트 뽑기
	public abstract List<MovieDTO> select() throws SQLException;
	
	// 영화 id로 해당 영화의 별점 가져오기
	public abstract int[] selectStars(int id) throws SQLException;
	
	// id로 특정 영화(movie) SELECT <-- DTO
	List<MovieDTO> selectById(int id) throws SQLException;
	
	// id로 특정 영화(movie) SELECT <-- DTO
	MovieDTO selectByIdForSeat(int id) throws SQLException;
	
	// 영화(user) 등록 <-- DTO
	int register(MovieDTO dto) throws SQLException;
	
	//특정 id영화 삭제
	public abstract int deleteById(int id) throws SQLException;
	
	//특정 id글 수정 (제목, 내용)
	public abstract int update(MovieDTO dto) throws SQLException;
	

	
}
