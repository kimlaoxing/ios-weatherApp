import Foundation

protocol DetailRepositoryProtocol: AnyObject {
    func getWeatherEachCity(with lat: Double, lon: Double, _ completion: @escaping(Result<WeatherResult, Error>) -> Void)
}

final class DetailRepository: NSObject {
    typealias DetailInstance = (DetailRemoteDataSource) -> DetailRepository
    
    fileprivate let remote: DetailRemoteDataSource
    
    private init(remote: DetailRemoteDataSource) {
        self.remote = remote
    }
    
    static let sharedInstance: DetailInstance = { remoteRepo in
        return DetailRepository(remote: remoteRepo)
    }
}

extension DetailRepository: DetailRepositoryProtocol {
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
}
