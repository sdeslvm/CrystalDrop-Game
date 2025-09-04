import SwiftUI

// MARK: - Crystal Logo Animation Implementation for CrystalDrop Dropfall

struct CrystalDropDropLogoAnimation: View {
    @State private var isCrystalAnimating = false
    @State private var dropRotationAngle: Double = 0
    @State private var gemScale: CGFloat = 0.5
    @State private var prismOpacity: Double = 0
    @State private var gemOffset: CGFloat = 0
    @State private var dropPulseScale: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            // Crystal background particles
            ForEach(0..<25, id: \.self) { index in
                Circle()
                    .fill(Color.gemDropTheme(hex: CrystalDropCrystalColorPalette.lightDark))
                    .frame(width: CGFloat.random(in: 3...8))
                    .position(
                        x: CGFloat.random(in: 0...350),
                        y: CGFloat.random(in: 0...650)
                    )
                    .opacity(isCrystalAnimating ? 0.7 : 0)
                    .animation(
                        Animation.easeInOut(duration: Double.random(in: 2.5...5))
                            .repeatForever(autoreverses: true)
                            .delay(Double.random(in: 0...2.5)),
                        value: isCrystalAnimating
                    )
            }
            
            VStack(spacing: 25) {
                // Main gem logo
                ZStack {
                    // Outer gem ring
                    Circle()
                        .stroke(
                            LinearGradient(
                                colors: [
                                    Color.gemDropTheme(hex: CrystalDropCrystalColorPalette.primaryDark),
                                    Color.gemDropTheme(hex: CrystalDropCrystalColorPalette.secondaryDark)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 10
                        )
                        .frame(width: 130, height: 130)
                        .scaleEffect(dropPulseScale)
                        .animation(
                            Animation.easeInOut(duration: 2.2)
                                .repeatForever(autoreverses: true),
                            value: dropPulseScale
                        )
                    
                    // Inner gem hexagon
                    Hexagon()
                        .stroke(
                            LinearGradient(
                                colors: [
                                    Color.gemDropTheme(hex: CrystalDropCrystalColorPalette.accentDark),
                                    Color.gemDropTheme(hex: CrystalDropCrystalColorPalette.highlightDark)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            ),
                            lineWidth: 6
                        )
                        .frame(width: 80, height: 80)
                        .rotationEffect(.degrees(dropRotationAngle))
                    
                    // Central gem icon
                    ZStack {
                        // Crystal background
                        Circle()
                            .fill(
                                RadialGradient(
                                    colors: [
                                        Color.gemDropTheme(hex: CrystalDropCrystalColorPalette.lightDark),
                                        Color.gemDropTheme(hex: CrystalDropCrystalColorPalette.primaryDark)
                                    ],
                                    center: .center,
                                    startRadius: 12,
                                    endRadius: 55
                                )
                            )
                            .frame(width: 110, height: 110)
                        
                        // Crystal drop icon from Assets
                        Image("CrystalDropDropLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                            .rotationEffect(.degrees(-dropRotationAngle * 0.5))
                            .scaleEffect(gemScale)
                    }
                }
                .scaleEffect(gemScale)
                .opacity(prismOpacity)
                
                // App name
                VStack(spacing: 8) {
                    Text("CrystalDrop")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(Color.gemDropTheme(hex: CrystalDropCrystalColorPalette.darkBlue))
                        .offset(x: gemOffset)
                    
                    Text("Dropfall")
                        .font(.system(size: 26, weight: .medium, design: .rounded))
                        .foregroundColor(Color.gemDropTheme(hex: CrystalDropCrystalColorPalette.secondaryDark))
                        .offset(x: -gemOffset)
                }
                .opacity(prismOpacity)
                
                // Crystal loading indicator
                HStack(spacing: 10) {
                    ForEach(0..<4) { index in
                        Diamond()
                            .fill(Color.gemDropTheme(hex: CrystalDropCrystalColorPalette.primaryDark))
                            .frame(width: 14, height: 14)
                            .scaleEffect(isCrystalAnimating ? 1.3 : 0.7)
                            .animation(
                                Animation.easeInOut(duration: 0.7)
                                    .repeatForever(autoreverses: true)
                                    .delay(Double(index) * 0.25),
                                value: isCrystalAnimating
                            )
                    }
                }
                .opacity(prismOpacity)
            }
        }
        .onAppear {
            startCrystalAnimation()
        }
    }
    
    private func startCrystalAnimation() {
        // Initial appearance animation
        withAnimation(.easeOut(duration: 1.2)) {
            prismOpacity = 1.0
            gemScale = 1.0
        }
        
        // Crystal rotation animation
        withAnimation(.linear(duration: 10.0).repeatForever(autoreverses: false)) {
            dropRotationAngle = 360
        }
        
        // Crystal pulse animation
        withAnimation(.easeInOut(duration: 2.2).repeatForever(autoreverses: true)) {
            dropPulseScale = 1.15
        }
        
        // Crystal text sway animation
        withAnimation(.easeInOut(duration: 3.5).repeatForever(autoreverses: true)) {
            gemOffset = 12
        }
        
        // Activate gem loading indicators
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            isCrystalAnimating = true
        }
    }
}

// MARK: - Custom Crystal Shapes

struct Hexagon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        
        for i in 0..<6 {
            let angle = Double(i) * .pi / 3
            let point = CGPoint(
                x: center.x + radius * CGFloat(cos(angle)),
                y: center.y + radius * sin(angle)
            )
            
            if i == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        path.closeSubpath()
        return path
    }
}

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let width = rect.width / 2
        let height = rect.height / 2
        
        path.move(to: CGPoint(x: center.x, y: center.y - height))
        path.addLine(to: CGPoint(x: center.x + width, y: center.y))
        path.addLine(to: CGPoint(x: center.x, y: center.y + height))
        path.addLine(to: CGPoint(x: center.x - width, y: center.y))
        path.closeSubpath()
        
        return path
    }
}

struct CrystalDropDropSplashScreen: View {
    @State private var showMainApp = false
    @State private var gemAnimationComplete = false
    
    var body: some View {
        ZStack {
            // Crystal background gradient
            LinearGradient(
                colors: [
                    Color.gemDropTheme(hex: CrystalDropCrystalColorPalette.darkBlue),
                    Color.gemDropTheme(hex: CrystalDropCrystalColorPalette.primaryDark),
                    Color.gemDropTheme(hex: CrystalDropCrystalColorPalette.lightDark)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            if !showMainApp {
                CrystalDropDropLogoAnimation()
                    .transition(.asymmetric(
                        insertion: .scale.combined(with: .opacity),
                        removal: .scale.combined(with: .opacity)
                    ))
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                withAnimation(.easeInOut(duration: 1.2)) {
                    showMainApp = true
                }
            }
        }
    }
}

#Preview {
    CrystalDropDropSplashScreen()
}
