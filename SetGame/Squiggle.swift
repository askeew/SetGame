import SwiftUI

struct Squiggle: Shape {
    
    let coefeccient = CGFloat(6)
    
    func path(in rect: CGRect) -> Path {
        let modifiedRect = CGRect(x: rect.minX + 1*rect.width/coefeccient, y: rect.minY + rect.midY/2, width: rect.width - 2*rect.width/coefeccient, height: rect.height/3)
        var path = Path()
        let one = CGPoint(x: modifiedRect.minX , y: modifiedRect.midY + modifiedRect.height/coefeccient)
        let two = CGPoint(x: modifiedRect.minX + modifiedRect.width/coefeccient, y: modifiedRect.maxY)
        let three = CGPoint(x: modifiedRect.midX - modifiedRect.width/coefeccient, y: modifiedRect.midY + modifiedRect.height/coefeccient)
        let four = CGPoint(x: modifiedRect.midX + modifiedRect.width/coefeccient, y: modifiedRect.maxY)
        let five = CGPoint(x: modifiedRect.maxX, y: modifiedRect.midY - modifiedRect.height/coefeccient)
        let six = CGPoint(x: modifiedRect.maxX - modifiedRect.width/coefeccient, y: modifiedRect.minY)
        let seven = CGPoint(x: modifiedRect.midX + modifiedRect.width/coefeccient, y: modifiedRect.minY + modifiedRect.height/coefeccient)
        let eight = CGPoint(x: modifiedRect.minX + 2*modifiedRect.width/coefeccient, y: modifiedRect.minY)
                     
        let twoOne = CGPoint(x: modifiedRect.minX, y: modifiedRect.midY + 2*modifiedRect.height/coefeccient)
        let twoTwo = CGPoint(x: modifiedRect.minX + modifiedRect.width/coefeccient/2, y: modifiedRect.maxY)
        
        let threeOne = CGPoint(x: modifiedRect.minX + 1.75*modifiedRect.width/coefeccient, y: modifiedRect.maxY)
        let threeTwo = CGPoint(x: modifiedRect.midX - 1.75*modifiedRect.width/coefeccient, y: modifiedRect.midY + modifiedRect.height/coefeccient)
        
        let fourOne = CGPoint(x: modifiedRect.midX + 0.25*modifiedRect.width/coefeccient, y: modifiedRect.midY + modifiedRect.height/coefeccient)
        let fourTwo = CGPoint(x: modifiedRect.midX + 0.55*modifiedRect.width/coefeccient, y: modifiedRect.maxY)
        
        let fiveOne = CGPoint(x: modifiedRect.maxX - modifiedRect.width/coefeccient, y: modifiedRect.maxY)
        let fiveTwo = CGPoint(x: modifiedRect.maxX, y: modifiedRect.midY + modifiedRect.height/coefeccient)
        
        let sixOne = CGPoint(x: modifiedRect.maxX, y: modifiedRect.midY - 1.5*modifiedRect.height/coefeccient)
        let sixTwo = CGPoint(x: modifiedRect.maxX - 0.25*modifiedRect.width/coefeccient, y: modifiedRect.minY)
        
        let sevenOne = CGPoint(x: modifiedRect.maxX - 1.5*modifiedRect.width/coefeccient, y: modifiedRect.minY)
        let sevenTwo = CGPoint(x: modifiedRect.midX + 1.5*modifiedRect.width/coefeccient, y: modifiedRect.minY + modifiedRect.height/coefeccient)
        
        let eightOne = CGPoint(x: modifiedRect.midX, y: modifiedRect.minY + modifiedRect.height/coefeccient)
        let eightTwo = CGPoint(x: modifiedRect.minX + 2.5*modifiedRect.width/coefeccient, y: modifiedRect.minY)
        
        let nineOne = CGPoint(x: modifiedRect.minX + 1.5*modifiedRect.width/coefeccient, y: modifiedRect.minY)
        let nineTwo = CGPoint(x: modifiedRect.minX, y: modifiedRect.midY)
        
        path.move(to: one)
        path.addCurve(to: two, control1: twoOne, control2: twoTwo)
        path.addCurve(to: three, control1: threeOne, control2: threeTwo)
        path.addCurve(to: four, control1: fourOne, control2: fourTwo)
        path.addCurve(to: five, control1: fiveOne, control2: fiveTwo)
        path.addCurve(to: six, control1: sixOne, control2: sixTwo)
        path.addCurve(to: seven, control1: sevenOne, control2: sevenTwo)
        path.addCurve(to: eight, control1: eightOne, control2: eightTwo)
        path.addCurve(to: one, control1: nineOne, control2: nineTwo)
        
        return path
    }
}
