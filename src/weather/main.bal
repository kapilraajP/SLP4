import ballerina/http;
import ballerina/io;

public type Configuration record {
    string apiUrl;
    string apiID;
};

public class WClient{

    
    public string apiUrl;
    public string apiID;
    public http:Client newClient;

    function init(Configuration conf){
        self.apiUrl = conf.apiUrl;
        self.apiID  = conf.apiID;
        
        self.newClient = new (self.apiUrl);
    }

    public remote function getByCity(string? city) returns  @tainted json|error{

        http:Response? result = new;


        if city is string{
        
            result = <http:Response>self.newClient->get(string `?q=${city}&appid=${self.apiID}`);
        }else{
            
            result = ();
        }
        
        if result is http:Response{
            if (result.statusCode == 200) {

            json payload = <json>result.getJsonPayload();
            
            json[] weather = <json[]> payload.weather;
            
            return weather[0].description;

            } else {
            error err = error("Error");
            io:println(err.message(), result);
            return err;
            }
        }else{

            error err = error("NO DATA");
            return err;
        }
         
        
    }



    public remote function getByCoordinates(string lat,string lon) returns @tainted json|error{

        var response = self.newClient->get(string `?lat=${lat}&lon=${lon}&appid=${self.apiID}`);

        http:Response response1 = <http:Response>response;
            if (response1.statusCode == 200) {

                json payload = <json>response1.getJsonPayload();
                json[] weather = <json[]> payload.weather;
            
                return weather[0].description;
                
            } else {
                error err = error("Error");
                io:println(err.message(), response1);
                return err;
            }
    }

    
}

