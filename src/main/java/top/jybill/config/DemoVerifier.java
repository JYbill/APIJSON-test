/*Copyright ©2016 TommyLemon(https://github.com/TommyLemon/APIJSON)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.*/

package top.jybill.config;

import apijson.RequestMethod;
import apijson.StringUtil;
import apijson.framework.APIJSONParser;
import apijson.framework.APIJSONVerifier;
import apijson.orm.Entry;
import apijson.orm.JSONRequest;
import apijson.orm.SQLConfig;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import top.jybill.model.User;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import static apijson.RequestMethod.GETS;


/**权限验证器
 * @author Lemon
 */
public class DemoVerifier extends APIJSONVerifier {
	public static final String TAG = "DemoVerifier";

	static {
		ROLE_MAP.put("TEACHER", new Entry("", ""));
	}
	private static final int ROLE_TEACHER_CODE = 1;
	private static final int ROLE_ADMIN_CODE = 2;

	private static final String USER_CLASS_NAME = User.class.getSimpleName();
	@Override
	public boolean verifyAccess(SQLConfig config) throws Exception {
		// 预校验
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

		// 后面会校验其他已存在的角色
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
