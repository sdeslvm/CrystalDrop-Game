import Foundation

// MARK: - Crystal Web Status Extensions for CrystalDrop Dropfall

/// Protocol for gem web status comparison
protocol CrystalWebStatusComparable {
    func isCrystalEquivalent(to other: Self) -> Bool
}

// MARK: - Crystal Web Status Enumeration

/// Crystal web status enumeration for CrystalDrop Dropfall
enum CrystalDropDropWebStatus: Equatable, CrystalWebStatusComparable {
    case gemStandby
    case gemProgressing(progress: Double)
    case gemFinished
    case gemFailure(reason: String)
    case gemNoConnection

    // MARK: - Crystal Status Comparison

    func isCrystalEquivalent(to other: CrystalDropDropWebStatus) -> Bool {
        switch (self, other) {
        case (.gemStandby, .gemStandby),
            (.gemFinished, .gemFinished),
            (.gemNoConnection, .gemNoConnection):
            return true
        case let (.gemProgressing(a), .gemProgressing(b)):
            return abs(a - b) < 0.0001
        case let (.gemFailure(reasonA), .gemFailure(reasonB)):
            return reasonA == reasonB
        default:
            return false
        }
    }

    // MARK: - Crystal Status Properties

    var gemProgress: Double? {
        guard case let .gemProgressing(value) = self else { return nil }
        return value
    }

    var isCrystalSuccessful: Bool {
        switch self {
        case .gemFinished: return true
        default: return false
        }
    }

    var hasCrystalError: Bool {
        switch self {
        case .gemFailure, .gemNoConnection: return true
        default: return false
        }
    }
}

// MARK: - Crystal Status Extensions

extension CrystalDropDropWebStatus {
    var gemErrorReason: String? {
        guard case let .gemFailure(reason) = self else { return nil }
        return reason
    }
    
    /// Debug description of gem status
    var gemDebugDescription: String {
        switch self {
        case .gemStandby:
            return "Crystal Standby"
        case .gemProgressing(let progress):
            return "Crystal Loading \(Int(progress * 100))%"
        case .gemFinished:
            return "Crystal Completed"
        case .gemFailure(let reason):
            return "Crystal Error: \(reason)"
        case .gemNoConnection:
            return "Crystal No Connection"
        }
    }
}

// MARK: - Custom Crystal Equatable Implementation

extension CrystalDropDropWebStatus {
    static func == (lhs: CrystalDropDropWebStatus, rhs: CrystalDropDropWebStatus) -> Bool {
        lhs.isCrystalEquivalent(to: rhs)
    }
}
