@isTest
private with sharing class FrequencyServiceTest {
  @isTest
  static void getWateringDays_wateringFreqDailyAndWinter_oneDay() {
    // TODO: mock System.today() - emular en el test en qué mes del año estoy
    // GIVEN - Creación de datos, escenario...
    Species__c specie = new Species__c();
    specie.Winter_Watering_Frequency__c = 'Daily';

    // WHEN - llamamos al método
    Integer days = FrequencyService.getWateringDays(specie);

    // THEN - Chequear el resultado esperado
    Integer expectedDays = 1;
    System.assertEquals(expectedDays, days, 'Expected 1 day returned');
  }

  @isTest
  static void getWateringDays_wateringFreqTwicePerWeekAndWinter_threeDays() {
    // TODO: mock System.today() - emular en el test en qué mes del año estoy
    // GIVEN - Creación de datos, escenario...
    Species__c specie = new Species__c();
    specie.Winter_Watering_Frequency__c = 'Twice per week';

    // WHEN - llamamos al método
    Integer days = FrequencyService.getWateringDays(specie);

    // THEN - Chequear el resultado esperado
    Integer expectedDays = 3;
    System.assertEquals(expectedDays, days, 'Expected 3 days returned');
  }
}
