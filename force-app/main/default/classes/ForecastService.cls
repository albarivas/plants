public inherited sharing class ForecastService {
  @future(callout=true)
  public static void postNotifications() {
    // Realizar las tares que queremos planificar
    // 1. Mirar que temperatura va a hacer hoy
    Forecast fc = ForecastService.getTodaysTemperatures();
    Integer maxTempToday = fc.temperaturas.max;
    Integer minTempToday = fc.temperaturas.min;

    // 2. Mirar si tengo alguna planta para la cual la tª no sea adecuada
    // Traerme las plantas cuya especie soporta temp max y min fuera del rango de la temp de hoy
    List<Plant__c> plantsWithProblems = [
      SELECT
        Name,
        Species__r.Name,
        Species__r.Max_Temperature__c,
        Species__r.Min_Temperature__c
      FROM Plant__c
      WHERE
        Species__c IN (
          SELECT Id
          FROM Species__c
          WHERE
            Max_Temperature__c < :maxTempToday
            OR Min_Temperature__c > :minTempToday
        )
      WITH SECURITY_ENFORCED
    ];

    // Get the Id for our custom notification type
    List<CustomNotificationType> notificationTypes = [
      SELECT Id, DeveloperName
      FROM CustomNotificationType
      WHERE DeveloperName = 'Temperature_Alert'
      WITH SECURITY_ENFORCED
    ];

    // 3. Si encuentro alguna, mandar notificación
    for (Plant__c plantWithProblems : plantsWithProblems) {
      // Only send notification if custom notification type is defined
      if (!notificationTypes.isEmpty()) {
        // Create a new custom notification
        Messaging.CustomNotification notification = new Messaging.CustomNotification();

        setNotificationMessage(
          notification,
          maxTempToday,
          minTempToday,
          plantWithProblems
        );

        // Set the notification type and target
        notification.setNotificationTypeId(notificationTypes[0].Id);
        notification.setTargetId(plantWithProblems.Id);

        // Actually send the notification
        CustomNotificationsService.send(notification);
      }

      // Send a platform event
      Plant_with_Problem__e plantWithProblemEvent = new Plant_with_Problem__e(
        Plant_Id__c = plantWithProblems.Id,
        Tipo_de_Alerta__c = getAlertType(
          maxTempToday,
          minTempToday,
          plantWithProblems
        )
      );

      List<Plant_with_Problem__e> plantWithProblemEvents = new List<Plant_with_Problem__e>();
      plantWithProblemEvents.add(plantWithProblemEvent);

      // Call method to publish events
      PlatformEventsService.publish(plantWithProblemEvents);
    }
  }

  private static void setNotificationMessage(
    Messaging.CustomNotification notification,
    Integer maxTempToday,
    Integer minTempToday,
    Plant__c plant
  ) {
    // Set the contents for the notification
    if (plant.Species__r.Max_Temperature__c < maxTempToday) {
      notification.setTitle('Mucho calor para tu planta!!!');
      notification.setBody(
        'Hoy el termómetro alcanzará ' +
          maxTempToday +
          ' grados.\n' +
          ' La temperatura máxima que ' +
          plant.Name +
          ' (' +
          plant.Species__r.Name +
          ') soporta es ' +
          plant.Species__r.Max_Temperature__c
      );
    } else if (plant.Species__r.Min_Temperature__c > minTempToday) {
      notification.setTitle('Mucho frío para tu planta!!!');
      notification.setBody(
        'Hoy el termómetro bajará de los ' +
          minTempToday +
          ' grados.\n' +
          ' La temperatura mínima que ' +
          plant.Name +
          ' (' +
          plant.Species__r.Name +
          ') soporta es ' +
          plant.Species__r.Max_Temperature__c
      );
    }
  }

  private static String getAlertType(
    Integer maxTempToday,
    Integer minTempToday,
    Plant__c plant
  ) {
    // Set the contents for the notification
    if (plant.Species__r.Max_Temperature__c < maxTempToday) {
      return 'calor';
    } else if (plant.Species__r.Min_Temperature__c > minTempToday) {
      return 'frio';
    }
    return 'error';
  }

  public static Forecast getTodaysTemperatures() {
    HttpRequest req = new HttpRequest();
    req.setEndpoint(
      'callout:El_tiempo/api/json/v2/provincias/18/municipios/18087'
    ); // Named credential
    req.setMethod('GET');

    Http http = new Http();
    HTTPResponse res = http.send(req);
    String body = res.getBody();

    Forecast forecast = (Forecast) JSON.deserialize(body, Forecast.class);
    return forecast;
  }

  public class Forecast {
    public Temperatures temperaturas;
  }

  public class Temperatures {
    public Integer max;
    public Integer min;
  }
}
