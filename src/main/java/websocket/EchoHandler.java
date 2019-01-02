package websocket;

import java.util.HashSet;
import java.util.Set;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;


public class EchoHandler extends TextWebSocketHandler {
	Set<WebSocketSession> clients = new HashSet<WebSocketSession>(); // HashSet : 중복 X

	@Override // 연결 종료시 호출되는 메서드
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		super.afterConnectionClosed(session, status);
		System.out.println("클라이언트 접속이 해제됨:" + status.getReason());
	}

	@Override // 연결되었을 때 호출되는 메서드
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		super.afterConnectionEstablished(session);
		System.out.println("클라이언트 접속됨.");
		clients.add(session);
	}

	@Override // 메세지 수신시 호출되는 메서드
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
		int serverno = Integer.parseInt(session.getId());
		//String name[] = { "관리자", "김동진", "기러기 ", "멍청이 ", "피카츄 ", "야도란 ", "메이플 ", "김동진 ", "범영광 ", "이창민 ", "이동훈 " };
		int a = session.getRemoteAddress().toString().indexOf("/") + 1;
		int b = session.getRemoteAddress().toString().indexOf(":");
		String str = session.getRemoteAddress().toString().substring(a, b);
		System.out.println(str.indexOf("107"));
		if(str.indexOf("107") != -1) {
			str = "도롱이";
		}
		System.out.println(a + "," + b);
		String payloadMessage = str + ":" + (String) message.getPayload();
		System.out.println(serverno + "서버에 도착한 메세지:" + payloadMessage);
		// clients : 현재 handler에 등록된 모든 client 목록 저장
		clients.add(session);
		for (WebSocketSession s : clients) {
			s.sendMessage(new TextMessage(payloadMessage));
		}
	}

	@Override // 에러 발생시 호출되는 메서드
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		super.handleTransportError(session, exception);
		System.out.println("오류발생됨:" + exception.getMessage());
	}
}
