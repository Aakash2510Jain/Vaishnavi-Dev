({
    doInit : function(component, event, helper) {
        alert("HI");
        component.set("v.leadColumns",[ 
            {label:'Name', fieldName: 'Name__c', type: 'text'},
            // typeAttributes: {label: { fieldName: 'Name__c' }, target: '_blank'}},
            {label:'Phone', fieldName: 'Phone__c', type:'phone'},
            {label:'Email', fieldName: 'Email__c', type:'email'},
            {label:'Lead Source', fieldName: 'Lead_Source__c', type:'text'},
        ]);
            var action = component.get("c.fetchLeadRecords");
            var recId = component.get("v.recordId");
            alert(recId);
            console.log("Record ID::::"+recId);
            action.setParams({
            "recordId" : recId
            });
            
            action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
            
            var Data = response.getReturnValue();
            
            var str = JSON.stringify(Data);
            alert(str);
            
            var name = str[0].Name__c;
            alert(String(name));
            
            if(name != null){
            var name1 = str.split(' ');
            alert(name);
            
            
            }
            component.set("v.LeadList", response.getReturnValue());
            }
            });
            $A.enqueueAction(action);
            }
            })