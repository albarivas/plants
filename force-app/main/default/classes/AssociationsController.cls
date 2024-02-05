public with sharing class AssociationsController {
    @AuraEnabled(cacheable=true)
    public static List<AssociationInfo> getAssociationsInfo(List<Id> speciesIds){
        try {
            Set<Id> speciesIdsSet = new Set<Id>(speciesIds);
            Map<Id,Set<Id>> goodAssocs = AssociationsService.findPartners(speciesIdsSet, 'Buena');
            Map<Id,Set<Id>> badAssocs = AssociationsService.findPartners(speciesIdsSet, 'Mala');

            List<AssociationInfo> assocInfos = new List<AssociationInfo>();
            for (Id speciesId : speciesIdsSet) {
                AssociationInfo assocInfo = new AssociationInfo();
                assocInfo.speciesId = speciesId;
                assocInfo.goodPartners = new List<Id>(goodAssocs.get(speciesId));
                assocInfo.badPartners = new List<Id>(badAssocs.get(speciesId));
                assocInfos.add(assocInfo);
            }
            return assocInfos;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public class AssociationInfo {
        @AuraEnabled
        public Id speciesId;
        @AuraEnabled
        public List<Id> goodPartners;
        @AuraEnabled
        public List<Id> badPartners;
    }
}