@RestResource(urlMapping='/checkForecastWithoutSharing')
global without sharing class ForecastRESTApiWithoutSharing {
  @HttpGet
  global static void doGet() {
    // RestRequest req = RestContext.request;
    // RestResponse res = RestContext.response;
    ForecastService.postNotifications();
  }
}
