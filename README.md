# 前提

+ 希望来的看客是对`APIJSON`有一定的了解
  1. 知道各种查询
  2. 知道`PUT/DELETE/POST`请求写在`Request表`
  3. 以及知道使用`Function表`进行远程调用

> 这里只说明鉴定权限

[apijson_todo_demo快速上手demo](https://github.com/jerrylususu/apijson_todo_demo/blob/master/FULLTEXT.md)
[apijson-doc 查询文档](http://apijson.cn/doc/zh/#%E6%8E%A5%E5%8F%A3%E5%BC%80%E5%8F%91)







# 权限鉴定

> `APIJSONVerifier#verifyAccess`是一个鉴权的处理函数，如果角色不为`UNKNOW`会校验是否登陆

```java
if (!role.equals("UNKNOWN")) {
    this.verifyLogin();
}

public void verifyLogin() throws Exception {
    if (this.visitorId == null) {
        throw new NotLoggedInException("未登录，请登录后再操作！");
    } else {
        if (this.visitorId instanceof Number) {
            if (((Number)this.visitorId).longValue() <= 0L) {
                throw new NotLoggedInException("未登录，请登录后再操作！");
            }
        } else {
            if (!(this.visitorId instanceof String)) {
                throw new UnsupportedDataTypeException("visitorId 只能是 Long 或 String 类型！");
            }

            if (StringUtil.isEmpty(this.visitorId, true)) {
                throw new NotLoggedInException("未登录，请登录后再操作！");
            }
        }

    }
}
```

> 如果角色是`ADMIN`会调用`verifyAdmin()`默认没重写会调用本身的

```java
switch(role.hashCode()) {
    case 62130991:
        if (role.equals("ADMIN")) {
            var8 = 4;
        }
        break;
}

switch(var8) {
    case 4:
        this.verifyAdmin();
}

public void verifyAdmin() throws Exception {
    throw new UnsupportedOperationException("不支持 ADMIN 角色！如果要支持就在子类重写这个方法来校验 ADMIN 角色，不通过则 throw IllegalAccessException!");
}
```







# 自定义鉴权

> Github项目：[https://github.com/JYbill/APIJSON-test](https://github.com/JYbill/APIJSON-test)
>
> Gitee项目：[https://gitee.com/JYbill/apijson-test](https://gitee.com/JYbill/apijson-test)

1. 继承`APIJSONVerifier`，自定义角色、自定义角色校验、自定义管理员校验

```java
public class DemoVerifier extends APIJSONVerifier {
	public static final String TAG = "DemoVerifier";

    // 添加自定义角色
	static {
		ROLE_MAP.put("TEACHER", new Entry("", ""));
	}
    
    // 这是我表里的逻辑: 0普通用户、1老师、2管理员
	private static final int ROLE_TEACHER_CODE = 1;
	private static final int ROLE_ADMIN_CODE = 2;

	private static final String USER_CLASS_NAME = User.class.getSimpleName();
    
    // 注意返回为true就会通过校验
	@Override
	public boolean verifyAccess(SQLConfig config) throws Exception {
		// 过滤预校验
		if (config.getTable().equals("Function") && config.getMethod() == RequestMethod.HEAD ||
						config.getTable().equals("Function") && config.getMethod() == RequestMethod.GET ||
						config.getTable().equals("Access") && config.getMethod() == RequestMethod.HEAD ||
						config.getTable().equals("Access") && config.getMethod() == RequestMethod.GET ||
						config.getTable().equals("Request") && config.getMethod() == RequestMethod.GET ||
						config.getTable().equals("Request") && config.getMethod() == RequestMethod.HEAD) {
			return true;
		}

		String role = config.getRole();

		// 校验自定义角色
		switch (role) {
			case "TEACHER":
				if (!(this.visitor instanceof User)) {
					throw new IllegalArgumentException("未登录!");
				}
				if (((User)this.visitor).getRole() < 1) {
					throw new IllegalArgumentException("请勿伪造" + role + "角色");
				}
				break;
		}

		// 如果是ADMIN，LOGIN等角色，后面会校验其他已存在的角色
		return super.verifyAccess(config);
	}

	// 校验管理员
	@Override
	public void verifyAdmin() throws Exception {
		if (((User)this.visitor).getRole() < 2) {
			throw new IllegalArgumentException("请勿伪造[" + ADMIN + "]角色");
		}
	}
}
```

> `APIJSON`开发效率还是蛮高的，适合那种需要快速开发中小项目。如果觉得本项目对你的学习有帮助可以点个`✨`