public with sharing class AssociationsService {
    public static Map<Id,Set<Id>> findPartners(Set<Id> speciesIds, String relationship) {
        List<Association__c> associations = [SELECT Species1__c, Species2__c 
                                                FROM Association__c 
                                                WHERE (Species1__c IN :speciesIds AND Relacion__c = :relationship)
                                                OR (Species2__c IN :speciesIds AND Relacion__c = :relationship)
                                                WITH USER_MODE];

        Map<Id,Set<Id>> relatedSpeciesIds = new Map<Id,Set<Id>>();
        for (Id speciesId : speciesIds) {
            relatedSpeciesIds.put(speciesId, new Set<Id>());
        }
        for(Association__c association: associations) {
            if (relatedSpeciesIds.containsKey(association.Species1__c)) {
                relatedSpeciesIds.get(association.Species1__c).add(association.Species2__c);
            }
            if (relatedSpeciesIds.containsKey(association.Species2__c)) {
                relatedSpeciesIds.get(association.Species2__c).add(association.Species1__c);
            }
        }
        return relatedSpeciesIds;
    }
}