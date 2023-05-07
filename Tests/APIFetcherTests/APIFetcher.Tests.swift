import XCTest
@testable import APIFetcher

final class APIFetcher_Tests: XCTestCase {

    func testInit() throws {
        let configuration = APIFetcherConfigurationMock()
        let fetcher = APIFetcher(configuration: configuration)

        XCTAssertEqual(fetcher.configuration as? APIFetcherConfigurationMock, configuration)
    }

}
