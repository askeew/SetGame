import XCTest
@testable import SetGame

class SetGameTests: XCTestCase {

    func testNoIsNotAllDifferent() throws {
        let first = SetCard(no: .three, symbol: .diamond, shading: .striped, colour: .red, id: 0)
        let second = SetCard(no: .two, symbol: .oval, shading: .open, colour: .purple, id: 1)
        let third = SetCard(no: .three, symbol: .squiggle, shading: .solid, colour: .blue, id: 2)
        XCTAssertFalse(first.match(with: second, and: third))
    }
}
