//
//  HearingTestViewModel.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 21/4/2567 BE.
//

import Foundation
import AVFoundation

class HearingViewModel {
    var audioPlayer: AVAudioPlayer?
    
    func playSound(soundFileName: String, pan: Float) {
        guard let url = Bundle.main.url(forResource: soundFileName, withExtension: "mp3") else {
            print("Sound file not found.")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.pan = pan
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    func stopSound() -> Double? {
        var currentTime: Double?
        if let player = audioPlayer, player.isPlaying {
            currentTime = Double(player.currentTime)
            player.stop()
        }
        return currentTime
    }
    
    func calculateDecibel(x: Double) -> Double {
        let slope = 1.5
        let y = slope * x
        return y
    }
}
