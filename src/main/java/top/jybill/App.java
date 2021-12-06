package top.jybill;

import apijson.StringUtil;
import apijson.framework.APIJSONApplication;
import apijson.framework.APIJSONCreator;
import apijson.orm.*;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import top.jybill.config.*;

import java.util.Map;
import java.util.regex.Pattern;

@Configuration
@SpringBootApplication
public class App {

  static {
    // VERIFY 校验规则
    Map<String, Pattern> COMPILE_MAP = AbstractVerifier.COMPILE_MAP;
    COMPILE_MAP.put("PHONE", StringUtil.PATTERN_PHONE);

    APIJSONApplication.DEFAULT_APIJSON_CREATOR = new APIJSONCreator() {

      @Override
      public Parser<Long> createParser() {
        return new DemoParser();
      }


      @Override
      public FunctionParser createFunctionParser() {
        return new DemoFunctionParser();
      }


      @Override
      public Verifier<Long> createVerifier() {
        return new DemoVerifier();
      }

      @Override
      public SQLConfig createSQLConfig() {
        return new DemoSQLConfig();
      }


    };

  }

  public static void main(String[] args) throws Exception {
    SpringApplication.run(App.class, args);
    APIJSONApplication.init(true);
  }


  @Bean
  public WebMvcConfigurer corsConfigurer() {
    return new WebMvcConfigurer() {
      @Override
      public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                .allowedMethods("*")
                .allowCredentials(true)
                .maxAge(3600);
      }
    };
  }
}
