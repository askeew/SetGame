import Foundation

struct SetCard: CustomStringConvertible, Identifiable {
    let no: No
    let symbol: Symbol
    let shading: Shading
    let colour: Colour
    
    var selection = Selection.none
    var id: Int
    
    var description: String { "\(no) \(symbol) \(shading) \(colour) \(selection) \(id)"}

    func match(with secondCard: Self, and thirdCard: Self) -> Bool {
        if no.match(with: secondCard.no, and: thirdCard.no) &&
            symbol.match(with: secondCard.symbol, and: thirdCard.symbol) &&
            shading.match(with: secondCard.shading, and: thirdCard.shading) &&
            colour.match(with: secondCard.colour, and: thirdCard.colour) {
            return true
        }
        return false
    }
}

struct SetGame {

    private (set) var cards = [SetCard]()
    private (set) var dealtCards = [SetCard]()
    
    var selectedCardsIndices: [Int] {
        dealtCards.indices.filter { dealtCards[$0].selection != .none }
    }

    var currentSelection: Selection {
        if selectedCardsIndices.count == 3 {
            let currentSelections = selectedCardsIndices.map( { dealtCards[$0].selection } )
            if currentSelections.allSatisfy( { $0 == .setMatched } ) {
                return .setMatched
            }
            if currentSelections.allSatisfy( { $0 == .setNotMatched } ) {
                return .setNotMatched
            }
        }
        return .none
    }

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
        if currentSelection == .setNotMatched {
            selectedCardsIndices.forEach({ dealtCards[$0].selection = .none})

            if let chosenIndex = dealtCards.firstIndex(matching: card) {
                dealtCards[chosenIndex].selection = .selected
            }
        } else {
            if let chosenIndex = dealtCards.firstIndex(matching: card) {
                if card.selection != .none {
                    dealtCards[chosenIndex].selection = .none
                } else {
                    dealtCards[chosenIndex].selection = .selected
                }
            }
        }
        match()
    }

    func canSelect(_ card: SetCard) -> Bool {
        print("\(card.selection) \(selectedCardsIndices.count < 3)")
        return selectedCardsIndices.count < 3 //|| card.selection != .none
    }

	mutating func match() {
		if selectedCardsIndices.count == 3 {
			print("matching... ")

			let firstCard = dealtCards[selectedCardsIndices[0]]
			let secondCard = dealtCards[selectedCardsIndices[1]]
			let thirdCard = dealtCards[selectedCardsIndices[2]]
			if firstCard.match(with: secondCard, and: thirdCard) {
				print("match!")
				selectedCardsIndices.forEach { dealtCards[$0].selection = .setMatched }
			} else {
				print("not matched!")
				selectedCardsIndices.forEach { dealtCards[$0].selection = .setNotMatched }
			}
		}
	}

}

extension Equatable {
	func match(with second: Self, and third: Self) -> Bool {
		if (self == second && self != third) || (self != second && self == third) {
			return false
		}
		print("\(self) \(second) \(third) match")
		return true
	}
}

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
    case red, blue, purple
}

enum Selection {
    case none, selected, setMatched, setNotMatched
}


extension Array {
    var only: Element? { count == 1 ? first : nil }
}
