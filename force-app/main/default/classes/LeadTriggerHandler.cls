public with sharing class LeadTriggerHandler {
    public static void afterInsert(List<Lead> newList) {
        List<Id> leadIds = new List<Id>();
        for(Lead lead : newList) {
            leadIds.add(lead.Id);
        }
        LeadTriggerHandler.checkDuplicate(leadIds);
    }

    @future
    public static void checkDuplicate(List<Id> leadIds) {
        try{
            List<Lead> newList = [SELECT Id, FirstName, LastName, Email, MobilePhone FROM Lead WHERE Id IN :leadIds];
            List<Lead> leadsToUpdate = new List<Lead>();
            List<Lead> leadsToDelete = new List<Lead>();
            List<Lead> leadList = [SELECT Id, FirstName, LastName, Email, MobilePhone FROM Lead WHERE MobilePhone != null AND Id NOT IN :newList];
            Map<String,Lead> nameLeadMap = new Map<String,Lead>();
            Map<String,Lead> mobileLeadMap = new Map<String,Lead>();
            for(Lead lead : leadList) {
                String firstName = lead.FirstName != null ? lead.firstName : '';
                String fullName = firstName + lead.LastName;
                nameLeadMap.put(fullName, lead);           
                mobileLeadMap.put(lead.MobilePhone, lead);  
            }
            for(Lead lead : newList) {
                String firstName = lead.FirstName != null ? lead.firstName : '';
                String fullName = firstName + lead.LastName;
                // System.debug(lead);
                // System.debug('nameLeadMap'+nameLeadMap);
                // System.debug('mobileLeadMap'+mobileLeadMap);
                if(nameLeadMap.containsKey(fullName) && mobileLeadMap.containsKey(lead.MobilePhone)) {
                    Lead l = new Lead();
                    l.Id = nameLeadMap.get(fullName).Id;
                    l.Email = lead.Email;
                    leadsToUpdate.add(l);
                    Lead ld = new Lead();
                    ld.Id = lead.Id;
                    leadsToDelete.add(ld);
                    System.debug('inside if');
                }
            }
            // System.debug('leadsToDelete'+leadsToDelete);
            // System.debug('leadsToUpdate'+leadsToUpdate);
            update leadsToUpdate;
            delete leadsToDelete;

        } catch(Exception ex) {
            System.debug('Exception orrcured: '+ ex.getMessage());
        }
    }
}