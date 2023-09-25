import Foundation

protocol ListCityUseCaseProtocol {
    func getWeatherEachCity(with lat: Double, lon: Double, _ completion: @escaping(Result<WeatherResult, Error>) -> Void)
    func saveWeatherResult(_ weatherResult: WeatherResult, completion: @escaping (Result<Bool, Error>) -> Void)
}

final class ListCityInteractor: ListCityUseCaseProtocol {
    private let repository: ListCityRepositoryProtocol
    
    required init(repository: ListCityRepositoryProtocol) {
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
