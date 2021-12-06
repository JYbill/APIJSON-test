package top.jybill.config;

import apijson.RequestMethod;
import apijson.framework.APIJSONSQLConfig;
import apijson.orm.AbstractSQLConfig;

public class DemoSQLConfig extends APIJSONSQLConfig {


    public DemoSQLConfig() {super();}
    public DemoSQLConfig(RequestMethod method, String table) {super(method, table);}

    static {
        DEFAULT_DATABASE = "MYSQL";  // MYSQL, POSTGRESQL, SQLSERVER, ORACLE, DB2
        DEFAULT_SCHEMA = "course";  // 数据库的 Schema 名
    }

    @Override
    public String getDBVersion() {
        return "5.5.36";
    }

    @Override
    public String getDBUri() {
        return "jdbc:mysql://127.0.0.1:3306?serverTimezone=GMT%2B8&useUnicode=true&characterEncoding=UTF-8";
    }

    @Override
    public String getDBAccount() {
        return "root";
    }

    @Override
    public String getDBPassword() {
        return "990415";
    }
}
