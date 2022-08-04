public with sharing class SpeciesService {
  @AuraEnabled(cacheable=true)
  public static List<Species__c> getFilteredSpecies(String searchText) {
    String likeValue = '%' + searchText + '%';

    return [
      SELECT Id, Name, Description__c, Image_URL__c, Location__c
      FROM Species__c
      WHERE Name LIKE :likeValue
      WITH SECURITY_ENFORCED
      ORDER BY Name
    ];
  }

  @AuraEnabled(cacheable=true)
  public static List<Species__c> getSpeciesWithPlants() {
    return [
      SELECT Name, (SELECT Name FROM Plants__r)
      FROM Species__c
      WITH SECURITY_ENFORCED
      ORDER BY Name
    ];
  }
}
