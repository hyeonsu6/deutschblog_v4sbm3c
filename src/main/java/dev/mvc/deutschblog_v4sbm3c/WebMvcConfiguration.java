package dev.mvc.deutschblog_v4sbm3c;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import dev.mvc.articles.Articles;

@Configuration
public class WebMvcConfiguration implements WebMvcConfigurer{
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // Windows: path = "E:\DeutschBlog\deutschblogdeploy\deutschblog_v4sbm3c_blog\articles\storage";
        // ▶ file:///E:\DeutschBlog\deutschblogdeploy\deutschblog_v4sbm3c_blog\articles\storage
      
        // Ubuntu: path = "/home/ubuntu/deutschblogdeploy/deutschblog_v4sbm3c_blog/articles/storage";
        // ▶ file:////home/ubuntu/deutschblogdeploy/deutschblog_v4sbm3c_blog/articles/storage
      
        // JSP 인식되는 경로: http://localhost:9092/articles/storage";
        registry.addResourceHandler("/articles/storage/**")
        .addResourceLocations("file:///" +  Articles.getUploadDir());
        
        // JSP 인식되는 경로: http://localhost:9091/attachfile/storage";
        // registry.addResourceHandler("/contents/storage/**").addResourceLocations("file:///" +  Tool.getOSPath() + "/attachfile/storage/");
        
        // JSP 인식되는 경로: http://localhost:9091/member/storage";
        // registry.addResourceHandler("/contents/storage/**").addResourceLocations("file:///" +  Tool.getOSPath() + "/member/storage/");
    }
 
}