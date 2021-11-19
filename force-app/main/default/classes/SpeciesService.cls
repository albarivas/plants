public with sharing class SpeciesService {
  @AuraEnabled(cacheable=true)
  public static List<Species__c> getAllSpecies() {
    return [
      SELECT Id, Name, Description__c, Image_URL__c, Location__c
      FROM Species__c
    ];
  }
}
