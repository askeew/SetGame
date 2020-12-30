import SwiftUI

struct Cardify: ViewModifier {
        
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white).shadow(radius: 6)
            content//.transition(.scale)
        }
    }
    
    private let cornerRadius = CGFloat(10)
    private let edgeLineWidth = CGFloat(0.5)
}

struct Colourify: ViewModifier {
    
    var colour: Colour
        
    func body(content: Content) -> some View {
        content.foregroundColor(colour.color)
    }
}

extension Colour {
    var color: Color {
        switch self {
        case .green: return .green
        case .purple: return .purple
        case .red: return .red
        }
    }
}

struct Numberify: ViewModifier {
    
    var no: No
    
    @ViewBuilder
    func body(content: Content) -> some View {
        switch no {
        case .one: VStack { content.opacity(0); content; content.opacity(0) }
        case .two: VStack { content; content }
        case .three: VStack { content; content; content }
        }
    }
}

extension View {
    func cardify() -> some View {
        self.modifier(Cardify())
    }
    
    func colorify(_ colour: Colour) -> some View {
        self.modifier(Colourify(colour: colour))
    }
    
    func numberify(_ no: No) -> some View {
        self.modifier(Numberify(no: no))
    }
}
