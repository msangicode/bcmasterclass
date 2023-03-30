codeunit 50107 "Weather API"
{
    procedure GetCurrentWeatherInfo(cityName: Text): Text
    var
        ApiUrl: Label 'http://api.weatherstack.com/current?access_key=7256d77014e33928a4db2edd71e23870&query=%1';
        CompleteURL, ResponseTxt : Text;
        TheHttpHeaders: HttpHeaders;
        TheHttpClient: HttpClient;
        TheRequest: HttpRequestMessage;
        TheResponse: HttpResponseMessage;
        TheJsonObject, TheDetailedJsonObject : JsonObject;
        CurrentDetailsJsonToken, WeatherDescriptionsToken, DisplayWeatherDescription : JsonToken;
        WeatheDescriptionsArray: JsonArray;
    begin
        TheHttpHeaders := TheHttpClient.DefaultRequestHeaders;
        CompleteURL := StrSubstNo(ApiUrl, cityName);
        TheRequest.SetRequestUri(CompleteURL);
        TheRequest.Method('Get');
        TheHttpClient.Send(TheRequest, TheResponse);
        if TheResponse.IsSuccessStatusCode then begin
            TheResponse.Content.ReadAs(ResponseTxt);
            TheJsonObject.ReadFrom(ResponseTxt);
            TheJsonObject.Get('current', CurrentDetailsJsonToken);
            TheDetailedJsonObject := CurrentDetailsJsonToken.AsObject();
            TheDetailedJsonObject.Get('weather_descriptions', WeatherDescriptionsToken);
            WeatheDescriptionsArray := WeatherDescriptionsToken.AsArray();
            WeatheDescriptionsArray.Get(0, DisplayWeatherDescription);
            exit(DisplayWeatherDescription.AsValue().AsText());
        end;

    end;

}
