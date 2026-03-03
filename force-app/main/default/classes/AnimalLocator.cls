public class AnimalLocator {
    public static String getAnimalNameById(Integer ids) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+ids);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        String res  = response.getBody();
     	root rt = (root) JSON.deserialize(res, root.class);
        System.debug('rt >>>> '+rt);
        return rt.animal.Name;
    }
    
    public class root{
        public animal animal;
    }
    public class animal {
        public String name;
        public String eats;
        public String says;
    }
}
/*public class AnimalLocator {
    public static String getAnimalNameById(Integer ids) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+ids);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        String res  = response.getBody();
        System.debug('res >>> '+res);
        List<Object> animals = new List<Object>();
     	//ot rt = (root) JSON.deserialize(res, root.class);
        //stem.debug('rt >>>> '+rt);
        
        Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(res);
        system.debug('responseMap >>>> '+responseMap);
        
        Map<String, Object> animalMap = (Map<String, Object>)responseMap.get('animal');
        system.debug('animalMap >>>> '+animalMap);
        
        Object nameObj = (Object)animalMap.get('name');
        system.debug('nameObj >>>> '+nameObj);
        
        //return rt.animal.Name;
                return String.valueOf(nameObj);
    }
    
    public class root{
        public animal animal;
    }
    public class animal {
        public String name;
        public String eats;
        public String says;
    }
}*/