import Foundation
import ios_weatherApps

class MockMainViewRemoteDataSource {
    static let sharedInstance: MockMainViewRemoteDataSource = MockMainViewRemoteDataSource()
}

extension MockMainViewRemoteDataSource: MainViewRemoteDataSourceProtocol {
    func getWeatherEachCity(
        with lat: Double,
        lon: Double,
        _ completion: @escaping (Result<ios_weatherApps.WeatherResponse, Error>) -> Void
    ) {
        if let mockResponse = MockWeatherData.getMockResponse() {
            completion(.success(mockResponse))
        } else {
            completion(.failure(NSError(domain: "MockError", code: 0, userInfo: nil)))
        }
    }
}
