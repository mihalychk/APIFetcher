import Foundation

extension APIFetcher {

    public struct Request {

        public let body: APIFetcher.Body

        public let headers: Set<APIFetcher.Header>

        public let method: APIFetcher.Method

        public let url: URL

        public init(_ method: APIFetcher.Method, to url: URL, headers: Set<APIFetcher.Header> = [], body: APIFetcher.Body = .empty) {
            self.body = body
            self.headers = headers
            self.method = method
            self.url = url
        }

    }

}
