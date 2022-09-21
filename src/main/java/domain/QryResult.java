package domain;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class QryResult {
	int count;	// 결과값(정수)
	String status;	// 결과메세지
	String memo;
	
}
