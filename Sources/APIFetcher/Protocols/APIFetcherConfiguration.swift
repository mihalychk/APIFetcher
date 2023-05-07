public protocol APIFetcherConfiguration {

    var decoder: APIFetcherDecoder { get }

    var genericErrorType: APIFetcherResponse.Type { get }

    var urlSession: APIFetcherURLSession { get }

}
