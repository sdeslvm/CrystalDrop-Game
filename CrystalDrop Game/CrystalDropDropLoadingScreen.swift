import SwiftUI

// MARK: - Crystal Loading Screen Implementation for CrystalDrop Dropfall

protocol CrystalProgressDisplayable {
    var gemProgressPercentage: Int { get }
}

protocol CrystalBackgroundProviding {
    associatedtype CrystalBackgroundContent: View
    func makeCrystalBackground() -> CrystalBackgroundContent
}

// MARK: - CrystalDrop Drop Loading Overlay

struct CrystalDropDropLoadingOverlay: View, CrystalProgressDisplayable {
    @StateObject private var gemThemeEngine = CrystalDropCrystalThemeEngine.shared
    let gemProgress: Double
    @State private var gemPulse = false
    @State private var dropRotation: Double = 0
    @State private var prismScale: CGFloat = 1.0
    @State private var logoRotation: Double = 0
    var gemProgressPercentage: Int { Int(gemProgress * 100) }

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Primary gem background
                Color.gemDropTheme(hex: "#335D8D")
                    .ignoresSafeArea(.all)
                
                // Pinball gem particles
                ForEach(0..<8, id: \.self) { index in
                    PinballCrystal(index: index)
                }
                
                // Energy orbs
                ForEach(0..<5, id: \.self) { index in
                    EnergyOrb(index: index)
                }

                // Adaptive layout for portrait and landscape
                if geo.size.width > geo.size.height {
                    // Landscape orientation
                    HStack {
                        Spacer()
                        
                        // Crystal Drop Animation
                        ZStack {
                            ForEach(0..<12, id: \.self) { index in
                                Circle()
                                    .fill(
                                        RadialGradient(
                                            colors: [
                                                Color.gemDropTheme(hex: "#335D8D").opacity(0.9),
                                                Color.gemDropTheme(hex: "#4A6FA5").opacity(0.7),
                                                Color.gemDropTheme(hex: "#5B7FB8").opacity(0.5)
                                            ],
                                            center: .center,
                                            startRadius: 2,
                                            endRadius: 15
                                        )
                                    )
                                    .frame(width: 8, height: 8)
                                    .offset(
                                        x: cos(Double(index) * .pi / 6) * 40,
                                        y: sin(Double(index) * .pi / 6) * 40
                                    )
                                    .rotationEffect(.degrees(logoRotation + Double(index * 30)))
                            }
                            
                            Image("img9")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .scaleEffect(1.0 + sin(logoRotation * .pi / 180) * 0.1)
                        }
                        .frame(width: min(geo.size.width * 0.25, geo.size.height * 0.4))
                        .shadow(color: Color.gemDropTheme(hex: "#335D8D").opacity(0.8), radius: 20, y: 5)
                        .onAppear {
                            withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)) {
                                logoRotation = 360
                            }
                        }
                        
                        Spacer().frame(width: 80)
                        
