package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ChatContoller {
	@RequestMapping("chat/chat")
	public String chat() {
		return null; //return "chat/chat"; //view �̸� ���� // null�� ��쿡�� @RequestMapping�� url�� ������.
	}
}
