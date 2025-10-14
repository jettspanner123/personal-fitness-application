import Foundation
import AVFoundation


class ApplicationSoundManager {
    public static let current = ApplicationSoundManager()
    private var player: AVAudioPlayer?
    
    enum SoundOptions: String {
        case tick, alarm
    }
    
    enum ExtensionType: String {
        case mp3, wav
    }
    
    func play(sound track: SoundOptions, with type: ExtensionType, playForever: Bool = false) -> Void {
        guard let soundURL = Bundle.main.url(forResource: track.rawValue, withExtension: type.rawValue) else {
            print("Sound File \(track.rawValue) not found!")
            return
        }
        
        do {
            self.player = try AVAudioPlayer(contentsOf: soundURL)
            self.player?.numberOfLoops = playForever ? -1 : 0
            self.player?.prepareToPlay()
            self.player?.play()
        } catch {
            print("Error playing the \(track.rawValue) sound effect.")
        }
    }
    
    func stop() -> Void {
        self.player?.stop()
        self.player?.currentTime = .zero
    }
}
