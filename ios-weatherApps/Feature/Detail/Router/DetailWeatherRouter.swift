import UIKit

protocol DetailWeatherRouterProtocol {
    func toDetailView(with lat: Double, lon: Double)
}

final class DetailWeatherRouter: DetailWeatherRouterProtocol {
    var navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func toDetailView(with lat: Double, lon: Double) {
        let controller = DetailViewController()
        let useCase = DetailInjection.init().provideUseCase()
        let viewModel = DefaultDetailViewModel(useCase: useCase, lat: lat, lon: lon)
        controller.viewModel = viewModel
        self.navigation.pushViewController(controller, animated: true)
    }
}
