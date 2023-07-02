package be.robrepi.soundboardbackend;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Set;

@Controller
public class ApplicationController {
    private final Logger log = LoggerFactory.getLogger(ApplicationController.class);
    private final VideoMap videoMap;
    private final SimpMessagingTemplate template;

    public ApplicationController(VideoMap videoMap, SimpMessagingTemplate template) {
        this.videoMap = videoMap;
        this.template = template;
    }

    @GetMapping("/videos")
    public ResponseEntity<Set<String>> getVideos() {
        log.info("Requesting all videos");
        return ResponseEntity.ok(videoMap.getVideos().keySet());
    }

    @GetMapping("/request-video")
    public ResponseEntity<Void> requestVideo(@RequestParam("video") String video) {
        log.info("Got request for [{}]", video);
        template.convertAndSend("/topic/videos", videoMap.getVideos().get(video));
        return ResponseEntity.ok().build();
    }
}
