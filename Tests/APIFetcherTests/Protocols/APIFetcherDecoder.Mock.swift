import Foundation
import APIFetcher

class APIFetcherDecoderMock: APIFetcherDecoder {

    private let id = UUID()

    var onDecode: ((Any.Type, Data) throws -> Decodable)?

    var onDecodeWasCalled = false

    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T where T: Decodable {
        self.onDecodeWasCalled = true

        return try self.onDecode!(type, data) as! T
    }

}

extension APIFetcherDecoderMock: Equatable {

    static func == (lhs: APIFetcherDecoderMock, rhs: APIFetcherDecoderMock) -> Bool {
        return lhs.id == rhs.id
    }

}
