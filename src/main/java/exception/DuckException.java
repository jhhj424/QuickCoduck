package exception;

public class DuckException extends RuntimeException {
	private String url;
	public DuckException(String msg, String url) {
		super(msg);
		this.url = url;
	}
	public String getUrl() {
		return url;
	}
}
