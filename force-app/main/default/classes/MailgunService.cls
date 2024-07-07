public class MailgunService {

    @InvocableMethod(label='Send Email with Mailgun' description='Sends an email with Mailgun')
    public static void getMailDetails(List<EmailRequestWrapper> requests) {
        if(!requests.isEmpty()) {
            String requestsString = JSON.serialize(requests);
            MailgunServiceHelper.sendMailFuture(requestsString);            
        }
    }
}