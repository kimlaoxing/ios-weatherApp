import UIKit

final class MainViewRouter {
    func makeHomeTab() -> UIViewController {
        let useCase = MainViewInjection.init().provideUseCase()
        let controller = MainViewViewController()
        let navigation = UINavigationController(rootViewController: controller)
        let listCityRouter = ListCityRouter(navigation: navigation)
        let detailRouter = DetailWeatherRouter(navigation: navigation)
        let viewModel = DefaultMainViewViewModel(
            useCase: useCase,
            listCityRouter: listCityRouter,
            detailRouter: detailRouter
        )
        controller.viewModel = viewModel
        controller.navigationItem.backButtonTitle = ""
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .white
        navBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        navigation.navigationBar.standardAppearance = navBarAppearance
        navigation.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigation.navigationBar.tintColor = .black
        navigation.navigationBar.prefersLargeTitles = false
        navigation.navigationBar.barStyle = .default
        navigation.navigationBar.backgroundColor = .gray
        return navigation
    }
}
