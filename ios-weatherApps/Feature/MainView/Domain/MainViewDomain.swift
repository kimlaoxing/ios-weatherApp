import Foundation

protocol MainViewUseCaseProtocol {
    func getWeatherEachCity(with lat: Double, lon: Double, _ completion: @escaping(Result<WeatherResult, Error>) -> Void)
    func loadAllWeatherResults(completion: @escaping (Result<[WeatherResult], Error>) -> Void)
    func deleteWeatherResult(for lat: Double, lon: Double)
    func saveWeatherResult(_ weatherResult: WeatherResult, completion: @escaping (Result<Bool, Error>) -> Void)
}

final class MainViewInteractor: MainViewUseCaseProtocol {
    private let repository: MainViewRepositoryProtocol
    
    required init(repository: MainViewRepositoryProtocol) {
        self.repository = repository
    }
    
    func getWeatherEachCity(
        with lat: Double,
        lon: Double,
        _ completion: @escaping(Result<WeatherResult, Error>) -> Void
    ) {
        self.repository.getWeatherEachCity(with: lat, lon: lon) { data in
            switch data {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func loadAllWeatherResults(
        completion: @escaping (Result<[WeatherResult], Error>) -> Void
    ) {
        self.repository.loadAllWeatherResults { data in
            switch data {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func deleteWeatherResult(for lat: Double, lon: Double) {
        self.repository.deleteWeatherResult(for: lat, lon: lon)
    }
    
    func saveWeatherResult(
        _ weatherResult: WeatherResult,
        completion: @escaping (Result<Bool, Error>) -> Void
    ) {
        self.repository.saveWeatherResult(weatherResult) { bool in
            switch bool {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
