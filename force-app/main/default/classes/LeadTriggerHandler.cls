/**
 * @author Aakash Jain
 * @email aakash.jain@utilitarianlab.com
 * @create date 20-05-2023 18:13:59
 * @modify date 20-05-2023 18:13:59
 * @desc [description]
 */
public class LeadTriggerHandler {
    static LeadTriggerHandler handlerInstance;
    
    public static LeadTriggerHandler getInstance(){
        if (handlerInstance == null)
            handlerInstance = new LeadTriggerHandler();
        return handlerInstance;
    }
    public void beforeInsert(List<Lead__c> newLeadList){
        Set<String> phonesSet = new Set<String>();
        Set<String> emailsSet = new Set<String>();
        List<Lead__c> existingLeadWithPhones = new List<Lead__c>();
        List<Lead__c> existingLeadWithEmails = new List<Lead__c>();
        Map<String,Lead__c> leadRecByPhoneMap = new Map<String, Lead__c>();
        Map<String,Lead__c> leadRecByEmailMap = new Map<String, Lead__c>();
        
        for(Lead__c leadRec : newLeadList){
            if(leadRec.Phone__c != null){
                leadRec.Phone__c = '+91'+leadRec.Phone__c;
                phonesSet.add(leadRec.Phone__c);
            }
            if(leadRec.Email__c != null)
            {
                emailsSet.add(leadRec.Email__c);
            }
        }
        if(!phonesSet.isEmpty()){
            existingLeadWithPhones = [Select Id,Phone__c From Lead__c where Phone__c LIKE : phonesSet];
            if(!existingLeadWithPhones.isEmpty()){
                for(Lead__c leadRec : existingLeadWithPhones){
                    leadRecByPhoneMap.put(leadRec.Phone__c, leadRec);
                }
                if(!leadRecByPhoneMap.isEmpty()){
                    for(Lead__c leadRec : newLeadList){
                        if(leadRecByPhoneMap.containsKey(leadRec.Phone__c)){
                            leadRec.To_Be_Deleted__c = true;
                            leadRec.ParentLeadID__c = leadRecByPhoneMap.get(leadRec.Phone__c).Id;
                        }
                    }
                }
            }
        }
        if(!emailsSet.isEmpty()){
            existingLeadWithEmails = [Select Id,Email__c From Lead__c where Email__c In : emailsSet];
            if(!existingLeadWithEmails.isEmpty()){
                for(Lead__c leadRec : existingLeadWithEmails){
                    leadRecByEmailMap.put(leadRec.Email__c, leadRec);
                }
                if(!leadRecByEmailMap.isEmpty()){
                    for(Lead__c leadRec : newLeadList){
                        if(leadRecByEmailMap.containsKey(leadRec.Email__c)){
                            leadRec.To_Be_Deleted__c = true;
                            leadRec.ParentLeadID__c = leadRecByEmailMap.get(leadRec.Email__c).Id;
                        }
                    }
                }
            }
        }
    }

    public void afteInsert(Map<Id, Lead__c> newLeadMap, Map<Id, Lead__c> oldLeadMap){
        boolean isDuplicateLeadexists = false;
        
        for(Lead__c leadRec : newLeadMap.values()){
            if(leadRec.To_Be_Deleted__c){
                isDuplicateLeadexists = true;
            }
        }
        if(isDuplicateLeadexists){
            DeleteDuplicateLeads.deleteLeads();
        }
    }
}