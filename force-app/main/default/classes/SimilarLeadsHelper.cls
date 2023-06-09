public without sharing class SimilarLeadsHelper {
    
    @AuraEnabled
    public static List<Lead__c>  getLeads( string recordId){
        system.debug('recordId==>'+recordId);
        List<Lead__c> leadListWithSimEmail = new List<Lead__c>();
        try{
            if(recordId != null){
                Lead__c ld= [Select id,Email__c from Lead__c where id=:recordId];
                if(ld.Email__c !=null){
                    leadListWithSimEmail = [Select Id,Name__c,Email__c,Phone__c,Lead_Source__c,Lead_Source_Type__c,Lead_Sub_Source__c From Lead__c where Email__c = : ld.Email__c and Id !=:  recordId];
                    return leadListWithSimEmail;
                }                
                else{
                    return null;
                }
            }   
        }catch(Exception e){
            System.debug(e.getMessage());
            System.debug(e.getLineNumber());
        }  
        return null;
    }
}