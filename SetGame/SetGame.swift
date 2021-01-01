import Foundation

struct SetGame {

	private (set) var deck: [SetCard]
	private (set) var dealtCards: [SetCard]
    private (set) var score = 0

	var cardsLeft: Int { deck.count }

    var selectedCardsIndices: [Int] {
        dealtCards.indices.filter { dealtCards[$0].selection != .none }
    }

    var currentSelection: Selection {
        if selectedCardsIndices.count == 3 {
            let currentSelections = selectedCardsIndices.map { dealtCards[$0].selection }
            if currentSelections.allSatisfy( { $0 == .setMatched } ) {
                return .setMatched
            }
            if currentSelections.allSatisfy( { $0 == .setNotMatched } ) {
                return .setNotMatched
            }
        }
        return .none
    }

	init(deck: [SetCard] = [SetCard](), dealtCards: [SetCard] = [SetCard]()) {
		self.deck = deck
		self.dealtCards = dealtCards
	}

    mutating func deal12Cards() {
        score = 0
        deck = [SetCard]()
		dealtCards = [SetCard]()
        var id = 0
        for no in No.allCases {
            for symbol in Symbol.allCases {
                for shading in Shading.allCases {
                    for colour in Colour.allCases {
				deck.append(SetCard(no: no, symbol: symbol, shading: shading, colour: colour, id: id))
                        id += 1
                    }
                }
            }
        }

		deck.shuffle()

        
        repeater(12) {
            guard !deck.isEmpty else { return }
            dealtCards.append(deck.removeFirst())
        }
    }

    mutating func deal(reduceScore: Bool = true) { // TODO make closure what to do, skicka in 3/12
        if reduceScore {
            score -= 1
        }
		
        repeater(3) {
            guard !deck.isEmpty else { return }
			dealtCards.append(deck.removeFirst())
		}
	}
    
    private func repeater(_ times: Int, action: () -> Void) {
        for _ in 1...times {
            action()
        }
    }

    mutating func choose(_ card: SetCard) {
        if currentSelection == .setNotMatched {
			deselectCards()
			select(card)
			match()
		} else if currentSelection == .setMatched {
			removeSelectedCards()
			select(card)
			deal(reduceScore: false)
		} else {
            if let chosenIndex = dealtCards.firstIndex(matching: card) {
                if card.selection != .none {
                    dealtCards[chosenIndex].selection = .none
                } else {
                    dealtCards[chosenIndex].selection = .selected
                }
				match()
            }
        }
    }

	mutating private func deselectCards() {
		selectedCardsIndices.forEach { dealtCards[$0].selection = .none }
	}

	mutating private func select(_ card: SetCard) {
		guard let chosenIndex = dealtCards.firstIndex(matching: card) else { return }
		dealtCards[chosenIndex].selection = .selected
	}

	mutating private func removeSelectedCards() {
		guard selectedCardsIndices.count == 3 else { return }
		let firstMatch = dealtCards[selectedCardsIndices[0]]
		let secondMatch = dealtCards[selectedCardsIndices[1]]
		let thirdMatch = dealtCards[selectedCardsIndices[2]]
		dealtCards.remove(firstMatch)
		dealtCards.remove(secondMatch)
		dealtCards.remove(thirdMatch)
	}

	mutating private func match() {
		if selectedCardsIndices.count == 3 {
			print("matching... ")

			let firstCard = dealtCards[selectedCardsIndices[0]]
			let secondCard = dealtCards[selectedCardsIndices[1]]
			let thirdCard = dealtCards[selectedCardsIndices[2]]
			if firstCard.match(with: secondCard, and: thirdCard) {
				print("match!")
				selectedCardsIndices.forEach { dealtCards[$0].selection = .setMatched }
                score += 3
			} else {
				print("not matched!")
				selectedCardsIndices.forEach { dealtCards[$0].selection = .setNotMatched }
                score -= 1
			}
		}
	}
}

struct SetCard: CustomStringConvertible, Identifiable {
	let no: No
	let symbol: Symbol
	let shading: Shading
	let colour: Colour

	var selection = Selection.none
	var id: Int

	var description: String { "\(no) \(symbol) \(shading) \(colour) \(selection) \(id)"}

	func match(with secondCard: Self, and thirdCard: Self) -> Bool {

		let matchedNo = no.match(with: secondCard.no, and: thirdCard.no)
		let matchedSymbol = symbol.match(with: secondCard.symbol, and: thirdCard.symbol)
		let matchShading = shading.match(with: secondCard.shading, and: thirdCard.shading)
		let matchColour = colour.match(with: secondCard.colour, and: thirdCard.colour)
		if matchedNo && matchedSymbol && matchShading && matchColour {
			return true
		}
		return false
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

extension Equatable {
	func match(with second: Self, and third: Self) -> Bool {
		// All the same or all different
		if self == second && self == third {
			print("Match! All the same \(self) \(second) \(third)")
			return true
		} else if self != second && second != third {
			print("Match! All different \(self) \(second) \(third)")
			return true
		}
		print("Not Matched! \(self) \(second) \(third)")
		return false
	}
}
