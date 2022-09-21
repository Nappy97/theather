package domain;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MovieDTO {
    private int id;
    private String title;
    private String genre;
    private int runtime;
    private String director;
    private String actor;
    private String synopsis;
    private LocalDateTime regDate;
    
    private float star;

    private String fileName;
   
    // String 으로 리턴하는 getter
    public String getRegDateTime() {
        if(this.regDate == null) return "";
        return this.regDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss"));    
    }  

} // end DTO


