package transaction;

public class CommitException extends RuntimeException {
	public CommitException() {
		System.out.println("Multiple commits are not allowed.");
	}
}
