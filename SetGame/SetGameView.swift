import SwiftUI

struct SetGameView: View {
    @ObservedObject var viewModel: SetGameViewModel
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        VStack {
            Text("Set Game")
            
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        viewModel.select(card)
                    }
                }
                .transition(.offset(randomPointOffScreen(for: size)))
                .padding(5)
                .aspectRatio(2/3, contentMode: .fit)
                
            }.onAppear {
                withAnimation(Animation.easeInOut(duration: 2)) {
                    viewModel.resetGame()
                }
            }.padding()
            
            Button(action:  {
                withAnimation(.easeInOut(duration: 2)) {
                    viewModel.resetGame()
                }
            }) {
                Text("New Game")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.orange)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.orange, lineWidth: 1)
                    )
            }
        }.padding()
    }
    
    private func randomPointOffScreen(for screen: CGSize) -> CGSize {
        let width = Int(screen.width)
        let height = Int(screen.height)
        let newWidth = Int.random(in: width...width * 3)
        let newHeight = Int.random(in: height...height * 3)
        let positiveX = Bool.random()
        let positiveY = Bool.random()
        
        switch (positiveX, positiveY) {
            case (true, true): return CGSize(width: newWidth, height: newHeight)
            case (true, false): return CGSize(width: newWidth, height: -1 * newHeight)
            case (false, true): return CGSize(width: -1 * newWidth, height: newHeight)
            case (false, false): return CGSize(width: -1 * newWidth, height: -1 * newHeight)
        }
    }
}


struct CardView: View {

    var card: SetCard

    var body: some View {
        GeometryReader { geometry in            
            self.body(for: geometry.size)
        }
    }
    
    private func body(for size: CGSize) -> some View {
        ZStack {
            symbol
        }
        .numberify(card.no)
        .colorify(card.colour)
        .cardify(isSelected: card.isSelected)
    }
    
    @ViewBuilder
    var symbol: some View {
        switch card.symbol {
        case .diamond: Diamond(no: card.no).shader(card.shading, with: card.colour)
        case .oval: Oval().shader(card.shading, with: card.colour)
        case .squiggle: Squiggle().shader(card.shading, with: card.colour)
        }
    }
}

extension Shape {
    
    var lineWidth: CGFloat { 1 }
    
    @ViewBuilder
    func shader(_ shade: Shading, with colour: Colour) -> some View {
        switch shade {
        case .open:
            ZStack {
                self.fill(Color.white)
                self.stroke(lineWidth: lineWidth)
            }
        case .solid: self
        case .striped:
            Stripes(config: StripesConfig(background: .white, foreground: colour.color, degrees: 0, barWidth: 1, barSpacing: 2))
                .mask(self)
            self.stroke(lineWidth: lineWidth)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(viewModel: SetGameViewModel())
    }
}

extension Int: Identifiable {
    public var id: Int { self }
}
