public with sharing class MapIntegrationClasses {
    public static void mapClass() {
        // WebStore query values
String webstoreName = 'India Store';

// ApexClass query values
String apexClassname = 'B2BPricingSample';
String status = 'Active';
Double ApiVersion = 60.0;

// RegisteredExternalService insert values
String registeredProviderType = 'Price';
String registeredDevName = 'COMPUTE_PRICE';
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
RegisteredExternalService registeredExternalService = Database.query('SELECT Id FROM RegisteredExternalService WHERE ExternalServiceProviderId=:apexClassId AND DeveloperName=:registeredDevName AND ExternalServiceProviderType=:registeredProviderType LIMIT 1');
String registeredIntegrationId = registeredExternalService.Id;
System.debug('apex registration:' + registeredIntegrationId);

// locate and map in StoreIntegratedService
try {
  StoreIntegratedService registeredMappingObj = Database.query('SELECT Id FROM StoreIntegratedService WHERE Integration=:prefixedName AND ServiceProviderType=:prefix AND StoreId=:webStoreId LIMIT 1');
  System.debug('registered class mapping: FOUND ' + registeredMappingObj);
  // delete registeredMappingObj; // optionally remove if needed

} catch (QueryException q) {
  System.debug('registered class mapping: MISSING ' + prefixedName);
  insert new StoreIntegratedService(Integration = prefixedName, ServiceProviderType = prefix, StoreId = webStoreId);
  StoreIntegratedService registeredMappingObj = Database.query('SELECT Id FROM StoreIntegratedService WHERE Integration=:prefixedName AND ServiceProviderType=:prefix AND StoreId=:webStoreId LIMIT 1');
  System.debug('registered class mapping: INSERTED ' + registeredMappingObj);
}
    }
}