trigger StaffTrigger on Staff__c (after insert, after delete, after update) {
    switch on trigger.operationType {
        when AFTER_INSERT {
            StaffTriggerHandler.afterInsert(trigger.new);
        }
        when AFTER_DELETE {
            StaffTriggerHandler.afterDelete(trigger.old);
        }
        when AFTER_UPDATE {
            StaffTriggerHandler.afterUpdate(trigger.new, trigger.oldmap);
        }
    }
}