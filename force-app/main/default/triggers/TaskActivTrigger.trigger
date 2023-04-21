trigger TaskActivTrigger on Task (before update) {
   System.TriggerOperation triggerEvent = trigger.operationType;
    switch on triggerEvent {
        when BEFORE_INSERT {
           
        }
        when AFTER_INSERT {
            
        }
        when BEFORE_UPDATE {
            TaskActivHandler.checkActiveCb(Trigger.new);
        }
    
    }
}