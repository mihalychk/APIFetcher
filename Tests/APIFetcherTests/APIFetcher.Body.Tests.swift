import XCTest
@testable import APIFetcher

final class APIFetcherBodyTests: XCTestCase {

    func testExtraHeaders_Data() throws {
        let body = APIFetcher.Body.data(.random(count: 10))
        let extraHeaders = body.extraHeaders

        XCTAssertTrue(extraHeaders.isEmpty)
    }

    func testExtraHeaders_Empty() throws {
        let body = APIFetcher.Body.empty
        let extraHeaders = body.extraHeaders

        XCTAssertTrue(extraHeaders.isEmpty)
    }

    func testExtraHeaders_JSON() throws {
        let body = APIFetcher.Body.json(Dummy(), JSONEncoder())
        let extraHeaders = body.extraHeaders

        XCTAssertEqual(extraHeaders.count, 1)
        XCTAssertEqual(extraHeaders.first!.key, "Content-Type")
        XCTAssertEqual(extraHeaders.first!.value, "application/json")
    }

    func testData_Data() throws {
        let data = Data.random(count: 10)
        let body = APIFetcher.Body.data(data)
        let result = try body.data

        XCTAssertEqual(result, data)
    }

    func testData_Empty() throws {
        let body = APIFetcher.Body.empty
        let result = try body.data

        XCTAssertTrue(result.isEmpty)
    }

    func testData_JSON() throws {
        let object = Dummy()
        let body = APIFetcher.Body.json(object, JSONEncoder())
        let expectedJSON = [
            "id": object.id.uuidString
        ]
        let expectedData = try JSONSerialization.data(withJSONObject: expectedJSON, options: [])
        let result = try body.data

        XCTAssertEqual(expectedData, result)
    }

}

extension APIFetcherBodyTests {

    struct Dummy: Encodable {

        let id = UUID()

    }

}
