package domain;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class QryMyServiceResult {
	int count;	// 결과값(정수)
	String status;	// 결과메세지
	
	@JsonIgnore
	String memo;
	
}
