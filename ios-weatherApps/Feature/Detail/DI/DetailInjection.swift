import Foundation

final class DetailInjection: NSObject {
    
    private func provideRepository() -> DetailRepositoryProtocol {
        let remote: DetailRemoteDataSource = DetailRemoteDataSource.sharedInstance
        return DetailRepository.sharedInstance(remote)
    }
    
    func provideUseCase() -> DetailUseCaseProtocol {
        let repository = provideRepository()
        return DetailInteractor(repository: repository)
    }
}
