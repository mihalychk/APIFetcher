import Foundation

extension APIFetcher {

    public enum Header: Hashable {

        case authorization(String)

        case contentType(String)

        case custom(String, String)

        case userAgent(String)

    }

}

extension APIFetcher.Header {

    public var key: String {
        switch self {
        case .authorization:
            return "Authorization"
        case .contentType:
            return "Content-Type"
        case .custom(let key, _):
            return key
        case .userAgent:
            return "User-Agent"
        }
    }

    public var value: String {
        switch self {
        case .authorization(let value):
            return value
        case .contentType(let value):
            return value
        case .custom(_, let value):
            return value
        case .userAgent(let value):
            return value
        }
    }

}
