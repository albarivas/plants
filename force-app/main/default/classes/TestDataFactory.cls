@isTest
public with sharing class TestDataFactory {
  public Integer maxTemperature = 30;
  public Integer minTemperature = 0;

  public Id createSpecies() {
    Species__c species = new Species__c(
      Name = 'Species1',
      Summer_Watering_Frequency__c = 'Daily',
      Winter_Watering_Frequency__c = 'Weekly',
      Max_Temperature__c = maxTemperature,
      Min_Temperature__c = minTemperature
    );
    insert species;

    Plant__c plant1 = new Plant__c(
      Species__c = species.Id,
      Last_Watered__c = System.today(),
      Last_Fertilized__c = System.today()
    );
    insert plant1;

    Plant__c plant2 = new Plant__c(
      Species__c = species.Id,
      Last_Watered__c = System.today(),
      Last_Fertilized__c = System.today()
    );
    insert plant2;

    return species.Id;
  }
}
