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
}
