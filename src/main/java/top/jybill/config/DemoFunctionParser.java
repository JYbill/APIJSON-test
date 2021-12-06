package top.jybill.config;


import apijson.*;
import apijson.framework.APIJSONConstant;
import apijson.framework.APIJSONFunctionParser;
import apijson.framework.APIJSONParser;
import apijson.orm.JSONRequest;
import apijson.orm.SQLExecutor;
import apijson.orm.exception.ConditionErrorException;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.TypeReference;
import com.alibaba.fastjson.serializer.SerializerFeature;
import org.springframework.format.annotation.DateTimeFormat;
import top.jybill.model.Classroom;
import top.jybill.model.Course;
import top.jybill.model.User;

import javax.servlet.http.HttpSession;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static apijson.RequestMethod.*;

public class DemoFunctionParser extends APIJSONFunctionParser {

  public DemoFunctionParser() {
    this(null, null, 0, null, null);
  }

  // 展示在远程函数内部可以用 this 拿到的东西
  public DemoFunctionParser(RequestMethod method, String tag, int version, com.alibaba.fastjson.JSONObject request, HttpSession session) {
    super(method, tag, version, request, session);
  }


  // 表
  public static final String CLASSROOM_NAME = Classroom.class.getSimpleName();
  public static final String COURSE_TABLE = "Course";
  public static final String USER_TABLE = "User";
  public static final String CLASSROOM_TABLE = "Classroom";
  public static final String CREDENTIAL_TABLE = "Credential";

  // 字段
  public static final String ID = "id";
  public static final String COURSE_ID = "courseId";
  public static final String CLASSROOM_ID = "classroomId";
  public static final String CLASSROOM_STATUS = "status";
  public static final String USER_ACCOUNT = "account";
  public static final String USER_NIKENAME = "nikename";
  public static final String ROLE_FILE = "role";
  public static final String CREDENTIAL_PASSWORD = "password";
  public static final String USERID = "userId";
  public static final String CREATE_DATE = "create_date";
  public static final String UPDATE_DATE = "update_date";

  // 默认值
  public static final byte CLASSROOM_STATUS_NOTNULL = 1;
  public static final byte CLASSROOM_STATUS_NULL = 0;
  public static final byte USER_ROLE = 0;

  // JSON字段
  public static final String COURSEID_ADD = "courseId+";


  /**
   * 课程关联教室
   * @param current
   * @param
   * @return
   * @throws Exception
   */
  public Object updateClassroom(@NotNull JSONObject current, @NotNull String id) throws Exception {
    Long preCheck = current.getObject(id, Long.class); // 课程id
    if (preCheck < 1) {
      return null;
    }

    // 预校验防止恶意篡改
    Long userId = ((Integer) this.getRequest().getObject(COURSE_TABLE, Map.class).
            get(apijson.JSONObject.KEY_USER_ID)).longValue();
    if (userId != ((User) this.getSession().getAttribute("User")).getId()) {
      throw new RuntimeException("请勿恶意篡改他人信息");
    }

    // 真实处理逻辑
    Object classroomIdVal = this.getRequest().getObject(COURSE_TABLE, Map.class).get(CLASSROOM_ID);
    Long classRoomIdLong = Long.parseLong(classroomIdVal.toString());


    // 校验教室是否已被占用
    Classroom classroom = new APIJSONParser(GET, false).parseResponse(
            new JSONRequest(CLASSROOM_NAME, new apijson.JSONObject("")
                    .puts("id", classRoomIdLong))).getObject(CLASSROOM_NAME, Classroom.class);
    if (classroom.getStatus() == 1) {
      throw new RuntimeException("该教室已被占用");
    }


    // UPDATE 教室
    new APIJSONParser(PUT, false).parseResponse(
            new JSONRequest(CLASSROOM_NAME, new apijson.JSONObject("")
                    .puts(COURSE_ID, preCheck)
                    .puts(ID, classRoomIdLong)
                    .puts(CLASSROOM_STATUS, CLASSROOM_STATUS_NOTNULL)));

    // UPDATE 教师
    new APIJSONParser(PUT, false).parseResponse(
            new JSONRequest(USER_TABLE, new apijson.JSONObject("")
                    .puts(ID, userId).puts(COURSEID_ADD, new Long[]{preCheck})));

    return null;
  }



