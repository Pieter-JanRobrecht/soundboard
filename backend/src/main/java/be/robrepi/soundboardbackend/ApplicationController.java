package be.robrepi.soundboardbackend;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.HtmlUtils;

import java.util.Map;

@Controller
public class ApplicationController {
    private static final Map<String, String> VIDEOS = Map.of("exploring", "K69tbUo3vGs",
            "combat", "CLAa1urufGE");
    private final SimpMessagingTemplate template;

    public ApplicationController(SimpMessagingTemplate template) {
        this.template = template;
    }

    @GetMapping("/play-video")
    public ResponseEntity<Void> greeting(@RequestParam("video") String video) {
        this.template.convertAndSend("/topic/greetings", VIDEOS.get(video));
        return ResponseEntity.ok().build();
    }
}
