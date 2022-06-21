@RestResource(urlMapping='/checkForecastWithoutSharing')
global without sharing class ForecastRestAPI {
  @HttpGet
  global static void doGet() {
    // RestRequest req = RestContext.request;
    // RestResponse res = RestContext.response;
    ForecastService.postNotifications();
  }
}
