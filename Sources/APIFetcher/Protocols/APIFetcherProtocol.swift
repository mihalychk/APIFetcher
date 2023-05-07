public protocol APIFetcherProtocol {

    func send<Response>(_ request: APIFetcherRequest) async throws -> Response where Response: APIFetcherResponse

}
