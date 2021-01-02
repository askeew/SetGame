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
            HStack {
                Image(systemName: "rectangle.stack").font(.system(size: imageSize(for: size)))
                Text("\(viewModel.cardsLeft)")
                Spacer()
                Image(systemName: "sum").font(.system(size: imageSize(for: size)))
                Text("\(viewModel.score)")
            }.padding().foregroundColor(.orange).font(.system(size: fontSize(for: size), weight: .heavy))
            
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.easeInOut(duration: 0.75)) {
                        viewModel.select(card)
                    }
                }
                .transition(.offset(randomPointOffScreen(for: size)))
                .padding(5)
                .aspectRatio(2/3, contentMode: .fit)
                
            }.onAppear {
                withAnimation(.easeInOut(duration: 2)) {
                    viewModel.resetGame()
                }
            }
            
			HStack {
				Button(action:  {
					withAnimation(.easeInOut(duration: 2)) {
						viewModel.resetGame()
					}
				}) {
                    Image(systemName: "arrow.clockwise.circle.fill")
                        .font(.system(size: imageSize(for: size)))
				}
				Spacer()
				Button(action:  {
					withAnimation(.easeInOut(duration: 2)) {
						viewModel.deal()
					}
				}) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: imageSize(for: size)))
				}.disabled(viewModel.cardsLeft == 0)
            }.padding()
        }.padding()
		.accentColor(.orange)
    }

    private func imageSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.13
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.05
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
        ZStack {
            symbol
        }
        .numberify(card.no)
        .cardify(with: card.selection, and: card.colour)
    }
        
    @ViewBuilder
    var symbol: some View {
        switch card.symbol {
        case .diamond: Diamond().shader(card.shading, with: card.colour)
        case .oval: Oval().shader(card.shading, with: card.colour)
        case .squiggle: Squiggle().shader(card.shading, with: card.colour)
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
