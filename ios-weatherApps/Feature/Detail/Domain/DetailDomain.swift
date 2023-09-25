import Foundation

protocol DetailUseCaseProtocol {
    func getWeatherEachCity(with lat: Double, lon: Double, _ completion: @escaping(Result<WeatherResult, Error>) -> Void)
}

class DetailInteractor: DetailUseCaseProtocol {
    private let repository: DetailRepositoryProtocol
    
    required init(repository: DetailRepositoryProtocol) {
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
}
