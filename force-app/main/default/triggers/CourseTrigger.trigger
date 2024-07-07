trigger CourseTrigger on Course__c (after insert, after delete, after update) {
    switch on trigger.operationType {
        when AFTER_INSERT {
            CourseTriggerHandler.afterInsert(trigger.new);
        }
        when AFTER_DELETE {
            CourseTriggerHandler.afterDelete(trigger.old);
        }
        when AFTER_UPDATE {
            CourseTriggerHandler.afterUpdate(trigger.new, trigger.oldMap);
        }
    }
}