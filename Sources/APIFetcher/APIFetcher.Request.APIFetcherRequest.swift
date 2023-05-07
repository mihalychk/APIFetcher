import Foundation

extension APIFetcher.Request: APIFetcherRequest {

    public var urlRequest: URLRequest {
        get throws {
            var urlRequest = URLRequest(url: self.url)
            urlRequest.add(headers: self.headers)
            urlRequest.add(headers: self.body.extraHeaders)
            urlRequest.httpBody = try self.body.data
            urlRequest.httpMethod = self.method.rawValue

            return urlRequest
        }
    }

}
