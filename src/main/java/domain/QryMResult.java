package domain;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class QryMResult {
	int count; // 결과값 (정수)
	String status; // 결과 메시지
	
	@JsonIgnore //해당 필드는 json 변환 안됨
	String memo;
}
