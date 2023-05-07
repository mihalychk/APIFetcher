import Foundation

extension APIFetcher {

    public struct Configuration: APIFetcherConfiguration {

        public let decoder: APIFetcherDecoder

        public let genericErrorType: APIFetcherResponse.Type

        public let urlSession: APIFetcherURLSession

        public init(decoder: APIFetcherDecoder, urlSession: APIFetcherURLSession, genericErrorType: APIFetcherResponse.Type) {
            self.decoder = decoder
            self.genericErrorType = genericErrorType
            self.urlSession = urlSession
        }

    }

}

extension APIFetcher.Configuration {

    /// Creates a new configuration with the default URL session configuration.
    /// - Parameters:
    ///   - decoder: the decoder
    ///   if the server cannot process the request
    /// - Returns: a new configuration instance
    public static func `default`(decoder: APIFetcherDecoder, genericErrorType: APIFetcherResponse.Type) -> APIFetcher.Configuration {
        return .init(
            decoder: decoder,
            urlSession: URLSession(configuration: .default),
            genericErrorType: genericErrorType
        )
    }

    /// Creates a new configuration with the ephemeral URL session configuration.
    /// - Parameters:
    ///   - decoder: the decoder
    ///   if the server cannot process the request
    /// - Returns: a new configuration instance
    public static func ephemeral(decoder: APIFetcherDecoder, genericErrorType: APIFetcherResponse.Type) -> APIFetcher.Configuration {
        return .init(
            decoder: decoder,
            urlSession: URLSession(configuration: .ephemeral),
            genericErrorType: genericErrorType
        )
    }

}
