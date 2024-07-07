trigger CollegeTrigger on College__c (after insert, after delete) {
    switch on trigger.operationType {
        when AFTER_INSERT {
            CollegeTriggerHandler.afterInsert(trigger.new);
        }
        when AFTER_DELETE {
            CollegeTriggerHandler.afterDelete(trigger.old);
        }
    }
}