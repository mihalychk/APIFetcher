import XCTest
@testable import APIFetcher

final class APIFetcherConfigurationTests: XCTestCase {

    func testInit() throws {
        let decoder = APIFetcherDecoderMock()
        let urlSession = APIFetcherURLSessionMock()
        let configuration = APIFetcher.Configuration(
            decoder: decoder,
            urlSession: urlSession,
            genericErrorType: String.self
        )

        XCTAssertEqual(configuration.decoder as? APIFetcherDecoderMock, decoder)
        XCTAssertEqual(configuration.urlSession as? APIFetcherURLSessionMock, urlSession)
        XCTAssertNotNil(configuration.genericErrorType as? String.Type)
        XCTAssertNil(configuration.genericErrorType as? APIFetcherGenericErrorMock.Type)
    }

    func testDefault() {
        let decoder = APIFetcherDecoderMock()
        let configuration = APIFetcher.Configuration.default(
            decoder: decoder,
            genericErrorType: APIFetcherGenericErrorMock.self
        )

        XCTAssertEqual(configuration.decoder as? APIFetcherDecoderMock, decoder)
        XCTAssertEqual((configuration.urlSession as? URLSession)?.configuration, URLSessionConfiguration.default)
        XCTAssertNil(configuration.genericErrorType as? String.Type)
        XCTAssertNotNil(configuration.genericErrorType as? APIFetcherGenericErrorMock.Type)
    }

    func testEphemeral() {
        let decoder = APIFetcherDecoderMock()
        let configuration = APIFetcher.Configuration.ephemeral(
            decoder: decoder,
            genericErrorType: APIFetcherGenericErrorMock.self
        )

        XCTAssertEqual(configuration.decoder as? APIFetcherDecoderMock, decoder)
        XCTAssertNil(configuration.genericErrorType as? String.Type)
        XCTAssertNotNil(configuration.genericErrorType as? APIFetcherGenericErrorMock.Type)
    }

}
