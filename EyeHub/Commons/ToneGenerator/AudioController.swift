//
//  AudioController.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 7/4/2567 BE.
//

import Foundation
import AVFAudio

class AudioController {
    let audioEngine = AVAudioEngine()
    var timer: Timer?
    let sampleRate: Double = 44100
    let audioFormat = AVAudioFormat(standardFormatWithSampleRate: 44100, channels: 1)!
    var frequency: Double = 440 // Default frequency is 440 Hz
    
    func startTone() {
        do {
            try audioEngine.start()
            
            // Create a buffer and schedule it for playback
            let toneBuffer = createToneBuffer()
            let player = AVAudioPlayerNode()
            audioEngine.attach(player)
            audioEngine.connect(player, to: audioEngine.mainMixerNode, format: audioFormat)
            player.scheduleBuffer(toneBuffer, at: nil, options: .loops, completionHandler: nil)
            
            // Start the player
            player.play()
        } catch {
            print("Error starting audio engine: \(error.localizedDescription)")
        }
    }
    
    private func createToneBuffer() -> AVAudioPCMBuffer {
        let lengthInFrames = Int(sampleRate / frequency)
        let buffer = AVAudioPCMBuffer(pcmFormat: audioFormat, frameCapacity: AVAudioFrameCount(lengthInFrames))!
        let data = buffer.floatChannelData?[0]
        let thetaIncrement = 2.0 * Double.pi * frequency / sampleRate
        var theta = 0.0
        
        // Use a timer to update the amplitude based on mixer node's outputVolume
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            
            // Update amplitude based on outputVolume
            let amplitude = Float(sin(Float(theta)) * self.audioEngine.mainMixerNode.outputVolume)
            
            for frame in 0..<lengthInFrames {
                data?[frame] = Float32(sin(Float(theta)) * amplitude)
                theta += thetaIncrement
            }
            buffer.frameLength = AVAudioFrameCount(lengthInFrames)
        }
        
        return buffer
    }
    
    func stopTone() {
        audioEngine.stop()
        timer?.invalidate()
    }
}


