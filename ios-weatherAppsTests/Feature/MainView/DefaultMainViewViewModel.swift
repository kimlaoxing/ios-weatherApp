import XCTest
@testable import ios_weatherApps

class DefaultMainViewViewModelTests: XCTestCase {

    var mockUseCase: MainViewUseCaseProtocol!
    var mockListCityRouter: ListCityRouter!
    var mockDetailRouter: DetailWeatherRouter!
    var viewModel: DefaultMainViewViewModel!

    override func setUpWithError() throws {
        mockUseCase = MainViewInteractor(repository: MockMainViewRepository(
            remote: MockMainViewRemoteDataSource(),
            local: MockMainViewLocalDataSource()
        ))
        viewModel = DefaultMainViewViewModel(
            useCase: mockUseCase
        )
    }
    
    override func tearDownWithError() throws {
        mockUseCase = nil
        viewModel = nil
    }

    func testLoadAllWeatherResults() {
        let expectedResult = MockWeatherData.mockWeatherResults()!
        let expectation = self.expectation(description: "Get weather for each city should complete")
        self.mockUseCase.saveWeatherResult(expectedResult) { bool in
            switch bool {
            case .success(let success):
                if success {
                    self.viewModel.loadAllWeatherResults()
                }
            case .failure(let error):
                XCTFail("Error saving weather: \(error.localizedDescription)")
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            expectation.fulfill()
            XCTAssertEqual(self.viewModel.weatherResult.value.count, [expectedResult].count)
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetWetherEachCity() {
        let expectation = self.expectation(description: "Get weather for each city should complete")
        let mockData = MockWeatherData.mockWeatherResults()
        self.viewModel.getWeatherEachCity(with: mockData?.lat ?? 0, lon: mockData?.lon ?? 0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            expectation.fulfill()
            XCTAssertEqual(self.viewModel.weatherResult.value.count, [mockData].count)
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
