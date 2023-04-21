trigger AccountTaskTrigger on Account (before insert, after insert) {
   System.TriggerOperation triggerEvent = trigger.operationType;
    switch on triggerEvent {
        when BEFORE_INSERT {
            AccountTaskHandler.checkIsActive(Trigger.new);
        }
        when AFTER_INSERT {
            AccountTaskHandler.createTask(Trigger.new);
        }
        /*when AFTER_UPDATE {
            
        }*/
    
    }
}