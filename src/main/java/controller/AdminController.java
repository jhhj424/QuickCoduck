package controller;
import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import exception.DuckException;
import logic.DuckService;
import logic.Mail;
import logic.User;

//AOP ���� : AdminController �� ��� �޼���� �ݵ�� admin���� �α��� �ؾ߸� ���� �ǵ��� �ϱ�
//AOP Ŭ�������� �̸� : AdminAspect
// 1. �α�����  �ȵȰ��  : �α��� �ϼ��� �޼��� ��� �� loginForm.shop ���� �̵�
// 2. �����ڰ� �ƴѰ�� : �����ڸ� ��� �����մϴ�. mypage.shop ���� �̵�

@Controller
public class AdminController {
	@Autowired
	private DuckService service;
	
	@RequestMapping("admin/list")
	public ModelAndView list(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		List<User> userlist = service.userList();
		mav.addObject("userlist",userlist);
		return mav;
	}
	
	@RequestMapping("admin/mailForm")
	public ModelAndView mailForm(String[] idchks, HttpSession session) {
		ModelAndView mav = new ModelAndView("admin/mail");
		if(idchks == null || idchks.length == 0) {
			throw new DuckException("������ ���� ����ڸ� �����ϼ���","list.duck");
		}
		List<User> userList = service.userList(idchks);
		mav.addObject("userList",userList);
		return mav;
	}
	
	@RequestMapping("admin/mail")
	public ModelAndView mail(Mail mail, HttpSession session) {
		ModelAndView mav = new ModelAndView("admin/mail");
		mailSend(mail);
		return mav;
	}
	//�ڹٸ����� �̿��Ͽ� ���� ���۽� ���� ������ ���� �ޱ����� ��ü
	private final class MyAuthenticator extends Authenticator{
		private String id;
		private String pw;
		public MyAuthenticator(String id, String pw) {
			this.id = id;
			this.pw = pw;
		}
		@Override
		protected PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(id,pw);
		}
	}
	//mail : ȭ�鿡�� �Է��� ���� ����
	private void mailSend(Mail mail) {
		//���� ������ ���� ȯ�溯�� ����
		MyAuthenticator auth = new MyAuthenticator(mail.getNaverid(),mail.getNaverpw()); //���� - ���ǿ� ����ɶ�
		Properties prop = new Properties(); //Map��ü 
		prop.put("mail.smtp.host", "smtp.naver.com"); //���� ���ۼ��� �ּ�����
		prop.put("mail.smtp.starttls.enable", "true"); //���ȼ���
		//prop.put("mail.user", mail.getNaverid());
		//prop.put("mail.from", mail.getNaverid() + "@naver.com");
		prop.put("mail.debug", "true"); //debug���·� �ǽ��ϱ�
		prop.put("mail.smtp.auth","true"); //���� ���۽� ���� �ʼ�
		prop.put("mail.smtp.port", "465");
		prop.put("mail.smtp.user", mail.getNaverid()); //������ ��� ����
		prop.put("mail.smtp.socketFactory.port", "465");
		prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		prop.put("mail.smtp.socketFactory.fallback", "false");
		Session session = Session.getInstance(prop,auth); //���� ������ ����
		//session�� ���� ���۵Ǵ� ��ü
		MimeMessage msg = new MimeMessage(session); //���Ϸ� ������ ��ü ����
		try {
			//������ ��� ����
			msg.setFrom(new InternetAddress(mail.getNaverid() + "@naver.com"));
			List<InternetAddress> addrs = new ArrayList<InternetAddress>();
			//mail.getRecipient() : �׽�Ʈ1 <�̸���@naver.com>, �׽�Ʈ2 <�̸���@naver.com>,
			String[] emails = mail.getRecipient().split(",");
			for(String email : emails) {
				try {
					addrs.add(new InternetAddress(new String(email.getBytes("UTF-8"),"8859_1")));
				}catch(UnsupportedEncodingException e) {
					e.printStackTrace();
				}
			}
			InternetAddress[] arr = new InternetAddress[emails.length];
			for(int i=0; i<addrs.size(); i++) {
				arr[i] = addrs.get(i);
			}
			msg.setSentDate(new Date());//��������
			//�޴� ��� ����
			// Message.RecipientType.TO : �޴»��
			// Message.RecipientType.CC : �����ϴ� ��� ���� ����
			msg.setRecipients(Message.RecipientType.TO, arr);
			msg.setSubject(mail.getTitle());//������
			
			//����κм���
			//multipart : ���� �κ��� �������� ������. ����, ÷������1, ÷������2
			MimeMultipart multipart = new MimeMultipart();
			//����κ��� msg�� �߰�
			MimeBodyPart message = new MimeBodyPart();
			message.setContent(mail.getContents(),mail.getMtype());
			multipart.addBodyPart(message);
			
			//÷������ �κ��� msg�� �߰�
			//List<MultipartFile> : mail.getFile1()
			for(MultipartFile mf : mail.getFile1()) {
				if((mf != null) && (!mf.isEmpty())) {
					multipart.addBodyPart(bodyPart(mf)); //÷�ε� ������ ���Ͽ� ����
				}
			}
			//msg : ���Ϸ� ������ ��ü 
			msg.setContent(multipart);
			
			Transport.send(msg); //���� ���� ����.
		}catch(MessagingException me) {
			me.printStackTrace();
		}
	}
	private BodyPart bodyPart(MultipartFile mf) {
		MimeBodyPart body = new MimeBodyPart();
		String orgFile = mf.getOriginalFilename();//���� �̸�
		//f1 : upload�� ������ ������ ������ ��ġ 
		File f1 = new File("D:/spring/workspace/mavenshop3/mailupload/" + orgFile);
		try {
			mf.transferTo(f1);//���Ϸ� �����ϱ�
			body.attachFile(f1);//������ ���Ͽ� ÷���ϱ�
			body.setFileName(new String(orgFile.getBytes("UTF-8"),"8859_1")); //�ѱ����ڵ�
		}catch(Exception e) {
			e.printStackTrace();
		}
		return body;
	}
}