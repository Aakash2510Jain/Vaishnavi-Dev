public class LeadController {
    @AuraEnabled
    public static list<Lead__c> fetchLeadRecords(String recordId){
        System.debug('Record ID in Apex:'+recordId);
        Lead__c ldRec = [Select Id,Name__c,Phone__c,Email__c,Lead_Source__c,hrefLink__c From Lead__c Where Id =: recordId];
        
        string sString = ldRec.Name__c;
        string[] splitted = sString.split(' ');
        
        system.debug('part1:: = ' + splitted[0]);   
        system.debug('part2:: = ' + splitted[1]); 
        
        String lName = '%'+splitted[1];   
        
        list<Lead__c> leadListToReturn = [Select Id,Name__c,Phone__c,Email__c,Lead_Source__c,hrefLink__c From Lead__c Where Name__c Like: lName AND  Id !=: recordId];
        system.debug('leadListToReturn--->'+leadListToReturn);
        return  leadListToReturn;
    }
}