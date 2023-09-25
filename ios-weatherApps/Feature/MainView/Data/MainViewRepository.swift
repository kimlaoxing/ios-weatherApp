import Foundation

public protocol MainViewRepositoryProtocol: AnyObject {
    func getWeatherEachCity(with lat: Double, lon: Double, _ completion: @escaping(Result<WeatherResult, Error>) -> Void)
    func loadAllWeatherResults(completion: @escaping (Result<[WeatherResult], Error>) -> Void)
    func deleteWeatherResult(for lat: Double, lon: Double)
    func saveWeatherResult(_ weatherResult: WeatherResult, completion: @escaping (Result<Bool, Error>) -> Void)
}

final class MainViewRepository: NSObject {
    typealias MainViewInstance = (MainViewRemoteDataSource, MainViewLocalDataSource) -> MainViewRepository
    
    fileprivate let remote: MainViewRemoteDataSource
    fileprivate let local: MainViewLocalDataSource
    
    private init(remote: MainViewRemoteDataSource, local: MainViewLocalDataSource) {
        self.remote = remote
        self.local = local
    }
    
    static let sharedInstance: MainViewInstance = { remote, local in
        return MainViewRepository(remote: remote, local: local)
    }
}

extension MainViewRepository: MainViewRepositoryProtocol {
    func getWeatherEachCity(
        with lat: Double,
        lon: Double,
        _ completion: @escaping(Result<WeatherResult, Error>) -> Void
    ) {
        self.remote.getWeatherEachCity(with: lat, lon: lon) { data in
            switch data {
            case .success(let response):
                completion(.success(WeatherResponseMapper.weatherResponseToWeatherResult(with: response)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func loadAllWeatherResults(
        completion: @escaping (Result<[WeatherResult], Error>) -> Void
    ) {
        self.local.loadAllWeatherResults { data in
            switch data {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteWeatherResult(for lat: Double, lon: Double) {
        self.local.deleteWeatherResult(for: lat, lon: lon)
    }
    
    func saveWeatherResult(
        _ weatherResult: WeatherResult,
        completion: @escaping (Result<Bool, Error>) -> Void
    ) {
        self.local.saveWeatherResult(weatherResult) { bool in
            switch bool {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