  /**
   * 修改课程前清空教室状态
   * @param current
   * @param id 课程的id
   * @return
   * @throws Exception
   */
  public Object clearClassRoomBefore(@NotNull JSONObject current, @NotNull String id) throws Exception {
    Long courseId = current.getObject(id, Long.class); // 课程id

    // 绕过启动检测
    if (courseId == 0) {       return null;     }

    // 清空之前的classroom的状态
    Classroom classroom = new APIJSONParser(GET, false).parseResponse(
            new JSONRequest(CLASSROOM_NAME, new apijson.JSONObject("")
                    .puts(COURSE_ID, courseId))).getObject(CLASSROOM_TABLE, Classroom.class);


    return new APIJSONParser(PUT, false).parseResponse(
            new JSONRequest(CLASSROOM_NAME, new apijson.JSONObject("")
                    .puts(ID, classroom.getId()).puts(CLASSROOM_STATUS, CLASSROOM_STATUS_NULL)
                    .puts(COURSE_ID, 0)
            ));
  }



  /**
   * 修改课程后教室添加课程信息
   * @param current
   * @param id
   * @return
   * @throws Exception
   */
  public Object clearClassRoomAfter(@NotNull JSONObject current, @NotNull String id) throws Exception {
    Long courseId = current.getObject(id, Long.class); // 课程id

    // 绕过启动检测
    if (courseId == 0) {       return null;     }

    // 教室id
    Object request = this.getRequest().getObject(COURSE_TABLE, Map.class).
            get(CLASSROOM_ID);
    Long classroomId = null;
    // 类型转换
    if (request instanceof Integer) {
      classroomId = ((Integer) this.getRequest().getObject(COURSE_TABLE, Map.class).
              get(CLASSROOM_ID)).longValue();
    } else if (request instanceof Long) {
      classroomId = (Long) (this.getRequest().getObject(COURSE_TABLE, Map.class).
              get(CLASSROOM_ID));
    }

    // 修改该教室的状态及对应的课程信息
    return new APIJSONParser(PUT, false).parseResponse(
            new JSONRequest(CLASSROOM_NAME, new apijson.JSONObject("")
                    .puts(ID, classroomId).puts(CLASSROOM_STATUS, CLASSROOM_STATUS_NOTNULL)
                    .puts(COURSE_ID, courseId)
            ));
  }


  /**
   * 注册账号
   * @param current
   * @param
   * @return
   * @throws Exception
   */
  public Object registerFunc(@NotNull JSONObject current,
                             @NotNull String account,
                             @NotNull String nikename,
                             @NotNull String password) throws Exception {
    String accountVal = current.getObject(account, String.class); // 账号值
    String nikenameVal = current.getObject(nikename, String.class); // 昵称值
    String passwordVal = current.getObject(password, String.class); // 密码值

    // 启动自检校验
    if (StringUtil.isEmpty(accountVal, true) || StringUtil.isEmpty(nikenameVal, true)
            || StringUtil.isEmpty(passwordVal, true)) { return null; }

    // 检查账号重名问题
    User isExistaccount = new APIJSONParser(GETS, false).parseResponse(
            new JSONRequest(USER_TABLE, new apijson.JSONObject("")
                    .puts(USER_ACCOUNT, accountVal))).getObject(USER_TABLE, User.class);
    if (isExistaccount != null) {
      throw new RuntimeException("账号重名,请重新注册");
    }

    // 注册用户表业务
    String time = LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME);
    User userId = new APIJSONParser(POST, false).parseResponse(
            new JSONRequest(USER_TABLE, new apijson.JSONObject("")
                    .puts(USER_ACCOUNT, accountVal)
                    .puts(USER_NIKENAME, nikenameVal)
                    .puts(ROLE_FILE, USER_ROLE)
                    .puts(CREATE_DATE, time)
                    .puts(UPDATE_DATE, time)
            )).getObject(USER_TABLE, User.class);

    // 注册凭证业务
    return new APIJSONParser(POST, false).parseResponse(
            new JSONRequest(CREDENTIAL_TABLE, new apijson.JSONObject("")
                    .puts(CREDENTIAL_PASSWORD, passwordVal)
                    .puts(USERID, userId.getId())
                    .puts(CREATE_DATE, time)
                    .puts(UPDATE_DATE, time)
            ));
  }
}
