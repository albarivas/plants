public inherited sharing class FrequencyService {
  static Map<String, Integer> daysByFrequency = new Map<String, Integer>();

  static {
    daysByFrequency.put('Daily', 1);
    daysByFrequency.put('Twice per week', 3);
    daysByFrequency.put('Weekly', 7);
    daysByFrequency.put('Every other week', 15);
    daysByFrequency.put('Monthly', 30);
    daysByFrequency.put('Every three months', 90);
    daysByFrequency.put('Not needed', 999);
  }

  static Set<Integer> summerMonths = new Set<Integer>{ 5, 6, 7, 8, 9 };

  public static Integer getWateringDays(
    Species__c specie,
    DateService dateServiceInstance
  ) {
    Integer month = dateServiceInstance.getCurrentMonth();
    if (summerMonths.contains(month)) {
      return daysByFrequency.get(specie.Summer_Watering_Frequency__c);
    } else {
      return daysByFrequency.get(specie.Winter_Watering_Frequency__c);
    }
  }
}
