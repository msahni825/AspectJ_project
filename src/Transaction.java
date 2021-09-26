public class Transaction {
	public Transaction ()
	{
	}
	public void start() {
	System.out.println("Transaction started");
	}
	public void modify() {
	System.out.println("Transaction modified");
	}
	public void commit() {
	System.out.println("Transaction commited");
	}
	public void rollback() {
	System.out.println("Transaction rollbacked");
	}
}