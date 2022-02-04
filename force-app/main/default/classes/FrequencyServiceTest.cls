@isTest
private with sharing class FrequencyServiceTest {
  @isTest
  static void getWateringDays_wateringFreqDailyAndWinter_oneDay() {
    // Mock System.today() - emular en el test en qué mes del año estoy
    DateServiceMock mock = new DateServiceMock();
    mock.monthToReturn = 1;

    DateService mockDateService = (DateService) Test.createStub(
      DateService.class,
      mock
    );

    // GIVEN - Creación de datos, escenario...
    Species__c specie = new Species__c();
    specie.Winter_Watering_Frequency__c = 'Daily';
    specie.Summer_Watering_Frequency__c = 'Weekly';

    // WHEN - llamamos al método
    Integer days = FrequencyService.getWateringDays(specie, mockDateService);

    // THEN - Chequear el resultado esperado
    Integer expectedDays = 1;
    System.assertEquals(expectedDays, days, 'Expected 1 day returned');
  }

  @isTest
  static void getWateringDays_wateringFreqDailyAndSummer_sevenDays() {
    // Mock System.today() - emular en el test en qué mes del año estoy
    DateServiceMock mock = new DateServiceMock();
    mock.monthToReturn = 8;

    DateService mockDateService = (DateService) Test.createStub(
      DateService.class,
      mock
    );

    // GIVEN - Creación de datos, escenario...
    Species__c specie = new Species__c();
    specie.Winter_Watering_Frequency__c = 'Daily';
    specie.Summer_Watering_Frequency__c = 'Weekly';

    // WHEN - llamamos al método
    Integer days = FrequencyService.getWateringDays(specie, mockDateService);

    // THEN - Chequear el resultado esperado
    Integer expectedDays = 7;
    System.assertEquals(expectedDays, days, 'Expected 7 day returned');
  }

  @isTest
  static void getWateringDays_wateringFreqTwicePerWeekAndWinter_threeDays() {
    // Mock System.today() - emular en el test en qué mes del año estoy
    DateServiceMock mock = new DateServiceMock();
    mock.monthToReturn = 1;

    DateService mockDateService = (DateService) Test.createStub(
      DateService.class,
      mock
    );

    // GIVEN - Creación de datos, escenario...
    Species__c specie = new Species__c();
    specie.Winter_Watering_Frequency__c = 'Twice per week';
    specie.Summer_Watering_Frequency__c = 'Weekly';

    // WHEN - llamamos al método
    Integer days = FrequencyService.getWateringDays(specie, mockDateService);

    // THEN - Chequear el resultado esperado
    Integer expectedDays = 3;
    System.assertEquals(expectedDays, days, 'Expected 3 days returned');
  }

  public class DateServiceMock implements System.StubProvider {
    public Integer monthToReturn;

    public Object handleMethodCall(
      Object stubbedObject,
      String stubbedMethodName,
      Type returnType,
      List<Type> listOfParamTypes,
      List<String> listOfParamNames,
      List<Object> listOfArgs
    ) {
      System.debug('Name of stubbed object: ' + stubbedObject);
      System.debug('Name of stubbed method: ' + stubbedMethodName);
      System.debug('Return type of stubbed method: ' + returnType.getName());
      for (integer i = 0; i < listOfParamNames.size(); i++) {
        System.debug('parameter name: ' + listOfParamNames.get(i));
        System.debug('  parameter type: ' + listOfParamTypes.get(i).getName());
      }
      System.debug(
        'number of parameters passed into the mocked call: ' + listOfArgs.size()
      );
      System.debug('parameter(s) sent into the mocked call: ' + listOfArgs);
      return monthToReturn;
    }
  }
}
