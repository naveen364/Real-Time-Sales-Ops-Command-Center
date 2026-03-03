public class ParkLocator {
    public static list<String> country(String str){
        ParkService.ParksImplPort port = new ParkService.ParksImplPort();
        List<String> temp = new List<String>();
        temp = port.byCountry(str);
        System.debug('temp>>'+ temp);
        return temp;
    }
}