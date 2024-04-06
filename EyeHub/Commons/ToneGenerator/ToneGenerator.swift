//
//  ToneGenerator.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 6/4/2567 BE.
//

import UIKit
import AVFoundation

class ToneGenerator {
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var audioFormat: AVAudioFormat!
    
    let sampleRate: Double = 44100.0
    var frequency: Double = 1000.0
    var amplitude: Double = 0.25
    var pan: Float = 0.0
    var value: Float = 0 {
        didSet {
            audioEngine.mainMixerNode.outputVolume = value
            print(value)
            let buffer = createToneBuffer(db: value)
            audioPlayerNode.scheduleBuffer(buffer, at: nil, options: .loops, completionHandler: nil)
            let referenceLevel: Float = 0.1

            // Calculate the decibel value using the formula: dB = 20 * log10(outputVolume / referenceLevel)
            let decibelValue = 20 * log10(value / referenceLevel)

            print("Decibel Value: \(decibelValue) dB")
        }
    }
    private var targetValue = 10
    private let duration = 5
    private var timer: Timer?
    
    func startChangingValue() {
        timer = Timer.scheduledTimer(withTimeInterval: Double(duration) / Double(targetValue), repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            
            self.value += 0.01
            if Int(self.value) >= self.targetValue {
                timer.invalidate()
                print("Value reached \(self.targetValue)")
            }
        }
    }
    
    func setUp(frequency: Double, pan: Float = 0.0) {
        self.frequency = frequency
        self.pan = pan
    }
    
    func setupAudio() {
        audioEngine = AVAudioEngine()
        audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attach(audioPlayerNode)
        audioFormat = AVAudioFormat(standardFormatWithSampleRate: sampleRate, channels: 1)
        audioEngine.connect(audioPlayerNode, to: audioEngine.mainMixerNode, format: audioFormat)
        do {
            try audioEngine.start()
            audioEngine.mainMixerNode.outputVolume = value
            startChangingValue()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func stopSound() {
        timer?.invalidate()
        audioEngine.stop()
        value = 0
    }
    
    func playSound() {
        audioPlayerNode.pan = pan
        audioPlayerNode.play()
    }
    
    private func createToneBuffer(db: Float) -> AVAudioPCMBuffer {
        let lengthInFrames = Int(sampleRate / frequency)
        let buffer = AVAudioPCMBuffer(pcmFormat: audioFormat, frameCapacity: AVAudioFrameCount(lengthInFrames))!
        let data = buffer.floatChannelData?[0]
        let thetaIncrement = 2.0 * Double.pi * frequency / sampleRate
        var theta = 0.0
        for frame in 0..<lengthInFrames {
            data?[frame] = Float32(sin(Float(theta)) * db)
            theta += thetaIncrement
        }
        buffer.frameLength = AVAudioFrameCount(lengthInFrames)
        return buffer
    }
}
