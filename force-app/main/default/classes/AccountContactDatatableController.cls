public with sharing class AccountContactDatatableController {
    @AuraEnabled(cacheable=true)
    public static List<AccountContactWrapper> getAccountContacts() {
        List<AccountContactWrapper> accountContacts = new List<AccountContactWrapper>();
        
        List<Account> accounts = [SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account];

        for (Account acc : accounts) {
            AccountContactWrapper wrapper = new AccountContactWrapper();
            wrapper.accountId = acc.Id;
            wrapper.accountName = acc.Name;
            wrapper.contactNames = new List<ContactWrapper>();
            
            for (Contact con : acc.Contacts) {
                String contactName = '<a href="/' + con.Id + '">' + con.Name + '</a>';
                wrapper.contactNames.add(new ContactWrapper(contactName));
            }
            accountContacts.add(wrapper);
        }
        
        return accountContacts;
    }

    public class AccountContactWrapper {
        @AuraEnabled public String accountId;
        @AuraEnabled public String accountName;
        @AuraEnabled public List<ContactWrapper> contactNames;
    }

    public class ContactWrapper {
        @AuraEnabled public String contactName;
        
        public ContactWrapper(String contactName) {
            this.contactName = contactName;
        }
    }
}
