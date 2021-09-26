package transaction;
import java.util.*;

public aspect TransactionVerifier
{

	//@match legal
	//@fail iilegal

	Set<Transaction> transProp = new HashSet<Transaction>();
	
	before(Transaction i) throws CommitException:
		call(* Transaction.commit()) && target(i)
		{
			if(transProp.contains(i))
				transProp.remove(i);
			else
				throw new CommitException();
		}
	
	before(Transaction i) throws StartException:
		call(* Transaction.start()) && target(i)
		{
		if(transProp.contains(i))
			throw new StartException();
		else
			transProp.add(i);
		}
	
	@SuppressWarnings("unlikely-arg-type")
	before(Transaction i) throws ModifyException:
		call(* Transaction.modify()) && target(i)
		{
		if(!transProp.contains(i) && !transProp.contains("Transaction.start()"))
			throw new ModifyException();
		}
	
	after(Transaction i) throws ModifyException:
		call(* Transaction.modify()) && target(i)
		{
	    if(transProp.contains(i) && transProp.contains("Transaction.commit()")) 
			throw new ModifyException();
		}
	
		
}



//package transaction;
//import java.io.*;
//import java.util.*;
//import javamoprt.*;
//import java.lang.ref.*;
//import org.aspectj.lang.*;
//
//class TransactionMonitor_Set extends javamoprt.MOPSet {
//	protected TransactionMonitor[] elementData;
//
//	public TransactionMonitor_Set(){
//		this.size = 0;
//		this.elementData = new TransactionMonitor[4];
//	}
//
//	public final int size(){
//		while(size > 0 && elementData[size-1].MOP_terminated) {
//			elementData[--size] = null;
//		}
//		return size;
//	}
//
//	public final boolean add(MOPMonitor e){
//		ensureCapacity();
//		elementData[size++] = (TransactionMonitor)e;
//		return true;
//	}
//
//	public final void endObject(int idnum){
//		int numAlive = 0;
//		for(int i = 0; i < size; i++){
//			TransactionMonitor monitor = elementData[i];
//			if(!monitor.MOP_terminated){
//				monitor.endObject(idnum);
//			}
//			if(!monitor.MOP_terminated){
//				elementData[numAlive++] = monitor;
//			}
//		}
//		for(int i = numAlive; i < size; i++){
//			elementData[i] = null;
//		}
//		size = numAlive;
//	}
//
//	public final boolean alive(){
//		for(int i = 0; i < size; i++){
//			MOPMonitor monitor = elementData[i];
//			if(!monitor.MOP_terminated){
//				return true;
//			}
//		}
//		return false;
//	}
//
//	public final void endObjectAndClean(int idnum){
//		int size = this.size;
//		this.size = 0;
//		for(int i = size - 1; i >= 0; i--){
//			MOPMonitor monitor = elementData[i];
//			if(monitor != null && !monitor.MOP_terminated){
//				monitor.endObject(idnum);
//			}
//			elementData[i] = null;
//		}
//		elementData = null;
//	}
//
//	public final void ensureCapacity() {
//		int oldCapacity = elementData.length;
//		if (size + 1 > oldCapacity) {
//			cleanup();
//		}
//		if (size + 1 > oldCapacity) {
//			TransactionMonitor[] oldData = elementData;
//			int newCapacity = (oldCapacity * 3) / 2 + 1;
//			if (newCapacity < size + 1){
//				newCapacity = size + 1;
//			}
//			elementData = Arrays.copyOf(oldData, newCapacity);
//		}
//	}
//
//	public final void cleanup() {
//		int numAlive = 0 ;
//		for(int i = 0; i < size; i++){
//			TransactionMonitor monitor = (TransactionMonitor)elementData[i];
//			if(!monitor.MOP_terminated){
//				elementData[numAlive] = monitor;
//				numAlive++;
//			}
//		}
//		for(int i = numAlive; i < size; i++){
//			elementData[i] = null;
//		}
//		size = numAlive;
//	}
//
//	public final void event_commit(Transaction i) {
//		int numAlive = 0 ;
//		for(int i_1 = 0; i_1 < this.size; i_1++){
//			TransactionMonitor monitor = (TransactionMonitor)this.elementData[i_1];
//			if(!monitor.MOP_terminated){
//				elementData[numAlive] = monitor;
//				numAlive++;
//
//				monitor.Prop_1_event_commit(i);
//				if(monitor.Prop_1_Category_fail) {
//					monitor.Prop_1_handler_fail(i);
//				}
//			}
//		}
//		for(int i_1 = numAlive; i_1 < this.size; i_1++){
//			this.elementData[i_1] = null;
//		}
//		size = numAlive;
//	}
//
//	public final void event_start(Transaction i) {
//		int numAlive = 0 ;
//		for(int i_1 = 0; i_1 < this.size; i_1++){
//			TransactionMonitor monitor = (TransactionMonitor)this.elementData[i_1];
//			if(!monitor.MOP_terminated){
//				elementData[numAlive] = monitor;
//				numAlive++;
//
//				monitor.Prop_1_event_start(i);
//				if(monitor.Prop_1_Category_fail) {
//					monitor.Prop_1_handler_fail(i);
//				}
//			}
//		}
//		for(int i_1 = numAlive; i_1 < this.size; i_1++){
//			this.elementData[i_1] = null;
//		}
//		size = numAlive;
//	}
//
//	public final void event_modify_3(Transaction i) {
//		int numAlive = 0 ;
//		for(int i_1 = 0; i_1 < this.size; i_1++){
//			TransactionMonitor monitor = (TransactionMonitor)this.elementData[i_1];
//			if(!monitor.MOP_terminated){
//				elementData[numAlive] = monitor;
//				numAlive++;
//
//				monitor.Prop_1_event_modify_3(i);
//				if(monitor.Prop_1_Category_fail) {
//					monitor.Prop_1_handler_fail(i);
//				}
//			}
//		}
//		for(int i_1 = numAlive; i_1 < this.size; i_1++){
//			this.elementData[i_1] = null;
//		}
//		size = numAlive;
//	}
//
//	public final void event_modify_4(Transaction i) {
//		int numAlive = 0 ;
//		for(int i_1 = 0; i_1 < this.size; i_1++){
//			TransactionMonitor monitor = (TransactionMonitor)this.elementData[i_1];
//			if(!monitor.MOP_terminated){
//				elementData[numAlive] = monitor;
//				numAlive++;
//
//				monitor.Prop_1_event_modify_4(i);
//				if(monitor.Prop_1_Category_fail) {
//					monitor.Prop_1_handler_fail(i);
//				}
//			}
//		}
//		for(int i_1 = numAlive; i_1 < this.size; i_1++){
//			this.elementData[i_1] = null;
//		}
//		size = numAlive;
//	}
//}
//
//class TransactionMonitor extends javamoprt.MOPMonitor implements Cloneable, javamoprt.MOPObject {
//	public Object clone() {
//		try {
//			TransactionMonitor ret = (TransactionMonitor) super.clone();
//			return ret;
//		}
//		catch (CloneNotSupportedException e) {
//			throw new InternalError(e.toString());
//		}
//	}
//
//	int Prop_1_state;
//	static final int Prop_1_transition_commit[] = {2, 0, 2};;
//	static final int Prop_1_transition_start[] = {1, 2, 2};;
//	static final int Prop_1_transition_modify[] = {2, 1, 2};;
//
//	boolean Prop_1_Category_fail = false;
//
//	public TransactionMonitor () {
//		Prop_1_state = 0;
//
//	}
//
//	public final void Prop_1_event_commit(Transaction i) {
//		MOP_lastevent = 0;
//
//		Prop_1_state = Prop_1_transition_commit[Prop_1_state];
//		Prop_1_Category_fail = Prop_1_state == 2;
//	}
//
//	public final void Prop_1_event_start(Transaction i) {
//		MOP_lastevent = 1;
//
//		Prop_1_state = Prop_1_transition_start[Prop_1_state];
//		Prop_1_Category_fail = Prop_1_state == 2;
//	}
//
//	public final void Prop_1_event_modify_3(Transaction i) {
//		MOP_lastevent = 2;
//
//		Prop_1_state = Prop_1_transition_modify[Prop_1_state];
//		Prop_1_Category_fail = Prop_1_state == 2;
//	}
//
//	public final void Prop_1_event_modify_4(Transaction i) {
//		MOP_lastevent = 3;
//
//		Prop_1_state = Prop_1_transition_modify[Prop_1_state];
//		Prop_1_Category_fail = Prop_1_state == 2;
//	}
//
//	public final void Prop_1_handler_fail (Transaction i){
//		{
//			System.err.println("! hasNext() has not been called" + " before calling next() for an" + " iterator");
//			this.reset();
//		}
//
//	}
//
//	public final void reset() {
//		MOP_lastevent = -1;
//		Prop_1_state = 0;
//		Prop_1_Category_fail = false;
//	}
//
//	public javamoprt.ref.MOPWeakReference MOPRef_i;
//
//	//alive_parameters_0 = [Transaction i]
//	public boolean alive_parameters_0 = true;
//
//	public final void endObject(int idnum){
//		switch(idnum){
//			case 0:
//			alive_parameters_0 = false;
//			break;
//		}
//		switch(MOP_lastevent) {
//			case -1:
//			return;
//			case 0:
//			//commit
//			//alive_i
//			if(!(alive_parameters_0)){
//				MOP_terminated = true;
//				return;
//			}
//			break;
//
//			case 1:
//			//start
//			//alive_i
//			if(!(alive_parameters_0)){
//				MOP_terminated = true;
//				return;
//			}
//			break;
//
//			case 2:
//			//modify
//			//alive_i
//			if(!(alive_parameters_0)){
//				MOP_terminated = true;
//				return;
//			}
//			break;
//
//			case 3:
//			//modify
//			//alive_i
//			if(!(alive_parameters_0)){
//				MOP_terminated = true;
//				return;
//			}
//			break;
//
//		}
//		return;
//	}
//
//}
//
//public aspect TransactionVerifier implements javamoprt.MOPObject {
//	javamoprt.map.MOPMapManager WebTestMapManager;
//	public TransactionVerifier(){
//		WebTestMapManager = new javamoprt.map.MOPMapManager();
//		WebTestMapManager.start();
//	}
//
//	// Declarations for the Lock
//	static Object WebTest_MOPLock = new Object();
//
//	static boolean Transaction_activated = false;
//
//	// Declarations for Indexing Trees
//	static javamoprt.map.MOPBasicRefMapOfMonitor Transaction_i_Map = new javamoprt.map.MOPBasicRefMapOfMonitor(0);
//	static javamoprt.ref.MOPWeakReference Transaction_i_Map_cachekey_0 = javamoprt.map.MOPBasicRefMapOfMonitor.NULRef;
//	static TransactionMonitor Transaction_i_Map_cachenode = null;
//
//	// Trees for References
//	static javamoprt.map.MOPRefMap WebTest_Iterator_RefMap = Transaction_i_Map;
//
//	pointcut MOP_CommonPointCut() : !within(javamoprt.MOPObject+) && !adviceexecution();
//	pointcut Transaction_commit(Transaction i) : (call(* Transaction.commit()) && target(i)) && MOP_CommonPointCut();
//	before (Transaction i) : Transaction_commit(i) {
//		Transaction_activated = true;
//		synchronized(WebTest_MOPLock) {
//			TransactionMonitor mainMonitor = null;
//			javamoprt.map.MOPMap mainMap = null;
//			javamoprt.ref.MOPWeakReference TempRef_i;
//
//			// Cache Retrieval
//			if (i == Transaction_i_Map_cachekey_0.get()) {
//				TempRef_i = Transaction_i_Map_cachekey_0;
//
//				mainMonitor = Transaction_i_Map_cachenode;
//			} else {
//				TempRef_i = Transaction_i_Map.getRef(i);
//			}
//
//			if (mainMonitor == null) {
//				mainMap = Transaction_i_Map;
//				mainMonitor = (TransactionMonitor)mainMap.getNode(TempRef_i);
//
//				if (mainMonitor == null) {
//					mainMonitor = new TransactionMonitor();
//
//					mainMonitor.MOPRef_i = TempRef_i;
//
//					Transaction_i_Map.putNode(TempRef_i, mainMonitor);
//				}
//
//				Transaction_i_Map_cachekey_0 = TempRef_i;
//				Transaction_i_Map_cachenode = mainMonitor;
//			}
//
//			mainMonitor.Prop_1_event_commit(i);
//			if(mainMonitor.Prop_1_Category_fail) {
//				mainMonitor.Prop_1_handler_fail(i);
//			}
//		}
//	}
//
//	pointcut Transaction_start(Transaction i) : (call(* Transaction.start()) && target(i)) && MOP_CommonPointCut();
//	before (Transaction i) : Transaction_start(i) {
//		Transaction_activated = true;
//		synchronized(WebTest_MOPLock) {
//			TransactionMonitor mainMonitor = null;
//			javamoprt.map.MOPMap mainMap = null;
//			javamoprt.ref.MOPWeakReference TempRef_i;
//
//			// Cache Retrieval
//			if (i == Transaction_i_Map_cachekey_0.get()) {
//				TempRef_i = Transaction_i_Map_cachekey_0;
//
//				mainMonitor = Transaction_i_Map_cachenode;
//			} else {
//				TempRef_i = Transaction_i_Map.getRef(i);
//			}
//
//			if (mainMonitor == null) {
//				mainMap = Transaction_i_Map;
//				mainMonitor = (TransactionMonitor)mainMap.getNode(TempRef_i);
//
//				if (mainMonitor == null) {
//					mainMonitor = new TransactionMonitor();
//
//					mainMonitor.MOPRef_i = TempRef_i;
//
//					Transaction_i_Map.putNode(TempRef_i, mainMonitor);
//				}
//
//				Transaction_i_Map_cachekey_0 = TempRef_i;
//				Transaction_i_Map_cachenode = mainMonitor;
//			}
//
//			mainMonitor.Prop_1_event_start(i);
//			if(mainMonitor.Prop_1_Category_fail) {
//				mainMonitor.Prop_1_handler_fail(i);
//			}
//		}
//	}
//
//	pointcut Transaction_modify_3(Transaction i) : (call(* Transaction.modify()) && target(i)) && MOP_CommonPointCut();
//	before (Transaction i) : Transaction_modify_3(i) {
//		Transaction_activated = true;
//		synchronized(WebTest_MOPLock) {
//			TransactionMonitor mainMonitor = null;
//			javamoprt.map.MOPMap mainMap = null;
//			javamoprt.ref.MOPWeakReference TempRef_i;
//
//			// Cache Retrieval
//			if (i == Transaction_i_Map_cachekey_0.get()) {
//				TempRef_i = Transaction_i_Map_cachekey_0;
//
//				mainMonitor = Transaction_i_Map_cachenode;
//			} else {
//				TempRef_i = Transaction_i_Map.getRef(i);
//			}
//
//			if (mainMonitor == null) {
//				mainMap = Transaction_i_Map;
//				mainMonitor = (TransactionMonitor)mainMap.getNode(TempRef_i);
//
//				if (mainMonitor == null) {
//					mainMonitor = new TransactionMonitor();
//
//					mainMonitor.MOPRef_i = TempRef_i;
//
//					Transaction_i_Map.putNode(TempRef_i, mainMonitor);
//				}
//
//				Transaction_i_Map_cachekey_0 = TempRef_i;
//				Transaction_i_Map_cachenode = mainMonitor;
//			}
//
//			mainMonitor.Prop_1_event_modify_3(i);
//			if(mainMonitor.Prop_1_Category_fail) {
//				mainMonitor.Prop_1_handler_fail(i);
//			}
//		}
//	}
//
//	pointcut Transaction_modify_4(Transaction i) : (call(* Transaction.modify()) && target(i)) && MOP_CommonPointCut();
//	after (Transaction i) : Transaction_modify_4(i) {
//		Transaction_activated = true;
//		synchronized(WebTest_MOPLock) {
//			TransactionMonitor mainMonitor = null;
//			javamoprt.map.MOPMap mainMap = null;
//			javamoprt.ref.MOPWeakReference TempRef_i;
//
//			// Cache Retrieval
//			if (i == Transaction_i_Map_cachekey_0.get()) {
//				TempRef_i = Transaction_i_Map_cachekey_0;
//
//				mainMonitor = Transaction_i_Map_cachenode;
//			} else {
//				TempRef_i = Transaction_i_Map.getRef(i);
//			}
//
//			if (mainMonitor == null) {
//				mainMap = Transaction_i_Map;
//				mainMonitor = (TransactionMonitor)mainMap.getNode(TempRef_i);
//
//				if (mainMonitor == null) {
//					mainMonitor = new TransactionMonitor();
//
//					mainMonitor.MOPRef_i = TempRef_i;
//
//					Transaction_i_Map.putNode(TempRef_i, mainMonitor);
//				}
//
//				Transaction_i_Map_cachekey_0 = TempRef_i;
//				Transaction_i_Map_cachenode = mainMonitor;
//			}
//
//			mainMonitor.Prop_1_event_modify_4(i);
//			if(mainMonitor.Prop_1_Category_fail) {
//				mainMonitor.Prop_1_handler_fail(i);
//			}
//		}
//	}
//
//}
