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
	// 초기화 블럭
	static Cipher cipher;
	static {
		try {
			cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
			/*
			 * AES : 암호 알고리즘 종류. 블럭단위가 128 비트임. 16바이트 CBC : 블럭화 모드 PKCS5Padding : 패딩 방식
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
		return key.substring(0, 16).getBytes();// 혹시라도 키값이 16비트보다 클경우
	}

	// 암호화
	public static String encrypt(String plain, String key) {
		byte[] ciperMsg = new byte[1024];
		try {
			Key genkey = new SecretKeySpec(makeKey(key), "AES");
			AlgorithmParameterSpec paramSpec = new IvParameterSpec(iv);// 초기화 백터
			cipher.init(Cipher.ENCRYPT_MODE, genkey, paramSpec);
			ciperMsg = cipher.doFinal(paddingString(plain).getBytes());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return byteToHex(ciperMsg).trim();// byte형을 Hex타입으로 변환해주기
	}

	// 128비트 단위로 블럭화함.
	private static String paddingString(String plain) {
		// 블럭 생성시 모자란 블럭은 공백으로 채우기
		char paddingChar = ' ';
		int size = 16;
		int x = plain.length() % size;
		// 나머지가 있다면?
		int len = size - x;// 모자란 부분
		for (int i = 0; i < len; i++)
			plain += paddingChar;// 모자란 부분에 공백으로 채우기
		return plain;// 완성된 블럭(암호문 + 공백)
	}

	private static String byteToHex(byte[] ciperMsg) {
		if (ciperMsg == null)
			return null;
		int len = ciperMsg.length;
		String str = "";
		for (int i = 0; i < len; i++) {
			if ((ciperMsg[i] & 0xFF) < 16)
				/*
				 * & 0xFF 비트 연산자(음수때문에 &)
				 * 
				 * //01010101 //11111111
				 */

				str += "0" + Integer.toHexString(ciperMsg[i] & 0xff);
			else
				str += Integer.toHexString(ciperMsg[i] & 0xFF);
		}
		return str;
	}

	// 복호화
	public static String decrypt(String ciper, String key) {
		byte[] plainMsg = new byte[1024];
		try {
			Key genkey = new SecretKeySpec(makeKey(key), "AES");// 같은 키값을 넣어주기
			AlgorithmParameterSpec paramSpec = new IvParameterSpec(iv);// 초기화 백터 객체
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
