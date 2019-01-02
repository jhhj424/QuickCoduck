package util;

import java.security.Key;
import java.security.spec.AlgorithmParameterSpec;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.stereotype.Component;

@Component
public class CipherUtil {
	private final static byte[] iv = new byte[] { (byte) 0x8E, 0x12, 0x39, (byte) 0x9C, 0x07, 0x72, 0x6F, (byte) 0x5A,
			(byte) 0x8E, 0x12, 0x39, (byte) 0x9C, 0x07, 0x72, 0x6F, (byte) 0x5A };
	// �ʱ�ȭ ��
	static Cipher cipher;
	static {
		try {
			cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
			/*
			 * AES : ��ȣ �˰��� ����. �������� 128 ��Ʈ��. 16����Ʈ CBC : ��ȭ ��� PKCS5Padding : �е� ���
			 */
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static byte[] makeKey(String key) {
		int len = key.length();
		char ch = 'A';
		for (int i = len; i < 16; i++)
			key += ch++;
		return key.substring(0, 16).getBytes();// Ȥ�ö� Ű���� 16��Ʈ���� Ŭ���
	}

	// ��ȣȭ
	public static String encrypt(String plain, String key) {
		byte[] ciperMsg = new byte[1024];
		try {
			Key genkey = new SecretKeySpec(makeKey(key), "AES");
			AlgorithmParameterSpec paramSpec = new IvParameterSpec(iv);// �ʱ�ȭ ����
			cipher.init(Cipher.ENCRYPT_MODE, genkey, paramSpec);
			ciperMsg = cipher.doFinal(paddingString(plain).getBytes());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return byteToHex(ciperMsg).trim();// byte���� HexŸ������ ��ȯ���ֱ�
	}

	// 128��Ʈ ������ ��ȭ��.
	private static String paddingString(String plain) {
		// �� ������ ���ڶ� ���� �������� ä���
		char paddingChar = ' ';
		int size = 16;
		int x = plain.length() % size;
		// �������� �ִٸ�?
		int len = size - x;// ���ڶ� �κ�
		for (int i = 0; i < len; i++)
			plain += paddingChar;// ���ڶ� �κп� �������� ä���
		return plain;// �ϼ��� ��(��ȣ�� + ����)
	}

	private static String byteToHex(byte[] ciperMsg) {
		if (ciperMsg == null)
			return null;
		int len = ciperMsg.length;
		String str = "";
		for (int i = 0; i < len; i++) {
			if ((ciperMsg[i] & 0xFF) < 16)
				/*
				 * & 0xFF ��Ʈ ������(���������� &)
				 * 
				 * //01010101 //11111111
				 */

				str += "0" + Integer.toHexString(ciperMsg[i] & 0xff);
			else
				str += Integer.toHexString(ciperMsg[i] & 0xFF);
		}
		return str;
	}

	// ��ȣȭ
	public static String decrypt(String ciper, String key) {
		byte[] plainMsg = new byte[1024];
		try {
			Key genkey = new SecretKeySpec(makeKey(key), "AES");// ���� Ű���� �־��ֱ�
			AlgorithmParameterSpec paramSpec = new IvParameterSpec(iv);// �ʱ�ȭ ���� ��ü
			cipher.init(Cipher.DECRYPT_MODE, genkey, paramSpec);
			plainMsg = cipher.doFinal(hexToByte(ciper.trim()));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new String(plainMsg).trim();
	}

	private static byte[] hexToByte(String str) {
		if (str == null)
			return null;
		if (str.length() < 2)
			return null;
		int len = str.length() / 2;
		byte[] buffer = new byte[len];
		for (int i = 0; i < len; i++) {
			buffer[i] = (byte) Integer.parseInt(str.substring(i * 2, i * 2 + 2), 16);
		}
		return buffer;
	}
}
