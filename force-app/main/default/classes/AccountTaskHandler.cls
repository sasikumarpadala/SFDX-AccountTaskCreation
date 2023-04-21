public class AccountTaskHandler {
    //check for Active Checkbox
    public static void checkIsActive(List<Account> accList){
        for(Account acc : accList){
            if(acc.Active__C == True){
                acc.Active__C.addError('Please uncheck the Checkbox');
            }
            else if(acc.AccountNumber== null){
                acc.AccountNumber.addError('Please populate Account Number');
            }
        }
    }
    // Task Creation
    public static void createTask(List<Account> accList){
        List<Task> newTaskList = new List<Task>();
        for(Account acc1 : accList){
            Task nTk = new Task();
            nTk.Subject = 'Review Account-'+' '+ acc1.AccountNumber;
            nTk.ActivityDate = System.today()+7;
            nTk.OwnerId = UserInfo.getUserId();
            nTk.WhatId= acc1.Id;
            nTk.Status = 'Not Started';
           	newTaskList.add(nTk);
        }
        insert newTaskList;
    }
}