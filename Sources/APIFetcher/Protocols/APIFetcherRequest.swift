import Foundation

public protocol APIFetcherRequest {

    var urlRequest: URLRequest { get throws }

}
