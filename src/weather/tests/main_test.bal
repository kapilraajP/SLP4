import ballerina/io;
import ballerina/test;
import ballerina/log;

@test:Config{}
function testGetByCity(){
    Configuration config = {
        apiUrl: "https://api.openweathermap.org/data/2.5/weather",
        apiID: "<Insert api key here>"
    };

    WClient newClient = new(config);

    json|error result =  newClient.getByCity("Jaffna");

    log:printInfo(<anydata>result);
    //test:assertEquals() We cant use because data change with time
    if result is json{
            io:println(result);

    }else{
        test:assertFail(result.message());
    }
}


@test:Config{}
function testGetByCoordinates(){
    Configuration config = {
        apiUrl: "https://api.openweathermap.org/data/2.5/weather",
        apiID:"65bb7e290505c4f41eb3dc64c5d200fe"
    };

    WClient newclient = new(config);


    json|error result = newclient.getByCoordinates("9.66","80.02");

    if result is json{
            io:println(result);

    }else{
        test:assertFail(result.message());
    }
}

