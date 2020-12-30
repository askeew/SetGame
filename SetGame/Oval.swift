import SwiftUI

struct Oval: Shape {
    
    let cornerRadius = CGFloat(25)
    let widthConstant: CGFloat = 6
    
    func path(in rect: CGRect) -> Path {
        let modifiedRect = CGRect(x: rect.minX + rect.width/widthConstant,
                                  y: rect.minY + rect.height/4,
                                  width: rect.width - 2*rect.width/widthConstant,
                                  height: rect.height - 2.5*rect.height/4)
        return RoundedRectangle(cornerRadius: cornerRadius).path(in: modifiedRect)
    }
}
