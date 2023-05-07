import Foundation
import APIFetcher

class APIFetcherConfigurationMock: APIFetcherConfiguration {

    let genericErrorType: APIFetcherResponse.Type = APIFetcherGenericErrorMock.self

    var decoder: APIFetcherDecoder = APIFetcherDecoderMock()
    var decoderMock: APIFetcherDecoderMock { return self.decoder as! APIFetcherDecoderMock }

    var urlSession: APIFetcherURLSession = APIFetcherURLSessionMock()
    var urlSessionMock: APIFetcherURLSessionMock { return self.urlSession as! APIFetcherURLSessionMock }

}

extension APIFetcherConfigurationMock: Equatable {

    static func == (lhs: APIFetcherConfigurationMock, rhs: APIFetcherConfigurationMock) -> Bool {
        return lhs.decoderMock == rhs.decoderMock && lhs.urlSessionMock == rhs.urlSessionMock
    }

}
