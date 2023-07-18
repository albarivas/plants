public with sharing class PlantListProcessingController {
  public List<String> plantIds { get; set; }

  public PlantListProcessingController(
    ApexPages.StandardSetController controller
  ) {
    List<Plant__c> plantSelectedList = (List<Plant__c>) controller.getSelected();

    plantIds = new List<String>();

    for (Plant__c plantSelected : plantSelectedList) {
      plantIds.add((String) plantSelected.Id);
    }
  }
}
