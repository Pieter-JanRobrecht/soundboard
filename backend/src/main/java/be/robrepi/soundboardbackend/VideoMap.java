package be.robrepi.soundboardbackend;

import org.springframework.boot.context.properties.ConfigurationProperties;

import java.util.Map;

@ConfigurationProperties(prefix = "available")
public class VideoMap {
    private Map<String, String> videos;

    public Map<String, String> getVideos() {
        return videos;
    }

    public void setVideos(Map<String, String> videos) {
        this.videos = videos;
    }
}
