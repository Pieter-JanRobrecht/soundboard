package be.robrepi.soundboardbackend;

import be.robrepi.soundboardbackend.model.Video;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

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
    public ResponseEntity<List<Video>> getVideos() {
        log.info("Requesting all videos");
        return ResponseEntity.ok(videoMap.getVideos());
    }

    @GetMapping("/request-video")
    public ResponseEntity<Void> requestVideo(@RequestParam("video") String ytId) {
        log.info("Got request for [{}]", ytId);
        template.convertAndSend("/topic/videos", ytId);
        return ResponseEntity.ok().build();
    }
}
