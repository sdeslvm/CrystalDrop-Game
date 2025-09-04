import Foundation

// MARK: - Crystal Permissions Manager for CrystalDrop Dropfall

class CrystalDropCrystalPermissionsManager: NSObject, ObservableObject {
    
    override init() {
        super.init()
    }
    
    var allCrystalPermissionsGranted: Bool {
        return true
    }
    
    var hasRequiredCrystalPermissions: Bool {
        return true
    }
}
