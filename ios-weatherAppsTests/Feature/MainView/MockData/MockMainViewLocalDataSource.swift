import Foundation
@testable import ios_weatherApps

class MockMainViewLocalDataSource: MainViewLocalDataSourceProtocol {
    var savedWeatherResults: [WeatherResult] = []
    
    func saveWeatherResult(
        _ weatherResult: WeatherResult,
        completion: @escaping (Result<Bool, Error>) -> Void
    ) {
        savedWeatherResults.append(weatherResult)
        completion(.success(true))
    }
    
    func loadAllWeatherResults(
        completion: @escaping (Result<[WeatherResult], Error>) -> Void
    ) {
        completion(.success(savedWeatherResults))
    }
    
    func deleteWeatherResult(for lat: Double, lon: Double) {
        savedWeatherResults.removeAll { result in
            result.lat == lat && result.lon == lon
        }
    }
}
