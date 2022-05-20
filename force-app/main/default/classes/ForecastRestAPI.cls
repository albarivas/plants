@RestResource(urlMapping='/checkForecast')
global with sharing class ForecastRestAPI {
  @HttpGet
  global static void doGet() {
    // RestRequest req = RestContext.request;
    // RestResponse res = RestContext.response;
    ForecastService.postNotifications();
  }
}
