package com.project_mung;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.project_mung.mapper")
public class ProjectMungApplication {

    public static void main(String[] args) {
        SpringApplication.run(ProjectMungApplication.class, args);
    }

}
