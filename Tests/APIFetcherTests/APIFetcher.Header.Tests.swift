import XCTest
@testable import APIFetcher

final class APIFetcherHeaderTests: XCTestCase {

    func testAuthorization() throws {
        let value = String.random(length: 32)
        let header = APIFetcher.Header.authorization(value)

        XCTAssertEqual(header.key, "Authorization")
        XCTAssertEqual(header.value, value)
    }

    func testContentType() throws {
        let value = String.random(length: 32)
        let header = APIFetcher.Header.contentType(value)

        XCTAssertEqual(header.key, "Content-Type")
        XCTAssertEqual(header.value, value)
    }

    func testCustom() throws {
        let key = String.random(length: 32)
        let value = String.random(length: 32)
        let header = APIFetcher.Header.custom(key, value)

        XCTAssertEqual(header.key, key)
        XCTAssertEqual(header.value, value)
    }

    func testUserAgent() throws {
        let value = String.random(length: 32)
        let header = APIFetcher.Header.userAgent(value)

        XCTAssertEqual(header.key, "User-Agent")
        XCTAssertEqual(header.value, value)
    }

}
