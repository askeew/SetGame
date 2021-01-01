import SwiftUI

struct Diamond: Shape {
    
    let heightCoeffecient = CGFloat(5)
    let widthCoeffecient = CGFloat(6)
    
    func path(in rect: CGRect) -> Path {
        let dividedRect = CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: rect.height)
        
        let topDiamond = CGPoint(x: dividedRect.midX, y: dividedRect.midY - dividedRect.height/heightCoeffecient)
        let leftDiamond = CGPoint(x: dividedRect.width/widthCoeffecient, y: dividedRect.midY)
        let bottomDiamond = CGPoint(x: dividedRect.midX, y: dividedRect.midY + dividedRect.height/heightCoeffecient)
        let rightDiamond = CGPoint(x: dividedRect.width - dividedRect.width/widthCoeffecient, y: dividedRect.midY)
        
        var p = Path()
        p.move(to: topDiamond)
        p.addLine(to: leftDiamond)
        p.addLine(to: bottomDiamond)
        p.addLine(to: rightDiamond)
        p.addLine(to: topDiamond)
        return p
    }
}
