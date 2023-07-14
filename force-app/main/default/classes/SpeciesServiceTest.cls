@isTest
private with sharing class SpeciesServiceTest {
  @isTest
  static void getFilteredSpecies_searchTextIsAnEmptyString() {
    // GIVEN
    Integer speciesCount = 6;
    List<Species__c> speciesToInsert = new List<Species__c>();
    for (Integer i = 0; i < speciesCount; i++) {
      Species__c species = new Species__c(Name = 'Species ' + i);
      speciesToInsert.add(species);
    }
    insert speciesToInsert;

    // WHEN
    List<Species__c> returnedSpecies = SpeciesService.getFilteredSpecies('');

    // THEN
    System.assertEquals(speciesCount, returnedSpecies.size());
  }

  @isTest
  static void getSpeciesWithPlants_returnsPlantsAndSpeciesCorrectly() {
    // GIVEN
    createSpecies();

    // WHEN
    List<Species__c> returnedSpecies = SpeciesService.getSpeciesWithPlants();

    // THEN
    Assert.areEqual(1, returnedSpecies.size());
    Assert.areEqual(2, returnedSpecies[0].Plants__r.size());
  }

  @isTest
  static void createSpeciesWithPlant_createsSpeciesAndPlantCorrectly() {
    // GIVEN
    String speciesName = 'Species1';
    Date plantAcquisitionDate = System.today();

    // WHEN
    SpeciesService.createSpeciesWithPlant(speciesName, plantAcquisitionDate);

    // THEN
    List<Species__c> returnedSpecies = [SELECT Name FROM Species__c];
    List<Plant__c> returnedPlants = [SELECT Acquisition_Date__c FROM Plant__c];

    Assert.areEqual(1, returnedSpecies.size());
    Assert.areEqual(speciesName, returnedSpecies[0].Name);
    Assert.areEqual(1, returnedPlants.size());
    Assert.areEqual(
      plantAcquisitionDate,
      returnedPlants[0].Acquisition_Date__c
    );
  }

  static void createSpecies() {
    Species__c species = new Species__c(
      Name = 'Species1',
      Summer_Watering_Frequency__c = 'Daily',
      Winter_Watering_Frequency__c = 'Weekly'
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
  }
}
