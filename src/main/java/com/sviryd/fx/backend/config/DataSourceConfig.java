package com.sviryd.fx.backend.config;

import lombok.Getter;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.init.DataSourceInitializer;
import org.springframework.jdbc.datasource.init.ResourceDatabasePopulator;

import javax.sql.DataSource;

@Getter
@Setter
@Configuration
public class DataSourceConfig {
    @Bean
    public DataSourceInitializer dataSourceInitializer(@Qualifier("dataSource") final DataSource dataSource) {
        DataSourceInitializer dataSourceInitializer = new DataSourceInitializer();
        ResourceDatabasePopulator resourceDatabasePopulator = new ResourceDatabasePopulator();
        dataSourceInitializer.setDataSource(dataSource);
//        resourceDatabasePopulator.addScript(new ClassPathResource("/db/data/sql1.sql")); // load any sql before application starts
        return dataSourceInitializer;
    }
}
