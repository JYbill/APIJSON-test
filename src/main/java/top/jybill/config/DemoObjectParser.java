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

import apijson.NotNull;
import apijson.RequestMethod;
import apijson.framework.APIJSONObjectParser;
import apijson.orm.Join;
import apijson.orm.SQLConfig;
import com.alibaba.fastjson.JSONObject;

import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.List;


/**简化Parser，getObject和getArray(getArrayConfig)都能用
 * @author Lemon
 */
public class DemoObjectParser extends APIJSONObjectParser {

    public DemoObjectParser(HttpSession session, @NotNull JSONObject request, String parentPath, SQLConfig arrayConfig
            , boolean isSubquery, boolean isTable, boolean isArrayMainTable) throws Exception {
        super(session, request, parentPath, arrayConfig, isSubquery, isTable, isArrayMainTable);
    }

    private static final String CREATE_DATE = "create_date";
    private static final String UPDATE_DATE = "update_date";

    // 没经过远程调用函数的POST、PUT请求默认添加时间
    @Override
    public SQLConfig newSQLConfig(RequestMethod method, String table, String alias, JSONObject request, List<Join> joinList, boolean isProcedure) throws Exception {
        if (method == RequestMethod.POST) {
            request.put(CREATE_DATE, new Timestamp(System.currentTimeMillis()));
            request.put(UPDATE_DATE, new Timestamp(System.currentTimeMillis()));
        }
        if (method == RequestMethod.PUT) {
            request.put(UPDATE_DATE, new Timestamp(System.currentTimeMillis()));
        }
        return DemoSQLConfig.newSQLConfig(method, table, alias, request, joinList, isProcedure);
    }


}
