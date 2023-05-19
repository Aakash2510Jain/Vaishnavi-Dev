public class LeadController {
	@AuraEnabled
    public static list<Lead__c> fetchLeadRecords(String recordId){
        System.debug('Record ID in Apex:'+recordId);
        return [Select Id,Name__c,Phone__c,Email__c,Lead_Source__c From Lead__c Where Id =: recordId];
        
        
    }
}