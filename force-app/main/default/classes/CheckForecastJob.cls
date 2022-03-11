// To schedule daily, run:
// String jobID = System.schedule('Temperature Check', '0 0 9 * * ?' , new CheckForecastJob());
public with sharing class CheckForecastJob implements Schedulable {
  public void execute(SchedulableContext schedulableContext) {
    // Check Forecast
    checkForecast();
  }

  public static void checkForecast() {
    ForecastService.Forecast fc = ForecastService.getForecast();
    Integer maxTempToday = fc.temperaturas.max;
    Integer minTempToday = fc.temperaturas.min;

    List<Species__c> speciesToAlert = [
      SELECT Name
      FROM Species__c
      WHERE
        Max_Temperature__c < :maxTempToday
        OR Min_Temperature__c > :minTempToday
    ];

    List<Plant__c> plantsToAlert = [
      SELECT
        Name,
        Species__r.Name,
        Species__r.Max_Temperature__c,
        Species__r.Min_Temperature__c
      FROM Plant__c
      WHERE Species__c IN :speciesToAlert
    ];

    for (Plant__c plantToAlert : plantsToAlert) {
      if (plantToAlert.Species__r.Max_Temperature__c < maxTempToday) {
        sendTooHotNotification(plantToAlert, maxTempToday);
      } else if (plantToAlert.Species__r.Min_Temperature__c > minTempToday) {
        sendTooColdNotification(plantToAlert, minTempToday);
      }
    }
  }

  private static void sendTooHotNotification(
    Plant__c plant,
    Integer maxTempToday
  ) {
    CustomNotificationType notificationType = [
      SELECT Id, DeveloperName
      FROM CustomNotificationType
      WHERE DeveloperName = 'Temperature_Alert'
    ];

    // Create a new custom notification
    Messaging.CustomNotification notification = new Messaging.CustomNotification();

    // Set the contents for the notification
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

    // Set the notification type and target
    notification.setNotificationTypeId(notificationType.Id);
    notification.setTargetId(plant.Id);

    // Actually send the notification
    try {
      notification.send(new Set<String>{ UserInfo.getUserId() });
    } catch (Exception e) {
      System.debug('Problem sending notification: ' + e.getMessage());
    }
  }

  private static void sendTooColdNotification(
    Plant__c plant,
    Integer minTempToday
  ) {
    CustomNotificationType notificationType = [
      SELECT Id, DeveloperName
      FROM CustomNotificationType
      WHERE DeveloperName = 'Temperature_Alert'
    ];

    // Create a new custom notification
    Messaging.CustomNotification notification = new Messaging.CustomNotification();

    // Set the contents for the notification
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

    // Set the notification type and target
    notification.setNotificationTypeId(notificationType.Id);
    notification.setTargetId(plant.Id);

    // Actually send the notification
    try {
      notification.send(new Set<String>{ UserInfo.getUserId() });
    } catch (Exception e) {
      System.debug('Problem sending notification: ' + e.getMessage());
    }
  }
}
