import Foundation

extension APIFetcher: APIFetcherProtocol {

    public func send<Response>(_ request: APIFetcherRequest) async throws -> Response where Response: APIFetcherResponse {
        let (data, httpResponse) = try await Self.send(request.urlRequest, configuration: self.configuration)

        debugPrint(data)
        try Self.handle(httpResponse, with: data, configuration: self.configuration)

        return try self.configuration.decoder.decode(Response.self, from: data)
    }

}

extension APIFetcher {

    static func send(_ urlRequest: URLRequest, configuration: APIFetcherConfiguration) async throws -> (Data, HTTPURLResponse) {
        let (data, response) = try await configuration.urlSession.data(for: urlRequest, delegate: nil)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIFetcher.Error.responseIsNotHTTPResponse
        }

        return (data, httpResponse)
    }

    static func handle(_ httpResponse: HTTPURLResponse, with data: Data, configuration: APIFetcherConfiguration) throws {
        if (200...299).contains(httpResponse.statusCode) { return }

        let genericError: Any?
        do {
            genericError = try configuration.decoder.decode(configuration.genericErrorType, from: data)
        } catch {
            debugPrint(error)
            genericError = nil
        }

        throw APIFetcher.Error.serverError(httpResponse.statusCode, genericError)
    }

}
