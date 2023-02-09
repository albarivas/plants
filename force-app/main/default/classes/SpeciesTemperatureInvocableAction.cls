public with sharing class SpeciesTemperatureInvocableAction {
    @InvocableMethod(label = 'Get Temperature Warning' description='This method calls a external API to generate a warning message')
    public static List<String> getTemperatureWarning(List<Id> speciesIds) {
        // 1. Traernos nuestra nueva especie de la base de datos
        Species__c insertedSpecies = [SELECT Max_Temperature__c, Min_Temperature__c FROM Species__c WHERE Id = :speciesIds[0]];

        // 2. Consultamos la API externa para saber la temperatura de hoy
        ForecastService.Forecast todaysForecast = ForecastService.getTodaysTemperatures();
        Integer maxTemp = todaysForecast.temperaturas.max;
        Integer minTemp = todaysForecast.temperaturas.min;

        // 3. Creamos mensaje a devolver
        String messageToReturn;
        // Si hace mucho frio
        if (insertedSpecies.Min_Temperature__c < minTemp) {
            messageToReturn = 'Cuidado, hace mucho frío para las plantas de esta especie!';
        } else if (insertedSpecies.Max_Temperature__c > maxTemp) {
            messageToReturn = 'Cuidado, hace mucho calor para las plantas de esta especie!';
        // Si hace mucho calor
        } else {
        // Temperatura óptima
            messageToReturn = 'Enhorabuena! Hace una temperatura óptima para tu nueva especie';
        }

        return new List<String>{messageToReturn};
    }
}