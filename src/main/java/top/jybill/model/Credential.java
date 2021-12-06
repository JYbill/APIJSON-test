package top.jybill.model;

import apijson.framework.BaseModel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Credential extends BaseModel {

  private Timestamp createDate;
  private Timestamp updateDate;
  private String password;

  @Override
  public Credential setId(Long id) {
    super.setId(id);
    return this;
  }

  public Credential setCreateDate(Timestamp createDate) {
    this.createDate = createDate;
    return this;
  }

  public Credential setUpdateDate(Timestamp updateDate) {
    this.updateDate = updateDate;
    return this;
  }

  public Credential setPassword(String password) {
    this.password = password;
    return this;
  }
}
