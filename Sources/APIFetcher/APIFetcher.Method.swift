import Foundation

extension APIFetcher {

    /// The HTTP request method,
    /// https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods
    public enum Method: String, CaseIterable, Encodable {

        /// The `GET` method requests a representation of the specified resource.
        /// Requests using `GET` should only retrieve data.
        case get = "GET"

        /// The `POST` method submits an entity to the specified resource,
        /// often causing a change in state or side effects on the server.
        case post = "POST"

    }

}
