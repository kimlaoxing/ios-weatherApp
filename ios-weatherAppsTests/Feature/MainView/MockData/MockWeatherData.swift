import Foundation
import ios_weatherApps

final class MockWeatherData {
    static func getMockResponse() -> WeatherResponse? {
        let jsonData = """
        {
            "lat": -6.9222,
            "lon": 107.6069,
            "timezone": "Asia/Jakarta",
            "timezone_offset": 25200,
            "current": {
                "dt": 1695540069,
                "sunrise": 1695508705,
                "sunset": 1695552319,
                "temp": 303.19,
                "feels_like": 303.95,
                "pressure": 930,
                "humidity": 48,
                "dew_point": 290.98,
                "uvi": 9.58,
                "clouds": 8,
                "visibility": 10000,
                "wind_speed": 0.89,
                "wind_deg": 65,
                "wind_gust": 1.79,
                "weather": [
                    {
                        "id": 800,
                        "main": "Clear",
                        "description": "clear sky",
                        "icon": "01d"
                    }
                ]
            },
            "hourly": [],
            "daily": []
        }
        """.data(using: .utf8)!
        let decoder = JSONDecoder()
        do {
            let results = try decoder.decode(WeatherResponse.self, from: jsonData)
            return results
        } catch {
            print("Error creating mock weatherResponse")
            return nil
        }
    }
    
    static func mockWeatherResults() -> WeatherResult? {
        let weatherResult = WeatherResult(
            id: UUID(),
            temp: 303.19,
            city: "Jakarta",
            lat: -6.9222,
            lon: 107.6069,
            hourly: [],
            daily: [],
            icon: "01d"
        )
        return weatherResult
    }
}
