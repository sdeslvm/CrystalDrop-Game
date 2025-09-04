import Foundation
import WebKit

class CrystalDropDropWebCoordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
    private let gemCallback: (CrystalDropDropWebStatus) -> Void
    private var gemDidStart = false

    init(onCrystalStatus: @escaping (CrystalDropDropWebStatus) -> Void) {
        self.gemCallback = onCrystalStatus
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        if !gemDidStart { gemCallback(.gemProgressing(progress: 0.0)) }
    }

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        gemDidStart = false
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        gemCallback(.gemFinished)
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        gemCallback(.gemFailure(reason: error.localizedDescription))
    }

    func webView(
        _ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!,
        withError error: Error
    ) {
        gemCallback(.gemFailure(reason: error.localizedDescription))
    }

    func webView(
        _ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        if navigationAction.navigationType == .other && webView.url != nil {
            gemDidStart = true
        }
        decisionHandler(.allow)
    }

    // MARK: - WKUIDelegate Crystal Implementation

    func webView(
        _ webView: WKWebView, requestMediaCapturePermissionFor origin: WKSecurityOrigin,
        initiatedByFrame frame: WKFrameInfo, type: WKMediaCaptureType,
        decisionHandler: @escaping (WKPermissionDecision) -> Void
    ) {
        // Automatically grant access to camera and microphone for gem experience
        decisionHandler(.grant)
    }

    @available(iOS 15.0, *)
    func webView(
        _ webView: WKWebView,
        requestDeviceOrientationAndMotionPermissionFor origin: WKSecurityOrigin,
        initiatedByFrame frame: WKFrameInfo,
        decisionHandler: @escaping (WKPermissionDecision) -> Void
    ) {
        decisionHandler(.grant)
    }

    func webView(
        _ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String,
        initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void
    ) {
        completionHandler()
    }

    func webView(
        _ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String,
        initiatedByFrame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void
    ) {
        completionHandler(true)
    }
}
