package be.robrepi.soundboardbackend;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.util.HtmlUtils;

@EnableScheduling
@Controller
public class ScheduledController {
    private final SimpMessagingTemplate template;

    public ScheduledController(SimpMessagingTemplate template) {
        this.template = template;
    }

    @Scheduled(fixedRate = 5000)
    public void greeting() {
        System.out.println("scheduled");
        this.template.convertAndSend("/topic/greetings", new Greeting("Hello, scheduled!"));
    }
}
