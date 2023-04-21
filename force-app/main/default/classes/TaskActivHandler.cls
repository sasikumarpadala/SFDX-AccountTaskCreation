public class TaskActivHandler {
    public static void checkActiveCb(List<Task> taskList){
        system.debug(taskList);
        /*Set<ID> aTids = new Set<ID>();
        for(Task tId : taskList){
            aTids.add(tId.AccountID);
        }*/
        List<Account> updatedAccount = new List<Account>();
        for(Task tk : taskList){
            if(tk.Status=='Completed'){
                Account acct = new Account();
                acct.Id = tk.AccountId;
                acct.Active__c = True;
                acct.Description = tk.Description;
                updatedAccount.add(acct);
        	}
            update updatedAccount;
        }
        
    }
}