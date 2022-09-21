package domain;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserDTO {
    private int id;
    private String username;
    @JsonIgnore
    private String password;
    private String name;
    @JsonIgnore
    private String authorities;
    @JsonIgnore
    private LocalDateTime regDate;
    private int viewCnt;
    
    private String provider;
   
    @JsonIgnore
    // String 으로 리턴하는 getter
    public String getRegDateTime() {
        if (this.regDate == null) return "";
        return this.regDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss"));
    }

} // end DTO


