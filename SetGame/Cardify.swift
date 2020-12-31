import SwiftUI

struct Cardify: ViewModifier {

    var selection: Selection

    var shadowRadius: CGFloat { selection != .none ? 3 : 8 }
    private let cornerRadius = CGFloat(10)
        
    @ViewBuilder
    func body(content: Content) -> some View {
        RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white).shadow(radius: shadowRadius)
        RoundedRectangle(cornerRadius: cornerRadius).stroke(selection.color, lineWidth: selection.lineWidth)
        content
    }
}

struct Colourify: ViewModifier {
    
    var colour: Colour
        
    func body(content: Content) -> some View {
        content.foregroundColor(colour.color)
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
    func cardify(with selection: Selection) -> some View {
        self.modifier(Cardify(selection: selection))
    }
    
    func colorify(_ colour: Colour) -> some View {
        self.modifier(Colourify(colour: colour))
    }
    
    func numberify(_ no: No) -> some View {
        self.modifier(Numberify(no: no))
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
                self.stroke(lineWidth: 2)
            }
        case .solid: self
        case .striped:
            Stripes(config: StripesConfig(background: .white, foreground: colour.color, degrees: 0, barWidth: 1, barSpacing: 2))
                .mask(self)
            self.stroke(lineWidth: 0.5)
        }
    }
}

extension Colour {
    var color: Color {
        switch self {
        case .blue: return .blue
        case .purple: return .purple
        case .red: return .red
        }
    }
}

extension Selection {
    var color: Color {
        switch self {
        case .none: return .clear
        case .selected: return .orange
        case .setMatched: return .green
        case .setNotMatched: return .red
        }
    }

    var lineWidth: CGFloat {
        switch self {
        case .none: return 0
        case .selected: return 0.5
        case .setMatched, .setNotMatched: return 2
        }
    }
}
