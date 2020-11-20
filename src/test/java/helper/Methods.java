package helper;

public class Methods {

    Data data = new Data();

    public String printScenario(String scenario) {
        String print;
        print = "\n\n               ****************  Scenario: " + scenario + " ****************";
        return print;
    }

    public String getResponseTitle(String scenario) {
        String response;
        response = "\n\n               ****************  The response for scenario "+
                   "\""+ scenario +"\" was: ****************\n";
        return response;
    }

    public String getResponseNotFound() {
        return data.responseNotFound;
    }

    public String getResponseRecordDeleted() {
        return data.responseRecordDeleted;
    }


}
