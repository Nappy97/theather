package domain;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface FileDAO {
	public int insert(int movie_id, String fileName) throws SQLException;

	// 특정 첨부파일 (영화 id로) 한개 SELECT
	public List<FileDTO> selectByMovieId(int movie_id) throws SQLException;
	
	// 특정 첨부파일 (id로) 한개 SELECT
	public List<FileDTO> selectById(int movie_id) throws SQLException;

	// 선택한 첨부파일 delete
	// 글 수정에서 사용
	public int update (FileDTO dto) throws SQLException;
	
	//id로 삭제
	public int deleteById (int id) throws SQLException;
}
