import Foundation
import Alamofire

protocol DetailRemoteDataSourceProtocol: AnyObject {
    func getWeatherEachCity(with lat: Double, lon: Double, _ completion: @escaping(Result<WeatherResponse, Error>) -> Void)
}

final class DetailRemoteDataSource: NSObject {
    private override init () {}
    
    static let sharedInstance: DetailRemoteDataSource = DetailRemoteDataSource()
}

extension DetailRemoteDataSource: DetailRemoteDataSourceProtocol {
    func getWeatherEachCity(
        with lat: Double,
        lon: Double,
        _ completion: @escaping(Result<WeatherResponse, Error>) -> Void
    ) {
        let endpoint = APIService.getURLFor(lat: lat, lon: lon)
        AF.request(endpoint,
                   method: .get,
                   encoding: URLEncoding.queryString
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: WeatherResponse.self) { data in
            switch data.result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let response):
                completion(.success(response))
            }
        }
    }
}
