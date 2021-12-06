package top.jybill.model;

import apijson.framework.BaseModel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class Course extends BaseModel {

  private Timestamp createDate;
  private Timestamp updateDate;
  private String name;
  private String description;
  private Timestamp startDate;
  private Timestamp endDate;
  private long classroomId;

  public Course setCreateDate(Timestamp createDate) {
    this.createDate = createDate;
    return this;
  }

  public Course setUpdateDate(Timestamp updateDate) {
    this.updateDate = updateDate;
    return this;
  }

  public Course setName(String name) {
    this.name = name;
    return this;
  }

  public Course setDescription(String description) {
    this.description = description;
    return this;
  }

  public Course setStartDate(Timestamp startDate) {
    this.startDate = startDate;
    return this;
  }

  public Course setEndDate(Timestamp endDate) {
    this.endDate = endDate;
    return this;
  }

  public Course setClassroomId(long classroomId) {
    this.classroomId = classroomId;
    return this;
  }
}
