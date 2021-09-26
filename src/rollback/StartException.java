package rollback;

public class StartException extends RuntimeException {
	public StartException() {
		System.out.println("Rollback should be preceded by a start");
		//System.out.println("Multiple starts are not allowed.");
	}
}
