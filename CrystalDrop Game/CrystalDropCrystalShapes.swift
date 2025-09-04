import SwiftUI

// MARK: - Crystal Shapes Implementation for CrystalDrop Game

struct CrystalStar: Shape {
    let points: Int
    let innerRadius: Double
    let outerRadius: Double
    
    init(points: Int = 5, innerRadius: Double = 0.4, outerRadius: Double = 1.0) {
        self.points = points
        self.innerRadius = innerRadius
        self.outerRadius = outerRadius
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = min(rect.width, rect.height) / 2
        
        let angleStep = Double.pi / Double(points)
        
        for i in 0..<(points * 2) {
            let angle = Double(i) * angleStep - Double.pi / 2
            let currentRadius = i % 2 == 0 ? outerRadius : innerRadius
            
            let x = center.x + CGFloat(cos(angle) * currentRadius * Double(radius))
            let y = center.y + CGFloat(sin(angle) * currentRadius * Double(radius))
            
            if i == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        path.closeSubpath()
        return path
    }
}

struct CrystalGem: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        
        // Create gem shape with facets
        path.move(to: CGPoint(x: width * 0.5, y: 0))
        path.addLine(to: CGPoint(x: width * 0.8, y: height * 0.3))
        path.addLine(to: CGPoint(x: width, y: height * 0.6))
        path.addLine(to: CGPoint(x: width * 0.7, y: height))
        path.addLine(to: CGPoint(x: width * 0.3, y: height))
        path.addLine(to: CGPoint(x: 0, y: height * 0.6))
        path.addLine(to: CGPoint(x: width * 0.2, y: height * 0.3))
        path.closeSubpath()
        
        return path
    }
}
