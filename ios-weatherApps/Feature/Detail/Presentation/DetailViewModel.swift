import Foundation

protocol DetailViewModelInput {
    func getWeather(with lat: Double, lon: Double)
}

protocol DetailViewModelOutput {
    var weatherResult: Observable<WeatherResult?> { get }
}

protocol DetailViewModel: DetailViewModelInput, DetailViewModelOutput { }

final class DefaultDetailViewModel: DetailViewModel {
    let weatherResult: Observable<WeatherResult?> = Observable(nil)
    let useCase: DetailUseCaseProtocol
    
    init(
        useCase: DetailUseCaseProtocol,
        lat: Double,
        lon: Double
    ) {
        self.useCase = useCase
        self.getWeather(with: lat, lon: lon)
    }
    
    func getWeather(with lat: Double, lon: Double) {
        self.useCase.getWeatherEachCity(with: lat, lon: lon) { [weak self] data in
            switch data {
            case .failure(_):
                break
            case .success(let data):
                self?.weatherResult.value = data
            }
        }
    }
}
