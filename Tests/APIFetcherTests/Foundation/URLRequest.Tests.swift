import XCTest
@testable import APIFetcher

final class URLRequestTests: XCTestCase {

    func testAddingHeaders() throws {
        var request = URLRequest(url: .random)

        XCTAssertNil(request.allHTTPHeaderFields)

        let authorization = String.random(length: 32)
        let contentType = String.random(length: 32)
        let customKey = String.random(length: 16)
        let customValue = String.random(length: 16)

        request.add(headers: [
            .authorization(authorization),
            .contentType(contentType),
            .custom(customKey, customValue)
        ])

        let headers = try XCTUnwrap(request.allHTTPHeaderFields)

        XCTAssertEqual(headers.count, 3)
        XCTAssertEqual(headers["Authorization"], authorization)
        XCTAssertEqual(headers["Content-Type"], contentType)
        XCTAssertEqual(headers[customKey], customValue)
    }

}
