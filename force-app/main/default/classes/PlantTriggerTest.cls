@isTest
private with sharing class PlantTriggerTest {
  @isTest
  static void insertPlant_lastWateredSetup_nextWateringDateCalculatedCorrectly() {
    // GIVEN
    Species__c poto = new Species__c();
    poto.Winter_Watering_Frequency__c = 'Every other week';
    poto.Summer_Watering_Frequency__c = 'Every other week';
    insert poto;

    Plant__c plant1 = new Plant__c();
    plant1.Last_Fertilized__c = System.today();
    plant1.Last_Watered__c = System.today();
    plant1.Species__c = poto.Id;

    // WHEN
    Test.startTest();
    insert plant1;
    Test.stopTest();

    // THEN
    plant1 = [SELECT Next_Water__c FROM Plant__c WHERE Id = :plant1.Id];
    System.assertEquals(System.today() + 15, plant1.Next_Water__c);
  }

  @isTest
  static void updatePlant_lastWateredSetup_nextWateringDateCalculatedCorrectly() {
    // GIVEN
    Species__c poto = new Species__c();
    poto.Winter_Watering_Frequency__c = 'Every other week';
    poto.Summer_Watering_Frequency__c = 'Every other week';
    insert poto;

    Plant__c plant1 = new Plant__c();
    plant1.Last_Fertilized__c = System.today() - 15;
    plant1.Last_Watered__c = System.today() - 15;
    plant1.Species__c = poto.Id;
    insert plant1;

    // THEN
    plant1 = [SELECT Next_Water__c FROM Plant__c WHERE Id = :plant1.Id];
    System.assertEquals(System.today(), plant1.Next_Water__c);

    plant1.Last_Watered__c = System.today();

    // WHEN
    Test.startTest();
    update plant1;
    Test.stopTest();

    // THEN
    plant1 = [SELECT Next_Water__c FROM Plant__c WHERE Id = :plant1.Id];
    System.assertEquals(System.today() + 15, plant1.Next_Water__c);
  }
}
