trigger LeadTrigger on Lead__c (before insert) {
 SObject_Trigger_Control__mdt triggerConfig = SObject_Trigger_Control__mdt.getInstance('Lead');
    system.debug('triggerConfig:: ' + triggerConfig);
    
    if (triggerConfig != null && triggerConfig.Trigger_Status__c){
        LeadTriggerHandler handlerInstance = LeadTriggerHandler.getInstance();
        
        if(trigger.isBefore && trigger.isInsert){
            
        }
        if(trigger.isAfter && trigger.isInsert){
            handlerInstance.afteInsert(trigger.newMap, trigger.oldMap);
        }
    }
}