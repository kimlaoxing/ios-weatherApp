import Foundation
import RealmSwift

public protocol MainViewLocalDataSourceProtocol: AnyObject {
    func saveWeatherResult(_ weatherResult: WeatherResult, completion: @escaping (Result<Bool, Error>) -> Void)
    func loadAllWeatherResults(completion: @escaping (Result<[WeatherResult], Error>) -> Void)
    func deleteWeatherResult(for lat: Double, lon: Double)
}

final class MainViewLocalDataSource: NSObject {
    private override init() {}
    
    static let sharedInstance: MainViewLocalDataSource = MainViewLocalDataSource()
    
    private let realm = try! Realm()
}

extension MainViewLocalDataSource: MainViewLocalDataSourceProtocol {
    func saveWeatherResult(
        _ weatherResult: WeatherResult,
        completion: @escaping (Result<Bool, Error>) -> Void
    ) {
        do {
            try realm.write {
                let weatherResultObject = WeatherResultObject()
                weatherResultObject.id = weatherResult.id
                weatherResultObject.temp = weatherResult.temp
                weatherResultObject.city = weatherResult.city
                weatherResultObject.lat = weatherResult.lat
                weatherResultObject.lon = weatherResult.lon
                realm.add(weatherResultObject, update: .modified)
            }
            completion(.success(true))
        } catch {
            completion(.failure(error))
        }
    }
    
    func loadAllWeatherResults(completion: @escaping (Result<[WeatherResult], Error>) -> Void) {
        let weatherResultObjects = self.realm.objects(WeatherResultObject.self)
        let weatherResults: [WeatherResult] = weatherResultObjects.map {
            WeatherResult(
                id: $0.id,
                temp: $0.temp,
                city: $0.city,
                lat: $0.lat,
                lon: $0.lon,
                hourly: [],
                daily: [],
                icon: $0.icon
            )
        }
        completion(.success(weatherResults))
    }
    
    func deleteWeatherResult(for lat: Double, lon: Double) {
        if let weatherResultToDelete = realm.objects(WeatherResultObject.self).filter("lat == \(lat) AND lon == \(lon)").first {
            try? realm.write {
                realm.delete(weatherResultToDelete)
            }
        }
    }
}
