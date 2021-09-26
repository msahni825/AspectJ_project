package transaction;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.Scanner;  

public class Testcase {    
	public static void main(String[] args) {
		Transaction transaction = new Transaction();
		transaction.start();
		transaction.start();
		transaction.modify();
		transaction.modify();
		transaction.commit();
//		transaction.commit();
	}    
}  