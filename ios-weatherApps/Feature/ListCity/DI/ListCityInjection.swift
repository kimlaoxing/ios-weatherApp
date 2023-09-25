import Foundation

final class ListCityInjection: NSObject {
    
    private func provideRepository() -> ListCityRepositoryProtocol {
        let remote: ListCityRemoteDataSource = ListCityRemoteDataSource.sharedInstance
        let local: MainViewLocalDataSource = MainViewLocalDataSource.sharedInstance
        return ListCityRepository.sharedInstance(remote, local)
    }
    
    func provideUseCase() -> ListCityUseCaseProtocol {
        let repository = provideRepository()
        return ListCityInteractor(repository: repository)
    }
}

