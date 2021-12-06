package top.jybill.model;


import apijson.orm.Visitor;
import com.alibaba.fastjson.annotation.JSONField;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
import java.util.Collections;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User implements Visitor<Long> {

  private Long id;
  private Timestamp createDate;
  private Timestamp updateDate;
  private String account;
  private String nikename;
  private String courseId;
  private int role; // 0: 用户   1: 教师  2: 管理员

  public User setId(Long id) {
    this.id = id;
    return this;
  }


  public Long getId() {
    return id;
  }

  // 朋友列表
  @JSONField(serialize = false)
  @Override
  public List<Long> getContactIdList() {
    return Collections.emptyList();
  }

  public User setCreateDate(Timestamp createDate) {
    this.createDate = createDate;
    return this;
  }

  public User setUpdateDate(Timestamp updateDate) {
    this.updateDate = updateDate;
    return this;
  }

  public User setAccount(String account) {
    this.account = account;
    return this;
  }

  public User setNikename(String nikename) {
    this.nikename = nikename;
    return this;
  }

  public User setCourseId(String courseId) {
    this.courseId = courseId;
    return this;
  }

  public User setRole(int role) {
    this.role = role;
    return this;
  }
}
