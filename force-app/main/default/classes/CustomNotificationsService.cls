public with sharing class CustomNotificationsService {
  public static List<Messaging.CustomNotification> notifications = new List<Messaging.CustomNotification>();
  public static void send(Messaging.CustomNotification notification) {
    try {
      notification.send(new Set<String>{ UserInfo.getUserId() });
      notifications.add(notification);
    } catch (Exception e) {
      System.debug('Problem sending notification: ' + e.getMessage());
    }
  }
}
