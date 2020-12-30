import Foundation


enum No: CaseIterable {
    case one, two, three
}


enum Symbol: CaseIterable {
    case diamond, squiggle, oval
}

enum Shading: CaseIterable {
    case solid, striped, open
}

enum Colour: CaseIterable {
    case red, green, purple
}

struct SetCard: CustomStringConvertible, Identifiable {
    let no: No
    let symbol: Symbol
    let shading: Shading
    let colour: Colour
    
    var isSelected = false
    var id: Int
    
    var description: String { "\(no) \(symbol) \(shading) \(colour) \(isSelected) \(id)"}
}

struct SetGame {

    private (set) var cards = [SetCard]()
    private (set) var dealtCards = [SetCard]()
    
    mutating func deal12Cards() {
        var tempCards = [SetCard]()
        var id = 0
        for no in No.allCases {
            for symbol in Symbol.allCases {
                for shading in Shading.allCases {
                    for colour in Colour.allCases {
                        tempCards.append(SetCard(no: no, symbol: symbol, shading: shading, colour: colour, id: id))
                        id += 1
                    }
                }
            }
        }
        tempCards.shuffle()
        dealtCards = Array(tempCards.prefix(12))
        cards = Array(tempCards.suffix(from: 12))
    }

    mutating func select(_ card: SetCard) {
        if let chosenIndex = dealtCards.firstIndex(matching: card) {
            dealtCards[chosenIndex].isSelected.toggle()
        }
    }
}

extension Array {
    var only: Element? { count == 1 ? first : nil }
}
