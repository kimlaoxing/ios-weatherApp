import XCTest
@testable import ios_weatherApps

class MockMainViewRepositoryTests: XCTestCase {
    
    var mockMainViewRepository: MockMainViewRepository!
    
    override func setUp() {
        super.setUp()
        mockMainViewRepository = MockMainViewRepository(
            remote: MockMainViewRemoteDataSource(),
            local: MockMainViewLocalDataSource()
        )
    }
    
    override func tearDown() {
        mockMainViewRepository = nil
        super.tearDown()
    }
    
    func testGetWeatherEachCity() {
        let weatherResult = MockWeatherData.mockWeatherResults()
        let expectation = self.expectation(description: "Get weather for each city should complete")
        mockMainViewRepository.getWeatherEachCity(with: 0.0, lon: 0.0) { result in
            switch result {
            case .success(let returnedWeatherResult):
                XCTAssertEqual(returnedWeatherResult.lon, weatherResult?.lon)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Error getting weather: \(error.localizedDescription)")
            }
        }

        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testLoadAllWeatherResults() {
        let saveData = MockWeatherData.mockWeatherResults()!
        let expectation = self.expectation(description: "Load all weather results should complete")
        DispatchQueue.main.async {
            self.mockMainViewRepository.saveWeatherResult(saveData) { bool in
                switch bool {
                case .success(let success):
                    if success {
                        self.mockMainViewRepository.loadAllWeatherResults { result in
                            switch result {
                            case .success(let returnedWeatherResults):
                                XCTAssertEqual(returnedWeatherResults.first?.lon, saveData.lon)
                                expectation.fulfill()
                            case .failure(let error):
                                XCTFail("Error loading weather results: \(error.localizedDescription)")
                            }
                        }
                    }
                case .failure(_):
                    break
                }
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testSaveWeatherResult() {
        let expectation = XCTestExpectation(description: "Save weather result")
        
        let weatherResult = MockWeatherData.mockWeatherResults()!
        self.mockMainViewRepository.saveWeatherResult(weatherResult) { result in
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
