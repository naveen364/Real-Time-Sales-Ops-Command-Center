public with sharing class WeatherApi {
@AuraEnabled
public static Weather daily(String apiKey, String location){
    try {
        String url = 'http://dataservice.accuweather.com/forecasts/v1/daily/5day/';
        String locationKey = location;
        Weather w = new Weather();
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url+locationKey+'?apikey='+apiKey+'&details=true');
        req.setHeader('Content-type', 'application/json');
        req.setMethod('GET');
        HttpResponse resp = http.send(req);
        
       String jsonBody  = resp.getBody().replaceAll('"Date":', '"Dates":');

        System.debug('type==>'+jsonBody);  
        w = (Weather)JSON.deserialize(jsonBody.replaceAll('"Set":','"Sets":'), Weather.class);
        System.debug('Weather==>'+w);
        //System.debug('location key ::5'+getlocation('oRA3eo01mWGIq1kB7Kfs9EnHhB3G0JQi','Delhi'));
        return w;
    } catch (Exception e) {
        System.debug('ee==>'+e.getMessage() + 'line::' + e.getLineNumber());
        throw new AuraHandledException(e.getMessage());
    }
}

@AuraEnabled
public static List<locationKey> getlocation(String apiKey, String state){
    
    String url = 'http://dataservice.accuweather.com/locations/v1/cities/search?apikey='+apiKey+'&q='+state;
    Http http = new Http();
    HttpRequest req = new HttpRequest();
    req.setEndpoint(url);
    req.setHeader('Content-type', 'application/json');
    req.setMethod('GET');
    HttpResponse resp = http.send(req);
    list<locationKey> lkey = new list<locationKey>();
    lkey = (list<locationKey>)JSON.deserialize(resp.getBody(), list<locationKey>.class);
    System.debug('key==>'+lkey[0].Key);
    return lkey;
}

@AuraEnabled
public static list<Hourly> getHours(String apiKey, String locationcode){
    String url = 'http://dataservice.accuweather.com/forecasts/v1/hourly/12hour/'+locationcode+'?apikey='+apiKey;
    Http http = new Http();
    HttpRequest req = new HttpRequest();
    req.setEndpoint(url);
    req.setHeader('Content-type', 'application/json');
    req.setMethod('GET');
    HttpResponse resp = http.send(req);
    list<Hourly> hourlylist = new list<Hourly>();
    hourlylist = (list<Hourly>)JSON.deserialize(resp.getBody(), list<Hourly>.class);
    System.debug('hours==>'+hourlylist[0]);
    return hourlylist;
}

public class locationKey{
    @AuraEnabled
    public String Key{set; get;}
    @AuraEnabled
    public String LocalizedName{set; get;}
}


public class Weather {
    @AuraEnabled
    public Headline Headline{set; get;}
    @AuraEnabled
    public List<DailyForecasts> DailyForecasts{set; get;}
}

public class Headline{
    @AuraEnabled
    public String Text;
    @AuraEnabled
    public String Category;
}

public class DailyForecasts{
    @AuraEnabled
    public String Dates;
    @AuraEnabled
    public Temperature Temperature;
    @AuraEnabled
    public Day Day;
    @AuraEnabled
    public Sun Sun;
    @AuraEnabled
    public Moon Moon;
    @AuraEnabled
    public Night Night;
}

public class Night{
    @AuraEnabled
    public String LongPhrase;
}

public class Sun{
    @AuraEnabled
    public String Rise;
    @AuraEnabled
    public String Sets;
}

public class Moon{
    @AuraEnabled
    public String Rise;
    @AuraEnabled
    public String Sets;
}

public class Day{
    @AuraEnabled
    public String IconPhrase;
    @AuraEnabled
    public String PrecipitationType;
    @AuraEnabled
    public Integer Icon;
    @AuraEnabled
    public Double PrecipitationProbability;
    @AuraEnabled
    public string LongPhrase;
    @AuraEnabled
    public Wind Wind;
}

public class Wind{
    @AuraEnabled
    public Speed Speed;
}

public class Speed{
    @AuraEnabled
    public String Value;
    @AuraEnabled
    public String Unit;
}

public class Temperature{
    @AuraEnabled
    public Minimum Minimum;
    @AuraEnabled
    public Maximum Maximum;
    //from hourly
    @AuraEnabled
    public Double Value;
}

public class Maximum{
    @AuraEnabled
    public Double Value;
}

public class Minimum{
    @AuraEnabled
    public Double Value;
}

public class Hourly{
    @AuraEnabled
    public Temperature Temperature;
}

}