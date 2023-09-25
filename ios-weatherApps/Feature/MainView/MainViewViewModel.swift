import Foundation

protocol MainViewViewModelInput {
    func loadAllWeatherResults()
    func deleteWeatherResult(for lat: Double, lon: Double)
    func presentListCity()
    func toDetailView(with lat: Double, lon: Double)
}

protocol MainViewViewModelOutput {
    var weatherResult: Observable<[WeatherResult?]> { get }
}

protocol MainViewViewModel: MainViewViewModelInput, MainViewViewModelOutput {}

final class DefaultMainViewViewModel: MainViewViewModel {
    
    let weatherResult: Observable<[WeatherResult?]> = Observable([])
    var weather: [WeatherResult] = []
    
    let useCase: MainViewUseCaseProtocol
    let listCityRouter: ListCityRouterProtocol?
    let detailRouter: DetailWeatherRouterProtocol?
    
//    init(
//        useCase: MainViewUseCaseProtocol,
//        listCityRouter: ListCityRouterProtocol,
//        detailRouter: DetailWeatherRouterProtocol
//    ) {
//        self.useCase = useCase
//        self.listCityRouter = listCityRouter
//        self.detailRouter = detailRouter
//    }
//
    init(
        useCase: MainViewUseCaseProtocol,
        listCityRouter: ListCityRouterProtocol? = nil,
        detailRouter: DetailWeatherRouterProtocol? = nil
    ) {
        self.useCase = useCase
        self.listCityRouter = listCityRouter
        self.detailRouter = detailRouter
    }

    func getWeatherEachCity(with lat: Double, lon: Double) {
        self.useCase.getWeatherEachCity(with: lat, lon: lon) { data in
            switch data {
            case .success(let data):
                var results: [WeatherResult] = []
                results.append(data)
                self.weatherResult.value.append(contentsOf: results.sorted(by: { $0.city < $1.city }))
            case .failure(_):
                break
            }
        }
    }
    
    func loadAllWeatherResults() {
        self.useCase.loadAllWeatherResults { [weak self] data in
            switch data {
            case .success(let data):
                self?.weatherResult.value.removeAll()
                for weatherResult in data {
                    let lat = weatherResult.lat
                    let lon = weatherResult.lon
                    self?.getWeatherEachCity(with: lat, lon: lon)
                }
            case .failure(_):
                break
            }
        }
    }
    
    func deleteWeatherResult(for lat: Double, lon: Double) {
        self.useCase.deleteWeatherResult(for: lat, lon: lon)
    }
    
    func presentListCity() {
        self.listCityRouter?.presentListCityController(with: self)
    }
    
    func toDetailView(with lat: Double, lon: Double) {
        self.detailRouter?.toDetailView(with: lat, lon: lon)
    }
}


extension DefaultMainViewViewModel: ListCityDelegate {
    func didSelectCity() {
        self.loadAllWeatherResults()
    }
}
