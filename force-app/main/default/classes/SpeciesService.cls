public with sharing class SpeciesService {
  @AuraEnabled(cacheable=true)
  public static List<Species__c> getFilteredSpecies(String searchText) {
    String likeValue = '%' + searchText + '%';

    List<Species__c> species = [
      SELECT Id, Name, Description__c, Image_URL__c, Location__c, Image_Name__c
      FROM Species__c
      WHERE Name LIKE :likeValue
      WITH SECURITY_ENFORCED
      ORDER BY Name
    ];

    return species;
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

  @AuraEnabled
  public static void createSpeciesWithPlant(
    String speciesName,
    Date plantAcquisitionDate
  ) {
    // Validar que los parametros no son nulos...

    // Comprobar que la especie no existe ya - SOQL

    // Crear species
    Species__c newSpecies = new Species__c();
    newSpecies.Name = speciesName;
    insert newSpecies;

    // Crear planta, asociada con esa especie
    Plant__c newPlant = new Plant__c();
    newPlant.Acquisition_Date__c = plantAcquisitionDate;
    newPlant.Species__c = newSpecies.Id;
    insert newPlant;
  }
}
