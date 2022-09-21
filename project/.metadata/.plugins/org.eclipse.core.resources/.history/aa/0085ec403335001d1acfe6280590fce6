package domain;

import java.sql.SQLException;
import java.util.List;

public interface ServiceDAO {

    // 새글 작성 <-- DTO
    public abstract int insert(ServiceDTO dto) throws SQLException;

    // 특정 id 글 읽어오기 (SELECT)
    public abstract List<ServiceDTO> selectById(int id) throws SQLException;

    // 특정 id 글 조회수 증가 (UPDATE)
    public abstract int incViewCnt(int id) throws SQLException;

    // 전체 SELECT
    public abstract List<ServiceDTO> select() throws SQLException;


    // 특정 id 글 수정 (제목, 내용)
    public abstract int update(ServiceDTO dto) throws SQLException;

    // 특정 id 글 삭제
    public abstract int deleteById(int id) throws SQLException;

    // 페이징
    // 몇번째(from) 부터 몇개(rows) 를 SELECT
    public List<ServiceDTO> selectFromRow(int from, int rows) throws SQLException;

    // 전체 글의 개수
    public int countAll() throws SQLException;

    // scomment id check
    public int[] checkCmt(int id) throws SQLException;

    List<ServiceDTO> myService(int user_id) throws SQLException;
    
    

}
