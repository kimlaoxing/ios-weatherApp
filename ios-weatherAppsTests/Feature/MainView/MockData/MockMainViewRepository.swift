import Foundation
import ios_weatherApps

class MockMainViewRepository {
    
    let remote: MainViewRemoteDataSourceProtocol
    let local: MainViewLocalDataSourceProtocol
    
    init(remote: MainViewRemoteDataSourceProtocol, local: MainViewLocalDataSourceProtocol) {
        self.remote = remote
        self.local = local
    }
}

extension MockMainViewRepository: MainViewRepositoryProtocol {
    func getWeatherEachCity(
        with lat: Double,
        lon: Double,
        _ completion: @escaping (Result<WeatherResult, Error>) -> Void
    ) {
        self.remote.getWeatherEachCity(with: lat, lon: lon) { data in
            switch data {
            case .success(let response):
                let weatherResult = WeatherResponseMapper.weatherResponseToWeatherResult(with: response)
                completion(.success(weatherResult))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func loadAllWeatherResults(completion: @escaping (Result<[ios_weatherApps.WeatherResult], Error>) -> Void) {
        self.local.loadAllWeatherResults { data in
            switch data {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(data))
            }
        }
    }
    
    func deleteWeatherResult(for lat: Double, lon: Double) {
        self.local.deleteWeatherResult(for: lat, lon: lon)
    }
    
    func saveWeatherResult(_ weatherResult: ios_weatherApps.WeatherResult, completion: @escaping (Result<Bool, Error>) -> Void) {
        self.local.saveWeatherResult(weatherResult) { results in
            switch results {
            case .success(let bool):
                completion(.success(bool))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
