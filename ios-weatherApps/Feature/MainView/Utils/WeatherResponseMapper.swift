import Foundation

public class WeatherResponseMapper {
    public static func weatherResponseToWeatherResult(with response: WeatherResponse) -> WeatherResult {
        var city: String = ""
        let components = response.timezone?.components(separatedBy: "/")
        if let lastComponent = components?.last {
            city = lastComponent
        }
        
        var result = WeatherResult(
            id: UUID(),
            temp: response.current?.temp ?? 0,
            city: city,
            lat: response.lat ?? 0,
            lon: response.lon ?? 0,
            hourly: response.hourly ?? [],
            daily: response.daily ?? [],
            icon: response.current?.weather?.first?.icon ?? ""
        )
        
        return result
    }
}
