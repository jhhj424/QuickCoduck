package websocket;

import java.util.HashSet;
import java.util.Set;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;


public class EchoHandler extends TextWebSocketHandler {
	Set<WebSocketSession> clients = new HashSet<WebSocketSession>(); // HashSet : �ߺ� X

	@Override // ���� ����� ȣ��Ǵ� �޼���
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		super.afterConnectionClosed(session, status);
		System.out.println("Ŭ���̾�Ʈ ������ ������:" + status.getReason());
	}

	@Override // ����Ǿ��� �� ȣ��Ǵ� �޼���
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		super.afterConnectionEstablished(session);
		System.out.println("Ŭ���̾�Ʈ ���ӵ�.");
		clients.add(session);
	}

	@Override // �޼��� ���Ž� ȣ��Ǵ� �޼���
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
		int serverno = Integer.parseInt(session.getId());
		//String name[] = { "������", "�赿��", "�ⷯ�� ", "��û�� ", "��ī�� ", "�ߵ��� ", "������ ", "�赿�� ", "������ ", "��â�� ", "�̵��� " };
		int a = session.getRemoteAddress().toString().indexOf("/") + 1;
		int b = session.getRemoteAddress().toString().indexOf(":");
		String str = session.getRemoteAddress().toString().substring(a, b);
		System.out.println(str.indexOf("107"));
		if(str.indexOf("107") != -1) {
			str = "������";
		}
		System.out.println(a + "," + b);
		String payloadMessage = str + ":" + (String) message.getPayload();
		System.out.println(serverno + "������ ������ �޼���:" + payloadMessage);
		// clients : ���� handler�� ��ϵ� ��� client ��� ����
		clients.add(session);
		for (WebSocketSession s : clients) {
			s.sendMessage(new TextMessage(payloadMessage));
		}
	}

	@Override // ���� �߻��� ȣ��Ǵ� �޼���
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		super.handleTransportError(session, exception);
		System.out.println("�����߻���:" + exception.getMessage());
	}
}
