@isTest
public class TaskActivHandlerTest {
    
    @isTest
    public static void testCheckActive() {
        
        // Create test data
        Account acc = new Account(Name = 'Test Account',AccountNumber=Null,Active__C=False);
        Account acc1 = new Account(Name = 'Test Account56',AccountNumber= '1254874',Active__C=True);
        Account acc2 = new Account(Name = 'Test Account89',AccountNumber=null,Active__C=True);
        List<Account> accList = new List<Account>{acc1,acc,acc2};
          
                try{
                    Test.startTest();
                        insert accList;
                    Test.stopTest();
           		}catch(System.DMLexception e){
              		//system.debug(e.getDmlMessage(0));
               		//system.debug(e.getDmlFieldNames(0));
                    if(acc.AccountNumber== '125486'){
                        System.assertEquals('Please populate Account Number',e.getDmlMessage(0)); 
                    }else if(acc1.Active__c == True){
                        System.assertEquals('Please uncheck the Checkbox',e.getDmlMessage(0)); 
                    }else if(acc2.AccountNumber== null && acc2.Active__c== true){
                        System.assertEquals('Please uncheck the Checkbox',e.getDmlMessage(0));
                    }
                }
            
               			//System.assertEquals('Please populate Account Number',e.getDmlMessage(0));
        			//System.assertEquals(null, e.acc1.Active__c.getDmlMessage(0));
        			//System.assertEquals(null, acc2.AccountNumber.getErrors());
   }  
    @isTest
    public static void testcreateTask(){
       /* //testdata
        Account acc = new Account(Name = 'Test Account',AccountNumber='1236548',Active__C=False);
        insert acc;
     	// Create a new Task List
        List<Task> taskList = new List<Task>();
        taskList.add(new Task(WhatID= acc.Id,Subject = 'Task 1',Description = 'Do something',Status = 'Not Started'));
        
        
        // Insert the Task List
        insert taskList;
        system.debug(taskList); */
        // Create test data
        Account acc = new Account(Name = 'Test Account',AccountNumber='1236548',Active__C=False);
        List<Account> accList = new List<Account>{acc};
            //insert accList;
        Test.startTest();
        	insert accList;
        	//AccountTaskHandler.createTask(accList);        
        Test.stopTest();
        List<Task> Tl = [Select Subject,ActivityDate,OwnerId,WhatId,Status From Task Where Whatid= :acc.id];
        system.debug(tl);
        for(Task tk : Tl){
            system.assertequals(tk.Subject,'Review Account- 1236548');
        	system.assertequals(tk.ActivityDate,System.today()+7);
        	system.assertequals(tk.OwnerId,UserInfo.getUserId());
        	system.assertequals(tk.Status,'Not Started');
        }
    }        
        
        // Update the status of the Task List to 'Completed'
    @isTest
    public static void testcheckActiveCb(){
        Account acc = new Account(Name = 'Test Account',AccountNumber='1236548',Active__C=False);
        List<Account> accList = new List<Account>{acc};
        insert accList;
        List<Task> Tl = [Select Subject,AccountID,Description,ActivityDate,OwnerId,WhatId,Status From Task Where Whatid= :acc.id];
        system.debug(tl);   
        for(Task t : Tl) {
            t.Status = 'Completed';
            t.Description = 'Do Something';
        }
        update Tl;
		system.debug(Tl);
        // Call the method being tested 
        Test.startTest();
        	TaskActivHandler.checkActiveCb(Tl);
        Test.stopTest();
        // Verify the expected results
        Account updatedAcc = [SELECT Id, Active__c, Description FROM Account WHERE Id = :acc.Id];
        System.assertEquals(True, updatedAcc.Active__c);
        System.assertEquals('Do Something', updatedAcc.Description);
 
        }
}