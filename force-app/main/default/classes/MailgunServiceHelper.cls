public with sharing class MailgunServiceHelper {
    public static void getMailDetails(List<Contact> conList) {
        System.debug('conList: ' + conList);
        List<EmailRequestWrapper> requests = new List<EmailRequestWrapper>();
        for(Contact con: conList) {
            if(con.Email != null) {
                EmailRequestWrapper request = new EmailRequestWrapper();
                // String firstName = con.FirstName != null? con.FirstName:'';
                // request.body = 'New contact created: '+ firstName + ' ' + con.LastName + ' By ' + UserInfo.getName() + ' on ' + con.CreatedDate;
                // request.subject = 'Hi '+ con.FirstName + ' ' + con.LastName;
                // request.toEmail = con.Email;
                EmailTemplate emailTemplate = [SELECT Id, Subject, HtmlValue, Body FROM EmailTemplate WHERE DeveloperName = 'Contact_creation_template' AND templateType = 'custom' LIMIT 1];
                request.subject = emailTemplate.Subject.replace('{!Contact.LastName}', con.LastName);
                request.body = emailTemplate.body.replace('{!Contact.LastName}', con.LastName);
                request.toEmail = con.Email;
                requests.add(request);
            }
        }
        if(System.isBatch() || System.isQueueable()) {
            String requestsString = JSON.serialize(requests);
            MailgunServiceHelper.sendMail(requestsString);
        } else {
            String requestsString = JSON.serialize(requests);
            MailgunServiceHelper.sendMailFuture(requestsString);
        }
    }

    @future(callout=true)
    public static void sendMailFuture(String requests) {
        MailgunServiceHelper.sendMail(requests);            
    }

    public static void sendMail(String requests) {
        List<EmailRequestWrapper> requestList = (List<EmailRequestWrapper>)JSON.deserialize(requests, List<EmailRequestWrapper>.class);
        for (EmailRequestWrapper request : requestList) {
            Mailgun__mdt mailgun = Mailgun__mdt.getInstance('mailgun');
            String fromEmail = mailgun.fromEmail__c;
            System.debug(mailgun.fromEmail__c + ' ' + mailgun.named_credential__c);
            HttpRequest req = new HttpRequest();
            req.setEndpoint(mailgun.named_credential__c);
            req.setMethod('POST');
            String requestBody = 'from=' + EncodingUtil.urlEncode(fromEmail, 'UTF-8')
                                + '&to=' + EncodingUtil.urlEncode(request.toEmail, 'UTF-8')
                                + '&subject=' + EncodingUtil.urlEncode(request.subject, 'UTF-8')
                                + '&html=' + EncodingUtil.urlEncode(request.body, 'UTF-8');
            req.setBody(requestBody);

            try{
                Http http = new Http();
                HttpResponse res = http.send(req);
                System.debug(res);
                if (res.getStatusCode() == 200) {
                    System.debug(res.getBody());
                    System.debug('Email sent successfully.');
                } else {
                    System.debug('Failed to send email: ' + res.getBody());
                }
            } catch (Exception e) {
                System.debug('Error sending email: ' + e.getMessage());
            } 
        }
           
    }
}