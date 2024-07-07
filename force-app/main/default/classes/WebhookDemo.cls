@RestResource(urlMapping='/api/webhook/pushDetails/*')
global with sharing class WebhookDemo {
    @HttpPost
    global static void handleNotification() {
        try {
            RestRequest req = RestContext.request;
            RestResponse res = RestContext.response;
        } catch (Exception e) {
            system.debug('Exception: ' + e.getMessage());
        }
    }
}