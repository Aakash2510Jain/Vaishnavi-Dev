({
    doInit : function(component, event, helper) {
        debugger;
        
      /*  component.set("v.leadColumns",[ 
            {label:'Name', fieldName: 'linkName', type: 'url',
             typeAttributes: {label: { fieldName: 'Name__c' }, target: '_blank'}},
            {label:'Phone', fieldName: 'Phone__c', type:'phone'},
            {label:'Email', fieldName: 'Email__c', type:'email'},
            {label:'Lead Source', fieldName: 'Lead_Source__c', type:'text'},
        ]);   */
            
            var action = component.get("c.fetchLeadRecords");
            var recId = component.get("v.recordId");
            
            action.setParams({
            "recordId" : recId
            });
            
            action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
            component.set("v.LeadList", response.getReturnValue());
            }
            }
            );
            $A.enqueueAction(action);
            },
            
            })