package top.jybill.model;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Classroom {
  private long id;
  private Timestamp createDate;
  private Timestamp updateDate;
  private String name;
  private String description;
  private long status;
  private long courseId;
}
