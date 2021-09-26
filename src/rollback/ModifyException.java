package rollback;

public class ModifyException extends RuntimeException {
	public ModifyException() {
		System.out.println("Modify can only happen between start and commit.");
	}
}
