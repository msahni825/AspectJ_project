
public class StartException extends RuntimeException {
	public StartException() {
		System.out.println("Multiple starts are not allowed.");
	}
}
