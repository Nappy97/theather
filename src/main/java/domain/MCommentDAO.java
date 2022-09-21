package domain;

import java.sql.SQLException;
import java.util.List;

public interface MCommentDAO {
	// 특정 글 (write_id)의 댓글 목록 읽기
	List<MCommentDTO> selectByMovie(int movie_id, int start) throws SQLException;
	
	// 댓글 작성 <-- 매개변수는 DTO에 담음
	public int insert(MCommentDTO dto) throws SQLException;
	
	// 댓글(id) 삭제
	public int deleteById(int id) throws SQLException;
}