                        // Logo section on the right
                        VStack(spacing: 30) {
                            Image("logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 100)
                                .shadow(color: gemThemeEngine.getPrimaryCrystalColor(), radius: 8)
                            
                            // Removed progress bar
                            
                            // Removed percentage text
                        }
                        .frame(maxWidth: geo.size.width * 0.4)
                        
                        Spacer()
                    }
                } else {
                    // Portrait orientation
                    VStack {
                        Spacer()
                        
                        // Crystal Drop Animation
                        ZStack {
                            ForEach(0..<12, id: \.self) { index in
                                Circle()
                                    .fill(
                                        RadialGradient(
                                            colors: [
                                                Color.gemDropTheme(hex: "#335D8D").opacity(0.9),
                                                Color.gemDropTheme(hex: "#4A6FA5").opacity(0.7),
                                                Color.gemDropTheme(hex: "#5B7FB8").opacity(0.5)
                                            ],
                                            center: .center,
                                            startRadius: 2,
                                            endRadius: 15
                                        )
                                    )
                                    .frame(width: 8, height: 8)
                                    .offset(
                                        x: cos(Double(index) * .pi / 6) * 40,
                                        y: sin(Double(index) * .pi / 6) * 40
                                    )
                                    .rotationEffect(.degrees(logoRotation + Double(index * 30)))
                            }
                            
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            Color.gemDropTheme(hex: "#FFFFFF"),
                                            Color.gemDropTheme(hex: "#335D8D"),
                                            Color.gemDropTheme(hex: "#4A6FA5")
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 80, height: 80)
                                .scaleEffect(1.0 + sin(logoRotation * .pi / 180) * 0.1)
                        }
                        .frame(width: min(geo.size.width * 0.4, 200), height: min(geo.size.width * 0.4, 200))
                        .shadow(color: Color.gemDropTheme(hex: "#335D8D").opacity(0.8), radius: 20, y: 5)
                        .onAppear {
                            withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)) {
                                logoRotation = 360
                            }
                        }
                        
                        Spacer().frame(height: 60)
                        
                        // Logo section at the bottom
                        VStack(spacing: 25) {
                            Image("logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 50)
                                .shadow(color: gemThemeEngine.getPrimaryCrystalColor(), radius: 8)
                            
                            // Removed progress bar
                            
                            // Removed percentage text
                        }
                        
                        Spacer()
                    }
                }
            }
        }
    }
}

// MARK: - Crystal Progress Bar

struct CrystalProgressBar: View {
    let progress: Double
    @StateObject private var gemTheme = CrystalDropCrystalThemeEngine.shared
    @State private var shimmerOffset: CGFloat = -1
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Background track
                RoundedRectangle(cornerRadius: 8)
                    .fill(gemTheme.getPrimaryCrystalColor().opacity(0.3))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(gemTheme.getSecondaryCrystalColor().opacity(0.5), lineWidth: 1)
                    )
                
                // Progress fill
                RoundedRectangle(cornerRadius: 8)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                gemTheme.getPrimaryCrystalColor(),
                                gemTheme.getSecondaryCrystalColor()
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: geometry.size.width * CGFloat(progress))
                    .overlay(
                        // Shimmer effect
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.clear,
                                        gemTheme.getAccentCrystalColor().opacity(0.6),
                                        Color.clear
                                    ]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .offset(x: shimmerOffset * geometry.size.width)
                            .onAppear {
                                withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                                    shimmerOffset = 1
                                }
                            }
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                // Pulsing gem core with yellow accents
                ZStack {
                    // Outer pulse ring
                    Circle()
                        .stroke(
                            Color.gemDropTheme(hex: CrystalDropCrystalColorPalette.accentYellow).opacity(0.8),
                            lineWidth: 4
                        )
                        .frame(width: 80, height: 80)
                        .scaleEffect(1.5)
                        .opacity(0.6)
                        .animation(.easeInOut(duration: 1.5).repeatForever(), value: progress)
                    
                    // Inner core
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    Color.gemDropTheme(hex: CrystalDropCrystalColorPalette.accentYellow),
                                    Color.gemDropTheme(hex: CrystalDropCrystalColorPalette.accentOrange),
                                    Color.gemDropTheme(hex: "#335D8D")
                                ],
                                center: .center,
                                startRadius: 5,
                                endRadius: 25
                            )
                        )
                        .frame(width: 50, height: 50)
                        .scaleEffect(1.2)
                        .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: progress)
                }
            }
        }
    }
}

// MARK: - Pinball Crystal Animation

struct PinballCrystal: View {
    let index: Int
    @State private var position: CGPoint = CGPoint(x: 0, y: 0)
    @State private var velocity: CGPoint = CGPoint(x: 0, y: 0)
    @State private var rotation: Double = 0
    @State private var scale: CGFloat = 1.0
    @State private var opacity: Double = 1.0
    
    var body: some View {
        Diamond()
            .fill(
                RadialGradient(
                    colors: [
                        Color.gemDropTheme(hex: CrystalDropCrystalColorPalette.accentYellow).opacity(0.9),
                        Color.gemDropTheme(hex: CrystalDropCrystalColorPalette.accentOrange).opacity(0.8),
                        Color.gemDropTheme(hex: "#335D8D").opacity(0.5)
                    ],
                    center: .center,
                    startRadius: 2,
                    endRadius: 12
                )
            )
            .frame(width: CGFloat.random(in: 12...20), height: CGFloat.random(in: 12...20))
            .rotationEffect(.degrees(rotation))
            .scaleEffect(scale)
            .opacity(opacity)
            .position(position)
            .onAppear {
                startPinballAnimation()
            }
    }
    
