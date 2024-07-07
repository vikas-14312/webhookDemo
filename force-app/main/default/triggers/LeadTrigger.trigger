trigger LeadTrigger on Lead (after insert) {
    switch on trigger.operationType {
        when AFTER_INSERT {
            LeadTriggerHandler.afterInsert(trigger.new);
        }
    }
}