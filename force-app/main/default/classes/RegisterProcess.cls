public with sharing class RegisterProcess {
    public static void registerClass() {
        // WebStore query values
        String webstoreName = 'India Store';
        
        // ApexClass query values
        String apexClassname = 'B2BTaxSample';
        String status = 'Active';
        Double ApiVersion = 55.0;
        
        // RegisteredExternalService insert values
        String registeredProviderType = 'Tax';
        String registeredDevName = 'COMPUTE_TAX';
        String registeredLabel = registeredDevName;
        
        // StoreIntegratedService insert values
        String devname = registeredDevName;
        String prefix = registeredProviderType;
        String prefixedName = prefix + '__' + devname;
        
        // locate webstore
        WebStore webStore = Database.query('SELECT Id FROM WebStore WHERE Name = :webstoreName LIMIT 1');
        String webStoreId = webStore.Id;
        System.debug('webStoreId:' + webStoreId);
        
        // locate apex class Id
        ApexClass apexClass = Database.query('SELECT Id FROM ApexClass WHERE Status=:status AND ApiVersion=:apiVersion AND Name=:apexClassname LIMIT 1');
        String apexClassId = apexClass.Id;
        System.debug('apexClassId:' + apexClassId);
        
        
        // locate apex in RegisteredExternalService
        String registeredIntegrationId = null;
        try {
            RegisteredExternalService registeredExternalService = Database.query('SELECT Id FROM RegisteredExternalService WHERE ExternalServiceProviderId=:apexClassId AND DeveloperName=:registeredDevName AND ExternalServiceProviderType=:registeredProviderType LIMIT 1');
            registeredIntegrationId = registeredExternalService.Id;
            System.debug('apex class registration: FOUND ' + registeredIntegrationId);
            //delete registeredExternalService; // optionally remove if needed
            
        } catch (QueryException q) {
            System.debug('apex class registration: MISSING ' + apexClassId);
            insert new RegisteredExternalService(DeveloperName = registeredDevName, MasterLabel = registeredLabel, ExternalServiceProviderId = apexClassId, ExternalServiceProviderType = registeredProviderType);
            RegisteredExternalService registeredExternalService = Database.query('SELECT Id FROM RegisteredExternalService WHERE ExternalServiceProviderId = :apexClassId  LIMIT 1');
            registeredIntegrationId = registeredExternalService.Id;
            System.debug('apex class registration: INSERTED ' + registeredIntegrationId);
        }
    }
}