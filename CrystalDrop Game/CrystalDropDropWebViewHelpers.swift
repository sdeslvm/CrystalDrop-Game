import Foundation
import WebKit
import SwiftUI

// MARK: - Crystal WebView Configuration Builder for CrystalDrop Dropfall

class CrystalDropDropWebViewConfigurationBuilder {
    static func createAdvancedCrystalConfiguration() -> WKWebViewConfiguration {
        let config = WKWebViewConfiguration()
        config.websiteDataStore = .default()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        config.suppressesIncrementalRendering = false
        config.processPool = WKProcessPool()
        
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        config.defaultWebpagePreferences = preferences
        
        return config
    }
    
    static func configureWebViewForCrystalDrop(_ webView: WKWebView) {
        webView.isOpaque = false
        webView.scrollView.bounces = false
        webView.scrollView.isScrollEnabled = true
        webView.allowsBackForwardNavigationGestures = true
        
        webView.configuration.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")
        webView.configuration.setValue(true, forKey: "allowUniversalAccessFromFileURLs")
    }
}

// MARK: - Crystal Web Data Manager

class CrystalDropDropWebDataManager {
    static func clearCrystalWebData() {
        let dataTypes: Set<String> = [
            WKWebsiteDataTypeDiskCache,
            WKWebsiteDataTypeMemoryCache,
            WKWebsiteDataTypeCookies,
            WKWebsiteDataTypeLocalStorage
        ]
        
        WKWebsiteDataStore.default().removeData(
            ofTypes: dataTypes,
            modifiedSince: .distantPast
        ) {}
    }
    
    static func configureCrystalDataStore() -> WKWebsiteDataStore {
        return .default()
    }
}

// MARK: - Crystal Extensions

extension String {
    static let gemCache = WKWebsiteDataTypeDiskCache
    static let gemMemory = WKWebsiteDataTypeMemoryCache
    static let gemCookies = WKWebsiteDataTypeCookies
    static let gemStorage = WKWebsiteDataTypeLocalStorage
}
