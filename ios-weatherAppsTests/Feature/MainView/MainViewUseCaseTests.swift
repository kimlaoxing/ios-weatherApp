import XCTest
@testable import ios_weatherApps

class MainViewInteractorTests: XCTestCase {
    
    var mockRepository: MockMainViewRepository!
    var interactor: MainViewInteractor!

    override func setUpWithError() throws {
        mockRepository = MockMainViewRepository(
            remote: MockMainViewRemoteDataSource(),
            local: MockMainViewLocalDataSource()
        )
        interactor = MainViewInteractor(repository: mockRepository)
    }
    
    override func tearDownWithError() throws {
        mockRepository = nil
        interactor = nil
    }
    
    func testGetWeatherEachCity() {
        let expectation = XCTestExpectation(description: "Get weather for a city")
        let lat = MockWeatherData.mockWeatherResults()?.lat ?? 0
        let lon = MockWeatherData.mockWeatherResults()?.lon ?? 0
        interactor.getWeatherEachCity(with: lat, lon: lon) { result in
            switch result {
            case .success(let weatherResult):
                XCTAssertNotNil(weatherResult)
                expectation.fulfill()
            case .failure(_):
                XCTFail("Failed to get weather data")
            }
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func testLoadAllWeatherResults() {
        let expectation = XCTestExpectation(description: "Load all weather results")
        interactor.loadAllWeatherResults { result in
            switch result {
            case .success(let weatherResults):
                XCTAssertNotNil(weatherResults)
                expectation.fulfill()
            case .failure(_):
                XCTFail("Failed to load weather results")
            }
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func testSaveWeatherResult() {
        let expectation = XCTestExpectation(description: "Save weather result")

        let weatherResult = MockWeatherData.mockWeatherResults()!
        interactor.saveWeatherResult(weatherResult) { result in
            switch result {
            case .success(let success):
                XCTAssertTrue(success)
                expectation.fulfill()
            case .failure(_):
                XCTFail("Failed to save weather result")
            }
        }

        wait(for: [expectation], timeout: 5.0)
    }
}
