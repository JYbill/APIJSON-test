package top.jybill.test;

import apijson.JSONObject;
import apijson.JSONResponse;
import top.jybill.model.User;

import java.util.Map;

/**
 * @PackageName: top.jybill.test
 * @ClassName: Test
 * @Description: 无
 * @Author: 小钦var
 * @Date: 2021/12/3 12:01
 */
public class Test {
  public static void main(String[] args) {
    System.out.println(new JSONObject("{\"account\": \"123456\"}"));

    User user = new User();
    user.setId(1L);
    user.setAccount("123456");
    com.alibaba.fastjson.JSONObject jsonObject =
            new JSONObject("").puts("User", user);
    System.out.println(jsonObject);

    Map user1 = new JSONResponse(jsonObject).getObject(Map.class);
    System.out.println("user1 = " + user1);
  }
}
