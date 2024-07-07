public with sharing class AirbnbService {
    // public AirbnbService() {
    //     String url = 'https://www.airbnb.com.au/rooms/47213904';
    //     AirbnbService.fetchAirbnbProperty(url);
    // }

    public static void fetchAirbnbProperty() {
        // Http http = new Http();
        // HttpRequest request = new HttpRequest();
        // request.setEndpoint(url);
        // request.setMethod('GET');
        // request.setHeader('Accept', '*/*');
        // request.setHeader('Content-Type', 'text/html;charset=utf-8');
        // request.setHeader('Accept-Encoding', 'gzip, deflate, br');
        // request.setHeader('Connection', 'keep-alive');
        // HttpResponse response = new HttpResponse();

        // try {
        //     response = http.send(request);
        //     if(response.getStatusCode() == 200) {
        //         String responseBody = response.getBody();
        //         System.debug(responseBody);
        //     } else {
        //         System.debug('Error: ' + response.getStatusCode() + ' - ' + response.getStatus());
        //     }
        // } catch (Exception ex) {
        //     System.debug('Error: ' + ex.getMessage());
        // }
        
        StaticResource sr = [SELECT Body FROM StaticResource WHERE Name = 'airbnbJson'];
        Map<String, Object> mapOfObject = (Map<String, Object>) JSON.deserializeUntyped(sr.body.toString());
        Object obj = mapOfObject.get('niobeMinimalClientData');
        if(obj instanceOf List<Object>) {
            List<Object> listObj = (List<Object>) obj;
            System.debug(listObj[0]);
            System.debug(listObj[0] instanceof List<Object>);

            List<Object> listObj2 = (List<Object>) listObj[0];
            System.debug(listObj2[1]);
            
            Map<String, Object> dataMap = (Map<String, Object>) listObj2[1];
            String jsonString = JSON.serialize(dataMap);
            //Map<String,ANY 
            AirbnbWrapper w = (AirbnbWrapper) System.Json.deserialize(jsonString, AirbnbWrapper.class);
            // System.debug(w); 
            System.debug(w.data.presentation.stayProductDetailPage.sections.sbuiData.sectionConfiguration.root.sections[1].sectionData.title); 
            // System.debug(JSON.serializePretty(w));  
        }
    }

    
    
}