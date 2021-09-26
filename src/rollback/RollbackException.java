package rollback;

public class RollbackException extends RuntimeException{

	public RollbackException()
	{
		//System.out.println("Transcation not completed: Rollback transaction");
		System.out.println("Continous Rollbacks in a transaction");
	}
}
