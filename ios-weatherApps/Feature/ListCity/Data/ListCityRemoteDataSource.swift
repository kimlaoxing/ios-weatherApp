import Foundation
import Alamofire

public protocol ListCityRemoteDataSourceProtocol: AnyObject {
    func getWeatherEachCity(with lat: Double, lon: Double, _ completion: @escaping(Result<WeatherResponse, Error>) -> Void)
}

final class ListCityRemoteDataSource: NSObject {
    private override init () {}
    
    static let sharedInstance: ListCityRemoteDataSource = ListCityRemoteDataSource()
}

extension ListCityRemoteDataSource: ListCityRemoteDataSourceProtocol {
    func getWeatherEachCity(
        with lat: Double,
        lon: Double,
        _ completion: @escaping(Result<WeatherResponse, Error>) -> Void
    ) {
        let endpoint = APIService.getURLFor(lat: lat, lon: lon)
        print("\(endpoint)")
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
