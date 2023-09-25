import UIKit

protocol ListCityRouterProtocol {
    func presentListCityController(with listCityDelegate: ListCityDelegate)
}

final class ListCityRouter: ListCityRouterProtocol {
    var navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func presentListCityController(with listCityDelegate: ListCityDelegate) {
        let controller = ListCityViewController()
        let useCase = ListCityInjection.init().provideUseCase()
        let viewModel = DefaultListCityViewModel(useCase: useCase)
        viewModel.delegate = listCityDelegate
        controller.viewModel = viewModel
        self.navigation.present(controller, animated: true)
    }
}
