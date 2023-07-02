package be.robrepi.soundboardbackend;

import org.springframework.http.ResponseEntity;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;
import java.util.Set;

@Controller
public class ApplicationController {
    private static final Map<String, String> VIDEOS =
            Map.of(
                    "exploring", "K69tbUo3vGs",
                    "combat", "CLAa1urufGE",
                    "tavern", "vyg5jJrZ42s",
                    "classic-evil", "Q0OhmGD-4-E",
                    "snowy-harry-potter", "oE-pXV-G9aY"
            );
    private final SimpMessagingTemplate template;

    public ApplicationController(SimpMessagingTemplate template) {
        this.template = template;
    }

    @GetMapping("/videos")
    public ResponseEntity<Set<String>> getVideos() {
        return ResponseEntity.ok(VIDEOS.keySet());
    }

    @GetMapping("/play-video")
    public ResponseEntity<Void> greeting(@RequestParam("video") String video) {
        this.template.convertAndSend("/topic/videos", VIDEOS.get(video));
        return ResponseEntity.ok().build();
    }
}
