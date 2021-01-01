import SwiftUI


class SetGameViewModel: ObservableObject {

    @Published private var model: SetGame = SetGame()//MemoryGame<String> = MemoryGame<String>()
    // Property wrappern @published gör objectWillChange.send() så fort model ändrar sig.

    // MARK: -  Access to the model
    var cards: [SetCard] { model.dealtCards }
	var cardsLeft: Int { model.cardsLeft }
    

    // MARK: - Intent(s)
    func select(_ card: SetCard) {
        model.choose(card)
    }

    func resetGame() {
        model.deal12Cards()
    }

	func deal() {
		model.deal()
	}
}

struct SetGameViewModel_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
