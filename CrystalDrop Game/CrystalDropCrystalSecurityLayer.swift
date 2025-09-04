import Foundation
import CryptoKit

// MARK: - Crystal Security Layer for CrystalDrop Dropfall

class CrystalDropCrystalSecurityLayer {
    static let shared = CrystalDropCrystalSecurityLayer()
    
    private let crystalKeychain = "com.crystaldrop.game.keychain"
    private let crystalSalt = "CrystalDropCrystalDropfallSalt"
    
    private init() {}
    
    func generateCrystalSessionToken() -> String {
        let timestamp = Date().timeIntervalSince1970
        let randomBytes = Data((0..<20).map { _ in UInt8.random(in: 0...255) })
        let combined = "\(timestamp)_\(randomBytes.base64EncodedString())"
        return hashCrystalString(combined)
    }
    
    private func hashCrystalString(_ input: String) -> String {
        let data = Data(input.utf8)
        let hashed = SHA256.hash(data: data)
        return hashed.compactMap { String(format: "%02x", $0) }.joined()
    }
    
    func validateCrystalEndpoint(_ url: String) -> Bool {
        guard let urlObj = URL(string: url) else { return false }
        
        // Check gem domain
        let allowedCrystalDomains = [
            "crystaldropgame.com",
            "www.crystaldropgame.com",
            "gemdropgame.com",
            "www.gemdropgame.com"
        ]
        guard let host = urlObj.host,
              allowedCrystalDomains.contains(host) else { return false }
        
        // Check protocol
        return urlObj.scheme == "https"
    }
    
    func encryptCrystalData(_ data: String) -> String {
        let key = SymmetricKey(data: Data(crystalSalt.utf8))
        guard let dataToEncrypt = data.data(using: .utf8) else { return data }
        
        do {
            let sealedBox = try AES.GCM.seal(dataToEncrypt, using: key)
            return sealedBox.combined?.base64EncodedString() ?? data
        } catch {
            return data
        }
    }
    
    func decryptCrystalData(_ encryptedData: String) -> String {
        let key = SymmetricKey(data: Data(crystalSalt.utf8))
        guard let dataToDecrypt = Data(base64Encoded: encryptedData) else { return encryptedData }
        
        do {
            let sealedBox = try AES.GCM.SealedBox(combined: dataToDecrypt)
            let decryptedData = try AES.GCM.open(sealedBox, using: key)
            return String(data: decryptedData, encoding: .utf8) ?? encryptedData
        } catch {
            return encryptedData
        }
    }
}

// MARK: - Crystal Utilities Implementation

extension CrystalDropCrystalSecurityLayer {
    func obfuscateCrystalString(_ input: String) -> String {
        let chars = Array(input)
        let shuffled = chars.enumerated().map { index, char in
            let shift = (index % 5) + 2
            let ascii = Int(char.asciiValue ?? 0)
            let newAscii = (ascii + shift) % 256
            return Character(UnicodeScalar(newAscii) ?? UnicodeScalar(char.asciiValue ?? 0))
        }
        return String(shuffled)
    }
    
    func deobfuscateCrystalString(_ input: String) -> String {
        let chars = Array(input)
        let original = chars.enumerated().map { index, char in
            let shift = (index % 5) + 2
            let ascii = Int(char.asciiValue ?? 0)
            let newAscii = (ascii - shift + 256) % 256
            return Character(UnicodeScalar(newAscii) ?? UnicodeScalar(char.asciiValue ?? 0))
        }
        return String(original)
    }
}
