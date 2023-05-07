import Foundation

extension Data {

    static func random(count: Int) -> Data {
        var data = Data(count: count)
        let result = data.withUnsafeMutableBytes { bytes -> Int32 in
            if let baseAddress = bytes.baseAddress {
                return SecRandomCopyBytes(kSecRandomDefault, count, baseAddress)
            }
            return errSecAllocate
        }

        guard result == errSecSuccess else {
            fatalError()
        }

        return data
    }

}
