public class DeleteDuplicateLeads {
    public static void deleteLeads(){
        Set<Id> parentLeadIds = new Set<Id>();
        List<Task> taskListToInsert = new List<Task>();
        List<Lead__c> parentLeadsList = new List<Lead__c>();
        Map<Id, Lead__C> parentLeadIdByLeadRec = new Map<Id, Lead__C>();
        Map<Id, Lead__c> existingLeadsToBeDeletedMap = new Map<Id, Lead__c>([select Id,Email__c,Phone__c,ParentLeadID__c,ownerId,Lead_Source__c,Lead_Source_Type__c,Lead_Sub_Source__c from Lead__c where To_Be_Deleted__c = true limit 10000]);

        if(!existingLeadsToBeDeletedMap.isEmpty()){
            for(Lead__c leadRec : existingLeadsToBeDeletedMap.values()){
                if(leadRec.ParentLeadID__c != null){
                    parentLeadIds.add(leadRec.ParentLeadID__c);
                }
            }
            if(!parentLeadIds.isEmpty()){
                parentLeadsList = [Select Id From Lead__c where Id in : parentLeadIds];
                if(!parentLeadsList.isEmpty()){
                    for(Lead__c leadRec : parentLeadsList){
                        Task taskRecToInsert = new Task();
                        taskRecToInsert.Subject  = ConstantClass.TaskSubjectForDuplicateLead;
                        taskRecToInsert.WhatId  = leadRec.Id;
                        taskRecToInsert.Lead_Source__c = existingLeadsToBeDeletedMap.get(leadRec.Id).Lead_Source__c;
                        taskRecToInsert.Lead_Source_Type__c = existingLeadsToBeDeletedMap.get(leadRec.Id).Lead_Source_Type__c;
                        taskRecToInsert.Lead_Sub_Source__c = existingLeadsToBeDeletedMap.get(leadRec.Id).Lead_Sub_Source__c;
                        taskListToInsert.add(taskRecToInsert);
                    }
                    if(!taskListToInsert.isEmpty()){
                        insert taskListToInsert;
                    }
                }
            }
            delete existingLeadsToBeDeletedMap.values();
        }
    }
}