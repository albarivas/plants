public with sharing class ForecastService {
  public static Forecast getForecast() {
    HttpRequest req = new HttpRequest();
    req.setEndpoint(
      'callout:El_tiempo/api/json/v2/provincias/18/municipios/18087'
    );
    req.setMethod('GET');

    Http http = new Http();
    HTTPResponse res = http.send(req);

    return (Forecast) JSON.deserialize(res.getBody(), Forecast.class);
  }

  public class Forecast {
    public Temperatures temperaturas;
  }

  public class Temperatures {
    public Integer max;
    public Integer min;
  }
}
