import Foundation

extension CaseIterable {

    static var random: Self { Self.allCases.randomElement()! }

}
