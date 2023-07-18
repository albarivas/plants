@isTest
private with sharing class PlantListProcessingControllerTest {
  @isTest
  static void constructor_setsPlantIds() {
    // GIVEN
    new TestDataFactory().createSpecies();
    List<Plant__c> plants = [SELECT Id FROM Plant__c];

    Test.setCurrentPage(Page.plantListProcessingWrapper);
    ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(
      plants
    );
    stdSetController.setSelected(plants);

    // WHEN
    PlantListProcessingController controller = new PlantListProcessingController(
      stdSetController
    );

    // THEN
    Assert.areEqual(2, controller.plantIds.size());
  }
}
