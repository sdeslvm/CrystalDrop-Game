import SwiftUI
import WebKit
import Combine

// MARK: - Crystal Gradient Renderer for CrystalDrop Dropfall

/// Protocol for gem gradient rendering
protocol CrystalDropCrystalGradientRenderer {
    func buildCrystalGradientLayer() -> CAGradientLayer
}

// MARK: - Crystal Container View Implementation

/// Crystal container view for CrystalDrop Dropfall
final class CrystalDropCrystalContainerView: UIView, CrystalDropCrystalGradientRenderer {
    // MARK: - Crystal Properties

    private let gemLayer = CAGradientLayer()

    // MARK: - Crystal Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeCrystalView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initializeCrystalView()
    }

    // MARK: - Crystal Methods

    private func initializeCrystalView() {
        layer.insertSublayer(buildCrystalGradientLayer(), at: 0)
    }

    func buildCrystalGradientLayer() -> CAGradientLayer {
        gemLayer.colors = [UIColor(gemHex: "#335D8D").cgColor]
        gemLayer.startPoint = CGPoint(x: 0, y: 0)
        gemLayer.endPoint = CGPoint(x: 1, y: 1)
        return gemLayer
    }

    // MARK: - Crystal Layout

    override func layoutSubviews() {
        super.layoutSubviews()
        gemLayer.frame = bounds
    }
}

// MARK: - Crystal UIColor Extensions

extension UIColor {
    convenience init(gemHex hexString: String) {
        let sanitizedHex =
            hexString
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")
            .uppercased()

        var colorValue: UInt64 = 0
        Scanner(string: sanitizedHex).scanHexInt64(&colorValue)

        let redComponent = CGFloat((colorValue & 0xFF0000) >> 16) / 255.0
        let greenComponent = CGFloat((colorValue & 0x00FF00) >> 8) / 255.0
        let blueComponent = CGFloat(colorValue & 0x0000FF) / 255.0

        self.init(red: redComponent, green: greenComponent, blue: blueComponent, alpha: 1.0)
    }
}

// MARK: - Crystal Web View Container

struct CrystalDropDropWebViewContainer: UIViewRepresentable {
    // MARK: - Crystal Properties

    let url: URL
    @StateObject private var loader: CrystalDropDropResourceLoader

    init(url: URL) {
        self.url = url
        _loader = StateObject(wrappedValue: CrystalDropDropResourceLoader(resourceURL: url))
    }

    // MARK: - Crystal Coordinator

    func makeCoordinator() -> CrystalDropDropWebCoordinator {
        CrystalDropDropWebCoordinator { [weak loader] status in
            DispatchQueue.main.async {
                loader?.gemState = status
            }
        }
    }

    // MARK: - Crystal UIView Creation

    func makeUIView(context: Context) -> WKWebView {
        let configuration = buildCrystalWebConfiguration()
        let webView = WKWebView(frame: .zero, configuration: configuration)

        configureCrystalWebViewStyle(webView)
        configureCrystalContainer(with: webView)

        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        loader.attachCrystalDropDropWebView { webView }
        loader.monitorCrystal(webView)

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Update gem web view as needed
    }

    // MARK: - Private Crystal Configuration Methods

    private func buildCrystalWebConfiguration() -> WKWebViewConfiguration {
        return CrystalDropDropWebViewConfigurationBuilder.createAdvancedCrystalConfiguration()
    }

    private func configureCrystalWebViewStyle(_ webView: WKWebView) {
        CrystalDropDropWebViewConfigurationBuilder.configureWebViewForCrystalDrop(webView)
    }

    private func configureCrystalContainer(with webView: WKWebView) {
        let containerView = CrystalDropCrystalContainerView()
        containerView.addSubview(webView)

        webView.frame = containerView.bounds
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    private func clearCrystalData() {
        CrystalDropDropWebDataManager.clearCrystalWebData()
    }
}
