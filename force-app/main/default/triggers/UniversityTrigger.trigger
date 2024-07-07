trigger UniversityTrigger on University__c (after insert, before delete) {
    switch on trigger.operationType {
        when AFTER_INSERT {
            UniversityTriggerHandler.afterInsert(trigger.new);
        }
        when BEFORE_DELETE {
            UniversityTriggerHandler.beforeDelete(trigger.old);
        }
    }
}