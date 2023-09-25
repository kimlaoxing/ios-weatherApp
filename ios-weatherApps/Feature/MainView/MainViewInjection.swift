import Foundation

final class MainViewInjection: NSObject {
    
    private func provideRepository() -> MainViewRepositoryProtocol {
        let remote: MainViewRemoteDataSource = MainViewRemoteDataSource.sharedInstance
        let local: MainViewLocalDataSource = MainViewLocalDataSource.sharedInstance
        return MainViewRepository.sharedInstance(remote, local)
    }
    
    func provideUseCase() -> MainViewUseCaseProtocol {
        let repository = provideRepository()
        return MainViewInteractor(repository: repository)
    }
}

