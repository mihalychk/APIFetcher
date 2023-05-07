import Foundation

extension URLRequest {

    /// Adds headers to the request
    /// - Parameter headers: the headers
    mutating func add(headers: Set<APIFetcher.Header>) {
        headers.forEach { self.addValue($0.value, forHTTPHeaderField: $0.key) }
    }

}
