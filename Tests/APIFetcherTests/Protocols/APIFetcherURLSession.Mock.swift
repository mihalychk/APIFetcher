import Foundation
import APIFetcher

class APIFetcherURLSessionMock: APIFetcherURLSession {

    private let id = UUID()

    var onData: ((URLRequest, URLSessionTaskDelegate?) async throws -> (Data, URLResponse))?

    var onDataWasCalled = false

    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        onDataWasCalled = true

        return try await onData!(request, delegate)
    }

}

extension APIFetcherURLSessionMock: Equatable {

    static func == (lhs: APIFetcherURLSessionMock, rhs: APIFetcherURLSessionMock) -> Bool {
        return lhs.id == rhs.id
    }

}
