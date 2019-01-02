package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ChatContoller {
	@RequestMapping("chat/chat")
	public String chat() {
		return null; //return "chat/chat"; //view 이름 설정 // null인 경우에는 @RequestMapping의 url로 설정됨.
	}
}
