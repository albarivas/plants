@isTest
private with sharing class SpeciesTemperatureInvocableActionTest {
  @isTest
  static void getTemperatureWarning_lowTemperature_correctWarningReturned() {
    // GIVEN
    TestDataFactory factory = new TestDataFactory();
    factory.minTemperature = -5;
    Id speciesId = factory.createSpecies();

    HttpMockFactory mock = new HttpMockFactory(
      200,
      'OK',
      '{"temperaturas":{"max":5,"min":-10}}',
      new Map<String, String>()
    );
    Test.setMock(HttpCalloutMock.class, mock);

    // WHEN
    Test.startTest();
    List<String> messages = SpeciesTemperatureInvocableAction.getTemperatureWarning(
      new List<Id>{ speciesId }
    );
    Test.stopTest();

    // THEN
    Assert.isFalse(messages.isEmpty(), 'Expected a message');
    Assert.areEqual(
      messages[0],
      'Cuidado, hace mucho frío para las plantas de esta especie!'
    );
  }

  @isTest
  static void getTemperatureWarning_highTemperature_correctWarningReturned() {
    // GIVEN
    TestDataFactory factory = new TestDataFactory();
    factory.maxTemperature = 30;
    Id speciesId = factory.createSpecies();

    HttpMockFactory mock = new HttpMockFactory(
      200,
      'OK',
      '{"temperaturas":{"max":40,"min":20}}',
      new Map<String, String>()
    );
    Test.setMock(HttpCalloutMock.class, mock);

    // WHEN
    Test.startTest();
    List<String> messages = SpeciesTemperatureInvocableAction.getTemperatureWarning(
      new List<Id>{ speciesId }
    );
    Test.stopTest();

    // THEN
    Assert.isFalse(messages.isEmpty(), 'Expected a message');
    Assert.areEqual(
      messages[0],
      'Cuidado, hace mucho calor para las plantas de esta especie!'
    );
  }

  @isTest
  static void getTemperatureWarning_goodTemperature_correctWarningReturned() {
    // GIVEN
    TestDataFactory factory = new TestDataFactory();
    factory.maxTemperature = 35;
    factory.minTemperature = -5;
    Id speciesId = factory.createSpecies();

    HttpMockFactory mock = new HttpMockFactory(
      200,
      'OK',
      '{"temperaturas":{"max":25,"min":10}}',
      new Map<String, String>()
    );
    Test.setMock(HttpCalloutMock.class, mock);

    // WHEN
    Test.startTest();
    List<String> messages = SpeciesTemperatureInvocableAction.getTemperatureWarning(
      new List<Id>{ speciesId }
    );
    Test.stopTest();

    // THEN
    Assert.isFalse(messages.isEmpty(), 'Expected a message');
    Assert.areEqual(
      messages[0],
      'Enhorabuena! Hace una temperatura óptima para tu nueva especie'
    );
  }
}
