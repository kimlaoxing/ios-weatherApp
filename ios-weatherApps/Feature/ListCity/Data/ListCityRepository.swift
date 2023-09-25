import Foundation

public protocol ListCityRepositoryProtocol: AnyObject {
    func getWeatherEachCity(with lat: Double, lon: Double, _ completion: @escaping(Result<WeatherResult, Error>) -> Void)
    func saveWeatherResult(_ weatherResult: WeatherResult, completion: @escaping (Result<Bool, Error>) -> Void)
}

final class ListCityRepository: NSObject {
    typealias ListCityInstance = (ListCityRemoteDataSource, MainViewLocalDataSource) -> ListCityRepository
    
    fileprivate let remote: ListCityRemoteDataSource
    fileprivate let local: MainViewLocalDataSource
    
    private init(remote: ListCityRemoteDataSource, local: MainViewLocalDataSource) {
        self.remote = remote
        self.local = local
    }
    
    static let sharedInstance: ListCityInstance = { remote, local in
        return ListCityRepository(remote: remote, local: local)
    }
}

extension ListCityRepository: ListCityRepositoryProtocol {
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
