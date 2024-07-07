trigger ContactTrigger on Contact (after insert) {
    switch on Trigger.operationType {
        when AFTER_INSERT {
            ContactTriggerHandler.afterInsert(trigger.new);
        }
    }
}