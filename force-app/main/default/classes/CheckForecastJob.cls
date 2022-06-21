public with sharing class CheckForecastJob implements Schedulable {
  public void execute(SchedulableContext SC) {
    ForecastService.postNotifications();
  }
}
