import Foundation

/// This protocol is used for decoder abstraction.
public protocol APIFetcherDecoder {

    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable

}
