import Foundation
import AVFoundation
import UIKit

// MARK: - Crystal Audio Manager Implementation for CrystalDrop Dropfall

class CrystalDropDropAudioManager: NSObject, ObservableObject {
    static let shared = CrystalDropDropAudioManager()
    
    @Published var isCrystalMuted: Bool = false
    @Published var gemVolume: Float = 1.0
    @Published var isCrystalAudioSessionActive: Bool = false
    
    private var gemAudioEngine: AVAudioEngine?
    private var dropPlayerNode: AVAudioPlayerNode?
    private var gemAudioFile: AVAudioFile?
    
    private let crystalDefaults = UserDefaults.standard
    
    override init() {
        super.init()
        setupCrystalAudioSession()
        loadCrystalAudioSettings()
    }
    
    private func setupCrystalAudioSession() {
        do {
            let gemAudioSession = AVAudioSession.sharedInstance()
            try gemAudioSession.setCategory(.playback, mode: .default, options: [.allowBluetooth])
            try gemAudioSession.setActive(true)
            isCrystalAudioSessionActive = true
            
            setupCrystalAudioEngine()
        } catch {
            print("Failed to setup gem audio session: \(error)")
            isCrystalAudioSessionActive = false
        }
    }
    
    private func setupCrystalAudioEngine() {
        gemAudioEngine = AVAudioEngine()
        dropPlayerNode = AVAudioPlayerNode()
        
        guard let engine = gemAudioEngine, let player = dropPlayerNode else { return }
        
        engine.attach(player)
        engine.connect(player, to: engine.mainMixerNode, format: nil)
        
        do {
            try engine.start()
        } catch {
            print("Failed to start gem audio engine: \(error)")
        }
    }
    
    private func loadCrystalAudioSettings() {
        isCrystalMuted = crystalDefaults.bool(forKey: "CrystalDropCrystalAudioMuted")
        gemVolume = crystalDefaults.float(forKey: "CrystalDropCrystalAudioVolume")
        if gemVolume == 0 { gemVolume = 1.0 }
    }
    
    func saveCrystalAudioSettings() {
        crystalDefaults.set(isCrystalMuted, forKey: "CrystalDropCrystalAudioMuted")
        crystalDefaults.set(gemVolume, forKey: "CrystalDropCrystalAudioVolume")
    }
    
    func playDropChime() {
        guard !isCrystalMuted, isCrystalAudioSessionActive else { return }
        
        // Generate synthetic gem drop sound
        generateCrystalTone(frequency: 1200, duration: 0.4)
    }
    
    func playPrismAmbience() {
        guard !isCrystalMuted, isCrystalAudioSessionActive else { return }
        
        // Generate gem ambience
        generatePrismAmbientTone(frequency: 300, duration: 2.5)
    }
    
    private func generateCrystalTone(frequency: Float, duration: Float) {
        guard let engine = gemAudioEngine, let player = dropPlayerNode else { return }
        
        let sampleRate = Float(engine.mainMixerNode.outputFormat(forBus: 0).sampleRate)
        let frameCount = AVAudioFrameCount(sampleRate * duration)
        
        guard let buffer = AVAudioPCMBuffer(pcmFormat: engine.mainMixerNode.outputFormat(forBus: 0), frameCapacity: frameCount) else { return }
        
        buffer.frameLength = frameCount
        
        let channels = Int(buffer.format.channelCount)
        let frames = Int(buffer.frameLength)
        
        for channel in 0..<channels {
            let channelData = buffer.floatChannelData![channel]
            for frame in 0..<frames {
                let time = Float(frame) / sampleRate
                let amplitude = sin(2.0 * Float.pi * frequency * time) * gemVolume * 0.4
                channelData[frame] = amplitude * exp(-time * 2.5) // Crystal decay envelope
            }
        }
        
        player.scheduleBuffer(buffer, at: nil, options: [], completionHandler: nil)
        if !player.isPlaying {
            player.play()
        }
    }
    
    private func generatePrismAmbientTone(frequency: Float, duration: Float) {
        guard let engine = gemAudioEngine, let player = dropPlayerNode else { return }
        
        let sampleRate = Float(engine.mainMixerNode.outputFormat(forBus: 0).sampleRate)
        let frameCount = AVAudioFrameCount(sampleRate * duration)
        
        guard let buffer = AVAudioPCMBuffer(pcmFormat: engine.mainMixerNode.outputFormat(forBus: 0), frameCapacity: frameCount) else { return }
        
        buffer.frameLength = frameCount
        
        let channels = Int(buffer.format.channelCount)
        let frames = Int(buffer.frameLength)
        
        for channel in 0..<channels {
            let channelData = buffer.floatChannelData![channel]
            for frame in 0..<frames {
                let time = Float(frame) / sampleRate
                let amplitude = sin(2.0 * Float.pi * frequency * time) * gemVolume * 0.15
                channelData[frame] = amplitude
            }
        }
        
        player.scheduleBuffer(buffer, at: nil, options: [.loops], completionHandler: nil)
        if !player.isPlaying {
            player.play()
        }
    }
    
    func stopAllCrystalSounds() {
        dropPlayerNode?.stop()
    }
    
    func setCrystalVolume(_ newVolume: Float) {
        gemVolume = max(0.0, min(1.0, newVolume))
        gemAudioEngine?.mainMixerNode.outputVolume = gemVolume
        saveCrystalAudioSettings()
    }
    
    func toggleCrystalMute() {
        isCrystalMuted.toggle()
        gemAudioEngine?.mainMixerNode.outputVolume = isCrystalMuted ? 0.0 : gemVolume
        saveCrystalAudioSettings()
    }
}
