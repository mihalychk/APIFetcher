import XCTest
@testable import APIFetcher

final class APIFetcherRequestTests: XCTestCase {

    func testInit() throws {
        let method = APIFetcher.Method.random
        let url = URL.random
        let body = APIFetcher.Body.data(.random(count: 10))
        let headers = Set<APIFetcher.Header>([
            .authorization(.random(length: 10))
        ])
        let request = APIFetcher.Request(
            method,
            to: url,
            headers: headers,
            body: body
        )

        XCTAssertEqual(request.method, method)
        XCTAssertEqual(request.url, url)
        XCTAssertEqual(request.headers, headers)
        try XCTAssertEqual(request.body.data, body.data)
    }

    func testURLRequest() throws {
        let method = APIFetcher.Method.random
        let url = URL.random
        let body = APIFetcher.Body.json(Dummy(), JSONEncoder())
        let authorization = String.random(length: 10)
        let headers = Set<APIFetcher.Header>([
            .authorization(authorization)
        ])
        let request = try APIFetcher.Request(
            method,
            to: url,
            headers: headers,
            body: body
        ).urlRequest

        XCTAssertEqual(request.httpMethod, method.rawValue)
        XCTAssertEqual(request.url, url)
        try XCTAssertEqual(request.httpBody, body.data)

        for (key, value) in request.allHTTPHeaderFields! {
            switch key {
            case "Authorization":
                XCTAssertEqual(value, authorization)
            case "Content-Type":
                XCTAssertEqual(value, "application/json")
            default:
                XCTFail("Unexpected header")
            }
        }
    }

}

extension APIFetcherRequestTests {

    struct Dummy: Encodable {}

}