    private func startPinballAnimation() {
        position = CGPoint(
            x: CGFloat.random(in: 50...300),
            y: CGFloat.random(in: 100...600)
        )
        velocity = CGPoint(
            x: CGFloat.random(in: -3...3),
            y: CGFloat.random(in: -4...4)
        )
        
        animatePinball()
    }
    
    private func animatePinball() {
        withAnimation(.linear(duration: 0.016)) {
            position.x += velocity.x
            position.y += velocity.y
            
            if position.x <= 10 || position.x >= 340 {
                velocity.x *= -0.8
            }
            if position.y <= 50 || position.y >= 650 {
                velocity.y *= -0.8
            }
            
            position.x = max(10, min(340, position.x))
            position.y = max(50, min(650, position.y))
            
            velocity.y += 0.1
            
            rotation += Double.random(in: -5...5)
            scale = CGFloat.random(in: 0.8...1.2)
            opacity = Double.random(in: 0.6...1.0)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.016) {
            animatePinball()
        }
    }
}

// MARK: - Energy Orb Animation

struct EnergyOrb: View {
    let index: Int
    @State private var position: CGPoint = CGPoint(x: 175, y: 400)
    @State private var targetPosition: CGPoint = CGPoint(x: 175, y: 400)
    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 0.8
    
    var body: some View {
        Circle()
            .fill(
                RadialGradient(
                    colors: [
                        Color.gemDropTheme(hex: CrystalDropCrystalColorPalette.accentYellow).opacity(0.9),
                        Color.gemDropTheme(hex: CrystalDropCrystalColorPalette.accentOrange).opacity(0.7),
                        Color.clear
                    ],
                    center: .center,
                    startRadius: 0,
                    endRadius: 25
                )
            )
            .frame(width: 50, height: 50)
            .scaleEffect(scale)
            .opacity(opacity)
            .position(position)
            .blur(radius: 2)
            .onAppear {
                startOrbAnimation()
            }
    }
    
    private func startOrbAnimation() {
        let delay = Double(index) * 0.5
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            animateOrb()
        }
    }
    
    private func animateOrb() {
        targetPosition = CGPoint(
            x: CGFloat.random(in: 50...300),
            y: CGFloat.random(in: 100...600)
        )
        
        withAnimation(.easeInOut(duration: Double.random(in: 2...4))) {
            position = targetPosition
            scale = CGFloat.random(in: 0.3...1.5)
            opacity = Double.random(in: 0.4...1.0)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 2...4)) {
            animateOrb()
        }
    }
}

// MARK: - Entry Screen

struct CrystalDropDropLoadingScreen: View {
    @StateObject private var gemThemeEngine = CrystalDropCrystalThemeEngine.shared
    @StateObject private var dropAudioManager = CrystalDropDropAudioManager.shared
    @StateObject private var vibrationManager = CrystalDropVibrationManager.shared
    @State private var loadingProgress: Double = 0.0
    @State private var showWebView = false
    
    private var gemDropGameEndpoint: URL { URL(string: "https://crystaldropgame.com/start")! }
    
    var body: some View {
        ZStack {
            if !showWebView {
                CrystalDropDropLoadingOverlay(gemProgress: loadingProgress)
                    .onAppear {
                        startLoadingSequence()
                    }
            } else {
                CrystalDropDropWebViewContainer(url: gemDropGameEndpoint)
            }
        }
    }
    
    private func startLoadingSequence() {
        vibrationManager.gemSuccess()
        
        // Simulate loading progress
        withAnimation(.easeInOut(duration: 3.0)) {
            loadingProgress = 1.0
        }
        
        // Show webview after loading completes
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            withAnimation(.easeInOut(duration: 0.5)) {
                showWebView = true
            }
        }
    }
}
