import Foundation
import APIFetcher

extension String {

    static func random(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

        return String((0 ..< length).map { _ in
            return letters.randomElement() ?? Character("a")
        })
    }

    static func randomPath(in range: ClosedRange<Int> = 1...5) -> String {
        var elements = [String]()

        for _ in 0 ..< Int.random(in: range) {
            elements.append(String.random(length: Int.random(in: 1...10)).lowercased())
        }

        return "/" + elements.joined(separator: "/")
    }

    static func randomDomainName(in range: ClosedRange<Int> = 5...12) -> String {
        let domains = [
            "ru",
            "com",
            "org",
            "net"
        ]
        let randomDomainName = String.random(length: Int.random(in: range)).lowercased()
        let randomTopLevelDomain = domains[Int.random(in: 0 ..< domains.count)]

        return [
            randomDomainName,
            randomTopLevelDomain
        ].joined(separator: ".")
    }

}

extension String: APIFetcherResponse {}
