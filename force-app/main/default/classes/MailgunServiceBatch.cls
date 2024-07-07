public with sharing class MailgunServiceBatch implements Database.Batchable<SObject>, Database.AllowsCallouts {

    public List<Id> contactIds;

    public MailgunServiceBatch(List<Id> conIds) {
        this.contactIds = conIds;
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id , Email, CreatedBy.Name, CreatedDate, Name FROM Contact WHERE Id IN : contactIds]);
    }

    public void execute(Database.BatchableContext bc, List<Contact> conList) {
        if(!conList.isEmpty()) {
            MailgunServiceHelper.getMailDetails(conList);
        }
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('Batch proccessing completed');
    }
}