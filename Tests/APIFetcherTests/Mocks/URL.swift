import Foundation

extension URL {

    static var random: URL {
        let scheme = "http" + (Bool.random() ? "s" : "")
        let domain = String.randomDomainName()
        let urlString = [
            scheme,
            domain
        ].joined(separator: "://")

        return URL(string: urlString)!
    }

    static var randomFile: URL {
        let urlString = "file:///" + String.randomDomainName()

        return URL(string: urlString)!
    }

}
