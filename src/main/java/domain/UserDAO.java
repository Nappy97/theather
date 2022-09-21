package domain;

import java.sql.SQLException;
import java.util.List;

public interface UserDAO {
	// 특정 user SELECT <-- DTO
	// 회원가입등에서 필요. (중복가입 여부 등)
	List<UserDTO> selectByUsername(UserDTO dto) throws SQLException;
	
	// id로 특정 회원(user) SELECT <-- DTO
	public abstract List<UserDTO> selectById(int id) throws SQLException;
	
	// 회원(user) 등록 <-- DTO
	int register(UserDTO dto) throws SQLException;
	
	int modify(UserDTO dto) throws SQLException;
	
	public abstract int myViewcnt(int id) throws SQLException;


}
