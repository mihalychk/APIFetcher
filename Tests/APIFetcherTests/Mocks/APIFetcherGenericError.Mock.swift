import Foundation
import APIFetcher

struct APIFetcherGenericErrorMock: APIFetcherResponse, Encodable, Equatable {

    let error: String

}
