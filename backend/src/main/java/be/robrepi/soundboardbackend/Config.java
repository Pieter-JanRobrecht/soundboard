package be.robrepi.soundboardbackend;

import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@EnableConfigurationProperties(VideoMap.class)
public class Config {
}
