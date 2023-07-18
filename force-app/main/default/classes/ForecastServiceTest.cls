@isTest
private with sharing class ForecastServiceTest {
  @isTest
  static void getTodaysTemperatures_executesHTTPCalloutAndReturnsTemperatures() {
    // GIVEN
    HttpMockFactory mock = new HttpMockFactory(
      200,
      'OK',
      '{"temperaturas":{"max":25,"min":10}}',
      new Map<String, String>()
    );
    Test.setMock(HttpCalloutMock.class, mock);

    // WHEN
    Test.startTest();
    ForecastService.Forecast result = ForecastService.getTodaysTemperatures();
    Test.stopTest();

    // THEN
    Assert.areEqual(25, result.temperaturas.max);
    Assert.areEqual(10, result.temperaturas.min);
  }

  @isTest
  static void postNotifications_lowTemperature_correctPlatformEventPosted() {
    // GIVEN
    TestDataFactory factory = new TestDataFactory();
    factory.minTemperature = -5;
    factory.createSpecies();

    HttpMockFactory mock = new HttpMockFactory(
      200,
      'OK',
      '{"temperaturas":{"max":5,"min":-10}}',
      new Map<String, String>()
    );
    Test.setMock(HttpCalloutMock.class, mock);

    // WHEN
    Test.startTest();
    ForecastService.postNotifications();
    Test.stopTest();

    // THEN
    Assert.areEqual(2, PlatformEventsService.platformEvents.size());
    Assert.areEqual(
      PlatformEventsService.platformEvents[0].Tipo_de_Alerta__c,
      'frio'
    );
    Assert.areEqual(
      PlatformEventsService.platformEvents[1].Tipo_de_Alerta__c,
      'frio'
    );
  }

  @isTest
  static void postNotifications_highTemperature_correctPlatformEventPosted() {
    // GIVEN
    TestDataFactory factory = new TestDataFactory();
    factory.maxTemperature = 35;
    factory.createSpecies();

    HttpMockFactory mock = new HttpMockFactory(
      200,
      'OK',
      '{"temperaturas":{"max":40,"min":20}}',
      new Map<String, String>()
    );
    Test.setMock(HttpCalloutMock.class, mock);

    // WHEN
    Test.startTest();
    ForecastService.postNotifications();
    Test.stopTest();

    // THEN
    Assert.areEqual(2, PlatformEventsService.platformEvents.size());
    Assert.areEqual(
      PlatformEventsService.platformEvents[0].Tipo_de_Alerta__c,
      'calor'
    );
    Assert.areEqual(
      PlatformEventsService.platformEvents[1].Tipo_de_Alerta__c,
      'calor'
    );
  }

  @isTest
  static void postNotifications_goodTemperature_noPlatformEventPosted() {
    // GIVEN
    TestDataFactory factory = new TestDataFactory();
    factory.maxTemperature = 35;
    factory.minTemperature = -5;
    factory.createSpecies();

    HttpMockFactory mock = new HttpMockFactory(
      200,
      'OK',
      '{"temperaturas":{"max":25,"min":20}}',
      new Map<String, String>()
    );
    Test.setMock(HttpCalloutMock.class, mock);

    // WHEN
    Test.startTest();
    ForecastService.postNotifications();
    Test.stopTest();

    // THEN
    Assert.areEqual(0, PlatformEventsService.platformEvents.size());
  }
}
