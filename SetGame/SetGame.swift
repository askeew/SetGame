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
    
    var isFaceUp = false
    var id: Int
    
    var description: String { "\(no) \(symbol) \(shading) \(colour) "}
}

struct SetGame {

    private (set) var cards = [SetCard]()
    private (set) var dealtCards = [SetCard]()

//    init() {
//        cards = [SetCard]()
//        var tempCards = [SetCard]()
//        var id = 0
//        for no in No.allCases {
//            for symbol in Symbol.allCases {
//                for shading in Shading.allCases {
//                    for colour in Colour.allCases {
//                        tempCards.append(SetCard(no: no, symbol: symbol, shading: shading, colour: colour, id: id))
//                        id += 1
//                    }
//                }
//            }
//        }
//        tempCards.shuffle()
//        dealtCards = Array(tempCards.prefix(12))
//        cards = Array(tempCards.suffix(from: 12))
////        print("all cards")
////        print(tempCards.count)
////        tempCards.forEach({print($0)})
////        print("dealt cards")
////        print(dealtCards.count)
////        dealtCards.forEach({print($0)})
////        print("left cards")
////        print(cards.count)
////        cards.forEach({print($0)})
//
//    }
    
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

//    mutating func choose(card: Card) {
//        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
//            if let potentialIndex = indexOfOneAndOnlyFaceUpCard {
//                if cards[chosenIndex].content == cards[potentialIndex].content {
//                    //match(chosenIndex, potentialIndex)
//                } else {
//                    //mismatch(card, facedUpCard: cards[potentialIndex])
//                }
//                cards[chosenIndex].isFaceUp = true
//            } else {
//                indexOfOneAndOnlyFaceUpCard = chosenIndex
//            }
//        }
//    }
//    
//
//    struct Card: Identifiable {
//        var isFaceUp = false
//        var isMatched = false
//        var content: String
//        var id: Int
//    }
}

extension Array {
    var only: Element? { count == 1 ? first : nil }
}
