import XCTest
@testable import ios_weatherApps

class MainViewLocalDataSourceTests: XCTestCase {
    var sut: MainViewLocalDataSourceProtocol!
    var mockLocalDataSource: MockMainViewLocalDataSource!
    
    override func setUp() {
        super.setUp()
        mockLocalDataSource = MockMainViewLocalDataSource()
        sut = mockLocalDataSource
    }
    
    override func tearDown() {
        sut = nil
        mockLocalDataSource = nil
        super.tearDown()
    }
    
    func testSaveWeatherResult() {
        let weatherResult = MockWeatherData.mockWeatherResults()!
        let expectation = self.expectation(description: "Save weather result should complete")
        mockLocalDataSource.saveWeatherResult(weatherResult) { result in
            switch result {
            case .success(let success):
                XCTAssertTrue(success)
                XCTAssertEqual(self.mockLocalDataSource.savedWeatherResults.count, 1)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Saving weather result failed with error: \(error.localizedDescription)")
            }
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testLoadAllWeatherResults() {
        let expectation = self.expectation(description: "Load all weather results should complete")
        let initialCount = mockLocalDataSource.savedWeatherResults.count
        mockLocalDataSource.loadAllWeatherResults { result in
            switch result {
            case .success(let weatherResults):
                XCTAssertEqual(weatherResults.count, initialCount)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Loading all weather results failed with error: \(error.localizedDescription)")
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testDeleteWeatherResult() {
        let weatherResult = MockWeatherData.mockWeatherResults()!
        mockLocalDataSource.savedWeatherResults.append(weatherResult)
        let expectation = self.expectation(description: "Delete weather result should complete")
        mockLocalDataSource.deleteWeatherResult(for: weatherResult.lat, lon: weatherResult.lon)
        XCTAssertEqual(self.mockLocalDataSource.savedWeatherResults.count, 0)
        expectation.fulfill()
        waitForExpectations(timeout: 10.0, handler: nil)
    }
}
