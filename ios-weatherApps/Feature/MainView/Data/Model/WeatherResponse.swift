// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

import Foundation

// MARK: - Welcome
public struct WeatherResponse: Codable, Equatable {
    public let lat, lon: Double?
    public let timezone: String?
    public let timezoneOffset: Int?
    public let current: Current?
    public let hourly: [Current]?
    public let daily: [Daily]?

    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case current, hourly, daily
    }

    public init(lat: Double?, lon: Double?, timezone: String?, timezoneOffset: Int?, current: Current?, hourly: [Current]?, daily: [Daily]?) {
        self.lat = lat
        self.lon = lon
        self.timezone = timezone
        self.timezoneOffset = timezoneOffset
        self.current = current
        self.hourly = hourly
        self.daily = daily
    }
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Current
public struct Current: Codable, Equatable {
    public let dt, sunrise, sunset: Int?
    public let temp, feelsLike: Double?
    public let pressure, humidity: Int?
    public let dewPoint, uvi: Double?
    public let clouds, visibility: Int?
    public let windSpeed: Double?
    public let windDeg: Int?
    public let windGust: Double?
    public let weather: [Weather]?
    public let pop: Double?
    public let rain: Rain?

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, pop, rain
    }

    public init(dt: Int?, sunrise: Int?, sunset: Int?, temp: Double?, feelsLike: Double?, pressure: Int?, humidity: Int?, dewPoint: Double?, uvi: Double?, clouds: Int?, visibility: Int?, windSpeed: Double?, windDeg: Int?, windGust: Double?, weather: [Weather]?, pop: Double?, rain: Rain?) {
        self.dt = dt
        self.sunrise = sunrise
        self.sunset = sunset
        self.temp = temp
        self.feelsLike = feelsLike
        self.pressure = pressure
        self.humidity = humidity
        self.dewPoint = dewPoint
        self.uvi = uvi
        self.clouds = clouds
        self.visibility = visibility
        self.windSpeed = windSpeed
        self.windDeg = windDeg
        self.windGust = windGust
        self.weather = weather
        self.pop = pop
        self.rain = rain
    }
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Rain
public struct Rain: Codable, Equatable {
    public let the1H: Double?

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }

    public init(the1H: Double?) {
        self.the1H = the1H
    }
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Weather
public struct Weather: Codable, Equatable {
    public let id: Int?
    public let main: Main?
    public let description: Description?
    public let icon: String?

    public init(id: Int?, main: Main?, description: Description?, icon: String?) {
        self.id = id
        self.main = main
        self.description = description
        self.icon = icon
    }
}

public enum Description: String, Codable, Equatable {
    case brokenClouds = "broken clouds"
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case lightRain = "light rain"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
}

public enum Main: String, Codable, Equatable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Daily
public struct Daily: Codable, Equatable {
    public let dt, sunrise, sunset, moonrise: Int?
    public let moonset: Int?
    public let moonPhase: Double?
    public let temp: Temp?
    public let feelsLike: FeelsLike?
    public let pressure, humidity: Int?
    public let dewPoint, windSpeed: Double?
    public let windDeg: Int?
    public let windGust: Double?
    public let weather: [Weather]?
    public let clouds: Int?
    public let pop, uvi, rain: Double?

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, clouds, pop, uvi, rain
    }

    public init(dt: Int?, sunrise: Int?, sunset: Int?, moonrise: Int?, moonset: Int?, moonPhase: Double?, temp: Temp?, feelsLike: FeelsLike?, pressure: Int?, humidity: Int?, dewPoint: Double?, windSpeed: Double?, windDeg: Int?, windGust: Double?, weather: [Weather]?, clouds: Int?, pop: Double?, uvi: Double?, rain: Double?) {
        self.dt = dt
        self.sunrise = sunrise
        self.sunset = sunset
        self.moonrise = moonrise
        self.moonset = moonset
        self.moonPhase = moonPhase
        self.temp = temp
        self.feelsLike = feelsLike
        self.pressure = pressure
        self.humidity = humidity
        self.dewPoint = dewPoint
        self.windSpeed = windSpeed
        self.windDeg = windDeg
        self.windGust = windGust
        self.weather = weather
        self.clouds = clouds
        self.pop = pop
        self.uvi = uvi
        self.rain = rain
    }
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - FeelsLike
public struct FeelsLike: Codable, Equatable {
    public let day, night, eve, morn: Double?

    public init(day: Double?, night: Double?, eve: Double?, morn: Double?) {
        self.day = day
        self.night = night
        self.eve = eve
        self.morn = morn
    }
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Temp
public struct Temp: Codable, Equatable {
    public let day, min, max, night: Double?
    public let eve, morn: Double?

    public init(day: Double?, min: Double?, max: Double?, night: Double?, eve: Double?, morn: Double?) {
        self.day = day
        self.min = min
        self.max = max
        self.night = night
        self.eve = eve
        self.morn = morn
    }
}
