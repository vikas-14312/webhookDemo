public with sharing class ContactTriggerHandler {
    public static void afterInsert(List<Contact> newList) {
        //for trigger
        List<Contact> conList = new List<Contact>();
        for(Contact con : newList){
            conList.add(con);
        }

        //List<Contact> conList = [SELECT Id , Email, CreatedBy.Name, CreatedDate, Name FROM Contact WHERE Id IN : newList];
        if(!conList.isEmpty()){
            MailgunServiceHelper.getMailDetails(conList);
        }
        //for MailgunServiceBatch
        // List<Id> contactIds = new List<Id>();
        // for(Contact con: newList) {
        //     contactIds.add(con.Id);
        // }
        // MailgunServiceBatch mgsBatch = new MailgunServiceBatch(contactIds);
        // Database.executeBatch(mgsBatch);

        //for MailgunServiceQueueable
        // List<Id> contactIds = new List<Id>();
        // for(Contact con: newList) {
        //     contactIds.add(con.Id);
        // }
        // MailgunServiceQueueable mgsQue = new MailgunServiceQueueable(contactIds);
        // Id jobId = System.enqueueJob(mgsQue);
    }
}