import XCTest
@testable import APIFetcher

final class APIFetcherAPIFetcherProtocolTests: XCTestCase {

    func testSend() async throws {
        let onDataExpectation = expectation(description: "Waiting for an attempt to send data to the server")

        let configuration = APIFetcherConfigurationMock()
        let http = APIFetcher(configuration: configuration)
        let urlRequest = URLRequest(url: .random)
        let request = APIFetcherRequestMock(urlRequest)
        let expectedResult = ResponseMock(value: String.random(length: 32))
        let expectedData = try JSONEncoder().encode(expectedResult)
        let expectedHTTPResponse = HTTPURLResponse(
            url: urlRequest.url!,
            statusCode: .random(in: 200 ... 299),
            httpVersion: nil,
            headerFields: nil
        )!

        configuration.decoder = JSONDecoder()
        configuration.urlSessionMock.onData = { request, delegate in
            XCTAssertNil(delegate)
            XCTAssertEqual(request, urlRequest)
            onDataExpectation.fulfill()
            return (expectedData, expectedHTTPResponse as URLResponse)
        }

        let result: ResponseMock = try await http.send(request)

        XCTAssertEqual(result, expectedResult)

        await fulfillment(of: [onDataExpectation], timeout: 0.5)
    }

    func testSendURLRequest() async throws {
        let onDataExpectation = expectation(description: "Waiting for an attempt to send data to the server")

        let configuration = APIFetcherConfigurationMock()
        let urlRequest = URLRequest(url: .random)
        let expectedData = Data.random(count: 32)
        let expectedHTTPResponse = HTTPURLResponse(
            url: urlRequest.url!,
            statusCode: .random(in: 200 ... 299),
            httpVersion: nil,
            headerFields: nil
        )!

        configuration.urlSessionMock.onData = { request, delegate in
            XCTAssertNil(delegate)
            XCTAssertEqual(request, urlRequest)
            onDataExpectation.fulfill()
            return (expectedData, expectedHTTPResponse)
        }

        let (data, httpResponse) = try await APIFetcher.send(urlRequest, configuration: configuration)

        XCTAssertEqual(data, expectedData)
        XCTAssertEqual(httpResponse, expectedHTTPResponse)

        await fulfillment(of: [onDataExpectation], timeout: 0.5)
    }

    func testSendURLRequest_non_HTTP_response() async throws {
        let onDataExpectation = expectation(description: "Waiting for an attempt to send data to the server")
        let onErrorExpectation = expectation(description: "Waiting for an error throwing")

        let configuration = APIFetcherConfigurationMock()
        let urlRequest = URLRequest(url: .random)
        let urlResponse = try XCTUnwrap(URLResponse(
            url: .random,
            mimeType: nil,
            expectedContentLength: .random(in: 0 ... 0xFF),
            textEncodingName: nil
        ))

        configuration.urlSessionMock.onData = { request, delegate in
            XCTAssertNil(delegate)
            XCTAssertEqual(request, urlRequest)
            onDataExpectation.fulfill()
            return (Data(), urlResponse)
        }

        do {
            let _ = try await APIFetcher.send(urlRequest, configuration: configuration)
        } catch {
            guard case APIFetcher.Error.responseIsNotHTTPResponse = error else {
                XCTFail("Wrong error returned"); return
            }
            onErrorExpectation.fulfill()
        }

        await fulfillment(of: [onDataExpectation, onErrorExpectation], timeout: 0.5)
    }

    func testHandleHTTPResponse_no_error_payload() throws {
        let decodingExpectation = expectation(description: "Waiting for an attempt to decode a response from the server")

        let configuration = APIFetcherConfigurationMock()
        let httpResponse = HTTPURLResponse(url: .random, statusCode: 400, httpVersion: nil, headerFields: nil)!
        var thrownError: Swift.Error?

        configuration.decoderMock.onDecode = { type, data throws -> Decodable in
            XCTAssertNotNil(type as? APIFetcherGenericErrorMock.Type)
            XCTAssertTrue(data.isEmpty)
            decodingExpectation.fulfill()

            // The error type doesn't matter
            throw APIFetcher.Error.responseIsNotHTTPResponse
        }

        XCTAssertThrowsError(
            try APIFetcher.handle(httpResponse, with: Data(), configuration: configuration)
        ) { thrownError = $0 }

        guard let thrownError = thrownError, case APIFetcher.Error.serverError(400, nil) = thrownError else {
            XCTFail("Wrong error returned")
            return
        }

        wait(for: [decodingExpectation], timeout: 0.5)
    }

    func testHandleHTTPResponse_with_error_payload() throws {
        let configuration = APIFetcherConfigurationMock()
        let httpResponse = HTTPURLResponse(url: .random, statusCode: 400, httpVersion: nil, headerFields: nil)!
        let expectedError = APIFetcherGenericErrorMock(error: .random(length: 32))
        let data = try JSONEncoder().encode(expectedError)
        var thrownError: Swift.Error?

        configuration.decoder = JSONDecoder()

        XCTAssertThrowsError(
            try APIFetcher.handle(httpResponse, with: data, configuration: configuration)
        ) { thrownError = $0 }

        guard
            let thrownError = thrownError,
            case APIFetcher.Error.serverError(400, let error) = thrownError,
            let serverError = error as? APIFetcherGenericErrorMock,
            serverError == expectedError
        else {
            XCTFail("Wrong error returned")
            return
        }
    }

    func testHandleHTTPResponse_no_error() throws {
        let httpResponse = HTTPURLResponse(url: .random, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let configuration = APIFetcherConfigurationMock()

        try APIFetcher.handle(httpResponse, with: Data(), configuration: configuration)
    }

}

extension APIFetcherAPIFetcherProtocolTests {

    struct ResponseMock: APIFetcherResponse, Encodable, Equatable {

        let value: String

    }

}
