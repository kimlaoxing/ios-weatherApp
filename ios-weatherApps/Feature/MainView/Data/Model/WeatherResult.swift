import Foundation

public struct WeatherResult  {
    public let id: UUID
    public let temp: Double
    public let city: String
    public let lat: Double
    public let lon: Double
    public let hourly: [Current]
    public let daily: [Daily]
    public let icon: String
    
    public init(
        id: UUID,
        temp: Double,
        city: String,
        lat: Double,
        lon: Double,
        hourly: [Current],
        daily: [Daily],
        icon: String
    ) {
        self.id = id
        self.temp = temp
        self.city = city
        self.lat = lat
        self.lon = lon
        self.hourly = hourly
        self.daily = daily
        self.icon = icon
    }
}

// Extend WeatherResult and conform to Equatable
extension WeatherResult: Equatable {
    public static func == (lhs: WeatherResult, rhs: WeatherResult) -> Bool {
        return lhs.id == rhs.id &&
            lhs.temp == rhs.temp &&
            lhs.city == rhs.city &&
            lhs.lat == rhs.lat &&
            lhs.lon == rhs.lon &&
            lhs.hourly == rhs.hourly &&
            lhs.daily == rhs.daily &&
            lhs.icon == rhs.icon
    }
}
