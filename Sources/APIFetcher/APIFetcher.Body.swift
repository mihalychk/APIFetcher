import Foundation

extension APIFetcher {

    public enum Body {

        case data(Data)

        case empty

        case json(Encodable, JSONEncoder)

    }

}

extension APIFetcher.Body {

    public var data: Data {
        get throws {
            switch self {
            case .data(let data):
                return data

            case .empty:
                return Data()

            case .json(let object, let encoder):
                return try encoder.encode(object)
            }
        }
    }

    public var extraHeaders: Set<APIFetcher.Header> {
        switch self {
        case .json:
            return [
                .contentType("application/json")
            ]
        default:
            return []
        }
    }

}
