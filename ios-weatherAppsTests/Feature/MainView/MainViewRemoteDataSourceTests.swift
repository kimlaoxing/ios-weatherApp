import XCTest
@testable import ios_weatherApps

class MainViewRemoteDataSourceTests: XCTestCase {
    
    var sut: MainViewRemoteDataSourceProtocol!
    var mockDataSource: MockMainViewRemoteDataSource!
    
    override func setUp() {
        super.setUp()
        mockDataSource = MockMainViewRemoteDataSource()
        sut = mockDataSource
    }

    override func tearDown() {
        sut = nil
        mockDataSource = nil
        super.tearDown()
    }
    
    func testGetWeatherEachCityIsSuccess() {
        let expectedResponse = MockWeatherData.getMockResponse()
        let expectation = XCTestExpectation(description: "Get MockResponse")
        
        _ =  sut.getWeatherEachCity(with: -6.9222, lon: 107.6069, { data in
            switch data {
            case .success(let data):
                expectation.fulfill()
                XCTAssertEqual(data, expectedResponse)
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }
        })
        wait(for: [expectation], timeout: 5.0)
    }
}
