package com.mindlink.assistant;

import com.mindlink.assistant.service.ChatbotService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

/**
 * Virtual Assistant - Chatbot Controller (Rule-based System)
 * Handles chatbot interactions using keyword-based rules from database
 */
@Controller
@RequestMapping("/ai")
public class ChatbotController {

    @Autowired
    private ChatbotService chatbotService;

    // URL: /ai/chatbot
    // JSP: WEB-INF/assistant/chatbot.jsp
    @GetMapping("/chatbot")
    public String showChatbot(Model model) {
        // Optionally load initial message or tips
        return "assistant/chatbot";
    }

    // Handle chatbot query (POST request from AJAX or form)
    @PostMapping("/chatbot/query")
    @ResponseBody
    public Map<String, String> processQuery(@RequestParam(value = "message", required = false) String message) {
        Map<String, String> response = new HashMap<>();
        if (message != null && !message.trim().isEmpty()) {
            String botResponse = chatbotService.getResponse(message);
            response.put("response", botResponse);
        } else {
            response.put("response", "I'm here to help! Please ask me a question.");
        }
        return response;
    }
}