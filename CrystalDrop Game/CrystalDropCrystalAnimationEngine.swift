import SwiftUI
import UIKit

// MARK: - Crystal Animation Engine Implementation for CrystalDrop Dropfall

class CrystalDropCrystalAnimationEngine {
    static let shared = CrystalDropCrystalAnimationEngine()
    
    private init() {}
    
    func createCrystalShimmerEffect() -> Animation {
        return Animation.easeInOut(duration: 1.8).repeatForever(autoreverses: true)
    }
    
    func createDropGlimmer() -> Animation {
        return Animation.linear(duration: 3.0).repeatForever(autoreverses: false)
    }
    
    func createPrismPulseEffect() -> Animation {
        return Animation.easeInOut(duration: 1.7).repeatForever(autoreverses: true)
    }
}

// MARK: - Crystal Particle System

struct CrystalDropCrystalParticle {
    let id = UUID()
    let x: CGFloat
    let y: CGFloat
    let opacity: Double
    let scale: CGFloat
    
    init(x: CGFloat, y: CGFloat, opacity: Double = 0.9, scale: CGFloat = 1.0) {
        self.x = x
        self.y = y
        self.opacity = opacity
        self.scale = scale
    }
}

class CrystalDropCrystalParticleSystem: ObservableObject {
    @Published var gemParticles: [CrystalDropCrystalParticle] = []
    
    func generateCrystalParticles(count: Int, width: CGFloat, height: CGFloat) {
        gemParticles = (0..<count).map { _ in
            CrystalDropCrystalParticle(
                x: CGFloat.random(in: 0...width),
                y: CGFloat.random(in: 0...height),
                opacity: Double.random(in: 0.4...1.0),
                scale: CGFloat.random(in: 0.6...1.8)
            )
        }
    }
    
    func updateCrystalParticlePositions() {
        gemParticles = gemParticles.map { particle in
            CrystalDropCrystalParticle(
                x: particle.x + CGFloat.random(in: -2.5...2.5),
                y: particle.y + CGFloat.random(in: -1.5...1.5),
                opacity: max(0.2, particle.opacity - 0.008),
                scale: particle.scale
            )
        }
    }
}

// MARK: - Crystal Transition Effect

struct CrystalDropCrystalTransitionEffect: ViewModifier {
    let isCrystalActive: Bool
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isCrystalActive ? 1.0 : 0.85)
            .opacity(isCrystalActive ? 1.0 : 0.7)
            .animation(CrystalDropCrystalAnimationEngine.shared.createCrystalShimmerEffect(), value: isCrystalActive)
    }
}
