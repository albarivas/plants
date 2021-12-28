trigger PlantTrigger on Plant__c(before insert, before update) {
  // Preload Species
  Set<Id> specieIds = new Set<Id>();
  for (Plant__c newPlant : Trigger.new) {
    specieIds.add(newPlant.Species__c);
  }
  List<Species__c> species = [
    SELECT
      Summer_Watering_Frequency__c,
      Winter_Watering_Frequency__c,
      Summer_Fertilization_Frequency__c,
      Winter_Fertilization_Frequency__c
    FROM Species__c
    WHERE Id IN :specieIds
  ];
  Map<Id, Species__c> speciesById = new Map<Id, Species__c>(species);

  // Populate Fields
  for (Plant__c newPlant : Trigger.new) {
    Plant__c oldPlant = Trigger.oldMap.get(newPlant.Id);
    // Calculate Next Water Date - if insert or update and last watered changed
    if (
      newPlant.Last_Watered__c != oldPlant.Last_Watered__c ||
      oldPlant == null
    ) {
      Species__c specie = speciesById.get(newPlant.Species__c);
      if (specie != null) {
        Integer wateringDays = FrequencyService.getWateringDays(specie);
        newPlant.Next_Water__c = newPlant.Last_Watered__c.addDays(wateringDays);
      }
    }
    // Calculate Next Fertilization Date - if insert or update and last fertilized changed
    if (
      newPlant.Last_Fertilized__c != oldPlant.Last_Fertilized__c ||
      oldPlant == null
    ) {
      Species__c specie = speciesById.get(newPlant.Species__c);
      if (specie != null) {
        Integer fertilizationDays = FrequencyService.getFertilizationDays(
          specie
        );
        newPlant.Next_Fertilization__c = newPlant.Last_Fertilized__c.addDays(
          fertilizationDays
        );
      }
    }
  }

}
