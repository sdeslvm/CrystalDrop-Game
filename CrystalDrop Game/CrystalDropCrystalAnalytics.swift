import Foundation
import UIKit

// MARK: - Crystal Analytics Implementation for CrystalDrop Dropfall

class CrystalDropCrystalAnalytics: ObservableObject {
    static let shared = CrystalDropCrystalAnalytics()
    
    @Published var gemSessionStartTime: Date = Date()
    @Published var dropfallPlayTime: TimeInterval = 0
    @Published var totalCrystalLaunches: Int = 0
    @Published var prismCrashReports: [CrystalDropCrystalCrashReport] = []
    
    private let crystalDefaults = UserDefaults.standard
    private let gemSecurityLayer = CrystalDropCrystalSecurityLayer.shared
    
    struct CrystalDropCrystalCrashReport: Codable {
        let timestamp: Date
        let errorDescription: String
        let stackTrace: String
        let gemDeviceInfo: CrystalDropCrystalDeviceInfo
    }
    
    struct CrystalDropCrystalDeviceInfo: Codable {
        let deviceModel: String
        let systemVersion: String
        let appVersion: String
        let memoryUsage: UInt64
        
        init() {
            self.deviceModel = UIDevice.current.model
            self.systemVersion = UIDevice.current.systemVersion
            self.appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "3.0"
            self.memoryUsage = CrystalDropCrystalAnalytics.getCrystalMemoryUsage()
        }
    }
    
    private init() {
        loadCrystalAnalyticsData()
        incrementCrystalLaunchCount()
    }
    
    private func loadCrystalAnalyticsData() {
        totalCrystalLaunches = crystalDefaults.integer(forKey: "CrystalDropCrystalTotalLaunches")
        
        if let crashData = crystalDefaults.data(forKey: "CrystalDropCrystalCrashReports"),
           let reports = try? JSONDecoder().decode([CrystalDropCrystalCrashReport].self, from: crashData) {
            prismCrashReports = reports
        }
    }
    
    private func incrementCrystalLaunchCount() {
        totalCrystalLaunches += 1
        crystalDefaults.set(totalCrystalLaunches, forKey: "CrystalDropCrystalTotalLaunches")
    }
    
    func recordCrystalGameSession(duration: TimeInterval) {
        dropfallPlayTime += duration
        crystalDefaults.set(dropfallPlayTime, forKey: "CrystalDropCrystalGamePlayTime")
    }
    
    func recordCrystalCrash(error: Error, stackTrace: String = "") {
        let crashReport = CrystalDropCrystalCrashReport(
            timestamp: Date(),
            errorDescription: error.localizedDescription,
            stackTrace: stackTrace,
            gemDeviceInfo: CrystalDropCrystalDeviceInfo()
        )
        
        prismCrashReports.append(crashReport)
        
        // Keep only last 12 gem crash reports
        if prismCrashReports.count > 12 {
            prismCrashReports.removeFirst()
        }
        
        saveCrystalCrashReports()
    }
    
    private func saveCrystalCrashReports() {
        if let data = try? JSONEncoder().encode(prismCrashReports) {
            crystalDefaults.set(data, forKey: "CrystalDropCrystalCrashReports")
        }
    }
    
    static func getCrystalMemoryUsage() -> UInt64 {
        var info = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size)/4
        
        let kerr: kern_return_t = withUnsafeMutablePointer(to: &info) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                task_info(mach_task_self_, task_flavor_t(MACH_TASK_BASIC_INFO), $0, &count)
            }
        }
        
        if kerr == KERN_SUCCESS {
            return info.resident_size
        } else {
            return 0
        }
    }
    
    func generateCrystalAnalyticsReport() -> String {
        return """
        CrystalDrop Dropfall Crystal Analytics Report
        ==========================================
        Total Crystal Launches: \(totalCrystalLaunches)
        Total Dropfall Play Time: \(String(format: "%.1f", dropfallPlayTime)) seconds
        Crystal Session Start: \(gemSessionStartTime)
        Prism Crash Reports: \(prismCrashReports.count)
        Crystal Memory Usage: \(CrystalDropCrystalAnalytics.getCrystalMemoryUsage() / 1024 / 1024) MB
        """
    }
}
