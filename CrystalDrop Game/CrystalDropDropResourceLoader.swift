import Combine
import SwiftUI
import WebKit

// MARK: - Crystal Resource Loading Protocols

/// Protocol for managing gem web loading state
protocol CrystalWebLoadable: AnyObject {
    var gemState: CrystalDropDropWebStatus { get set }
    func setCrystalConnectivity(_ available: Bool)
}

/// Protocol for monitoring gem loading progress
protocol CrystalProgressMonitoring {
    func observeCrystalProgression()
    func monitorCrystal(_ webView: WKWebView)
}

// MARK: - Main Crystal Web View Loader

/// Class for managing gem web view loading and state for CrystalDrop Dropfall
final class CrystalDropDropResourceLoader: NSObject, ObservableObject, CrystalWebLoadable, CrystalProgressMonitoring {
    // MARK: - Crystal Properties

    @Published var gemState: CrystalDropDropWebStatus = .gemStandby
    @Published var isLoading: Bool = false
    @Published var loadingProgress: Double = 0.0

    let crystalEndpoint: URL
    private var gemSubscriptions = Set<AnyCancellable>()
    private var dropProgressStream = PassthroughSubject<Double, Never>()
    private var gemViewFactory: (() -> WKWebView)?

    // MARK: - Crystal Initialization

    init(resourceURL: URL) {
        self.crystalEndpoint = resourceURL
        super.init()
        observeCrystalProgression()
    }

    // MARK: - Public Crystal Methods

    /// Start loading process
    func startLoading() {
        isLoading = true
        loadingProgress = 0.0
        
        // Simulate loading progress
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.loadingProgress += 0.02
            if self.loadingProgress >= 1.0 {
                self.loadingProgress = 1.0
                self.isLoading = false
                timer.invalidate()
            }
        }
    }

    /// Attach gem web view to loader
    func attachCrystalDropDropWebView(factory: @escaping () -> WKWebView) {
        gemViewFactory = factory
        initiateCrystalLoad()
    }

    /// Set gem connectivity availability
    func setCrystalConnectivity(_ available: Bool) {
        switch (available, gemState) {
        case (true, .gemNoConnection):
            initiateCrystalLoad()
        case (false, _):
            gemState = .gemNoConnection
        default:
            break
        }
    }

    // MARK: - Private Crystal Loading Methods

    /// Start gem web view loading
    private func initiateCrystalLoad() {
        guard let webView = gemViewFactory?() else { return }

        let request = URLRequest(url: crystalEndpoint, timeoutInterval: 15)
        print("[CrystalDrop][Loader] Starting load for URL: \(crystalEndpoint.absoluteString)")
        gemState = .gemProgressing(progress: 0)

        webView.navigationDelegate = self
        webView.load(request)
        monitorCrystalProgress(webView)
    }

    // MARK: - Crystal Monitoring Methods

    /// Observe gem loading progress
    func observeCrystalProgression() {
        startCrystalProgressMonitoring()
    }
    
    private func startCrystalProgressMonitoring() {
        dropProgressStream
            .removeDuplicates()
            .sink { [weak self] progress in
                guard let self else { return }
                self.gemState = progress < 1.0 ? .gemProgressing(progress: progress) : .gemFinished
            }
            .store(in: &gemSubscriptions)
    }

    /// Monitor gem web view progress
    func monitorCrystal(_ webView: WKWebView) {
        monitorCrystalProgress(webView)
    }
    
    private func monitorCrystalProgress(_ webView: WKWebView) {
        webView.publisher(for: \.estimatedProgress)
            .sink { [weak self] progress in
                print("[CrystalDrop][Loader] Progress: \(progress)")
                self?.dropProgressStream.send(progress)
            }
            .store(in: &gemSubscriptions)
    }
}

// MARK: - Crystal Navigation Handling Extension

extension CrystalDropDropResourceLoader: WKNavigationDelegate {
    /// Handle gem navigation errors
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        handleCrystalNavigationError(error)
    }

    /// Handle gem provisional navigation errors
    func webView(
        _ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!,
        withError error: Error
    ) {
        handleCrystalNavigationError(error)
    }

    // MARK: - Private Crystal Error Handling Methods

    /// General gem navigation error handling method
    private func handleCrystalNavigationError(_ error: Error) {
        print("[CrystalDrop][Loader] Navigation error: \(error.localizedDescription)")
        gemState = .gemFailure(reason: error.localizedDescription)
    }
}

// MARK: - Crystal Extensions for Enhanced Functionality

extension CrystalDropDropResourceLoader {
    /// Create gem loader with safe URL
    convenience init?(urlString: String) {
        guard let url = URL(string: urlString) else { return nil }
        self.init(resourceURL: url)
    }
}
