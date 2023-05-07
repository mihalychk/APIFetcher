import Foundation
import APIFetcher

class APIFetcherRequestMock: APIFetcherRequest {

    let urlRequest: URLRequest

    init(_ urlRequest: URLRequest) {
        self.urlRequest = urlRequest
    }

}
