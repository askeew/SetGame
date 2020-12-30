import SwiftUI


class SetGameViewModel: ObservableObject {

    @Published private var model: SetGame = SetGame()//MemoryGame<String> = MemoryGame<String>()
    // Property wrappern @published gör objectWillChange.send() så fort model ändrar sig.
    
//    init() {
//        model = SetGame()
//    }
    
    // MARK: -  Access to the model
    var cards: [SetCard] { model.dealtCards }
    

//    // MARK: - Intent(s)
//    func chooseCard(card: MemoryGame<String>.Card) {
//        model.choose(card: card)
//    }
//
    func resetGame() {
        model.deal12Cards()
    }
    
//    func deal12Cards() {
//
//    }
    
    
    //func compareThing1<T: Identifiable>(_ thing1: T, against thing2: T) -> Bool {
 
//    func toShape<S: Shape>(from symbol: S) -> S {
//        switch symbol {
//        case .diamond: return Diamond()
//        case .oval: return Oval()
//        case .squiggle: return Squiggle()
//        }
//    }
}

struct SetGameViewModel_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
