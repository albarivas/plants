public with sharing class PlatformEventsService {
  public static List<Plant_with_Problem__e> platformEvents = new List<Plant_with_Problem__e>();
  public static void publish(
    List<Plant_with_Problem__e> plantWithProblemEvents
  ) {
    List<Database.SaveResult> results = EventBus.publish(
      plantWithProblemEvents
    );
    platformEvents.addAll(plantWithProblemEvents);

    // Inspect publishing result for each event
    for (Database.SaveResult sr : results) {
      if (sr.isSuccess()) {
        System.debug('Successfully published event.');
      } else {
        for (Database.Error err : sr.getErrors()) {
          System.debug(
            'Error returned: ' + err.getStatusCode() + ' - ' + err.getMessage()
          );
        }
      }
    }
  }
}
