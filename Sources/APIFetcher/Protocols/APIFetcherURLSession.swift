import Foundation

/// This protocol is used for `URLSession` abstraction.
public protocol APIFetcherURLSession {

    /// Loads data using an URLRequest.
    ///
    /// - Parameter request: The URLRequest for which to load data.
    /// - Parameter delegate: Task-specific delegate.
    /// - Returns: Data and response.
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)

}
