public with sharing class MailgunServiceQueueable implements Queueable, Database.AllowsCallouts {
    public List<Id> contactIds;
    public MailgunServiceQueueable(List<Id> contactList) {
        this.contactIds = contactList;
    }
    public void execute(QueueableContext qc) {
        try {
            List<Contact> conList = [SELECT Id , Email, CreatedBy.Name, CreatedDate, Name FROM Contact WHERE Id IN : contactIds];
            if(!conList.isEmpty()) {
                MailgunServiceHelper.getMailDetails(conList);
            }
        } catch (Exception e) {
            System.debug('Exception: ' + e.getMessage());
        }
    }


}