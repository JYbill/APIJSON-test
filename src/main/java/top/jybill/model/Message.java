package top.jybill.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Message {

  private long id;
  private Timestamp createDate;
  private Timestamp updateDate;
  private String title;
  private String description;
  private String courseId;

}
