//import java.util.*;
//
//public aspect IteratorVerifier
//{
//
//	//@match legal
//	//@fail iilegal
//
//	Set<Transaction> transProp = new HashSet<Transaction>();
//	
//	before(Transaction i) throws CommitException:
//		call(* Transaction.commit()) && target(i)
//		{
//			if(transProp.contains(i))
//				transProp.remove(i);
//			else
//				throw new CommitException();
//		}
//	
//	before(Transaction i) throws StartException:
//		call(* Transaction.start()) && target(i)
//		{
//		if(transProp.contains(i))
//			throw new StartException();
//		else
//			transProp.add(i);
//		}
//	
//	@SuppressWarnings("unlikely-arg-type")
//	before(Transaction i) throws ModifyException:
//		call(* Transaction.modify()) && target(i)
//		{
//		if(!transProp.contains(i) && !transProp.contains("Transaction.start()"))
//			throw new ModifyException();
//		}
//	
//	after(Transaction i) throws ModifyException:
//		call(* Transaction.modify()) && target(i)
//		{
//	    if(transProp.contains(i) && transProp.contains("Transaction.commit()")) 
//			throw new ModifyException();
//		}	
//}