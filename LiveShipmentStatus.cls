/**
 * @description       : Apex class for merzCommunities reperesentative Live Shipment Tracking
 * @author            : Sumit Kumar
 * @last modified on  : 09-07-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class LiveShipmentStatus {
@AuraEnabled(cacheable=true)
public static String getStatus(String recID){
Http http = new Http();
//SOQL query on shipment record for the record ID in parameter 
List<Shipment> rec = new List<shipment> ([SELECT id ,TrackingNumber from Shipment where id =:recID AND TrackingNumber!=null LIMIT 1]);
if(rec.size()!=0){
HttpRequest request = new HttpRequest(); // Calling merzCommninities API for Shipment Live Tracking
String endpoint ='https://merzcommunities--mel.sandbox.my.salesforce-sites.com/services/apexrest/mockShipmentStatus?trackingNumber='+rec[0].TrackingNumber;
request.setEndpoint(endpoint);
request.setMethod('GET');
HttpResponse response = http.send(request);
if(response.getStatusCode() == 200) { // Checking Response Status of API
    String status=   response.getBody();
    status=status.replaceAll('"','');  
    return status;
}else{
    return 'error';
}
}else{
    return 'Error - Must provide tracking number';
}
}
}