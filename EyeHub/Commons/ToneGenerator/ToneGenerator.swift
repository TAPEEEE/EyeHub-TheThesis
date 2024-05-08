//
//  ToneGenerator.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 6/4/2567 BE.
//

import UIKit
import AVFoundation
import HealthKit

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
            let buffer = createToneBuffer(amplitude: 0.25)
//            print("Amplitude: \(dB) dB")
            audioPlayerNode.scheduleBuffer(buffer, at: nil, options: .loops, completionHandler: nil)
            let level = getLevel(from: buffer)
            print("\(level) dB")
//            print("Decibel Value: \(decibelValue) dB")
        }
    }
    private var targetValue = 10
    private let duration = 5
    private var timer: Timer?
    
    func getdB() {
//        if HKHealthStore.isHealthDataAvailable() {
//            // Create an instance of HKHealthStore
//            let healthStore = HKHealthStore()
//            
//            // Define the type you want to read (headphone audio exposure)
//            let audioExposureType = HKObjectType.quantityType(forIdentifier: .headphoneAudioExposure)!
//            
//            // Request authorization to access headphone audio exposure data
//            healthStore.requestAuthorization(toShare: nil, read: [audioExposureType]) { success, error in
//                if success {
//                    // Authorization granted, proceed to fetch data
//                    let sampleType = HKSampleType.quantityType(forIdentifier: .headphoneAudioExposure)!
//                    
//                    // Create a query to fetch the most recent audio exposure sample
//                    let query = HKSampleQuery(sampleType: sampleType, predicate: nil, limit: 1, sortDescriptors: nil) { query, samples, error in
//                        if let sample = samples?.first as? HKQuantitySample {
//                            // Extract the dB value from the sample
//                            let audioExposureValue = sample.quantity.doubleValue(for: HKUnit.decibelHearingLevel())
//                            print("Headphone audio exposure dB value: \(audioExposureValue) dB")
//                        } else {
//                            print("No headphone audio exposure data available.")
//                        }
//                    }
//                    
//                    // Execute the query
//                    healthStore.execute(query)
//                } else {
//                    print("Authorization denied for accessing headphone audio exposure data.")
//                }
//            }
//        } else {
//            print("HealthKit is not available on this device.")
//        }

    }
    
    func startChangingValue() {
        timer = Timer.scheduledTimer(withTimeInterval: Double(duration) / Double(targetValue), repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            
            if value < 0.15 {
                self.value += 0.005
            } else if value > 0.5 {
                timer.invalidate()
            }
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
    
    func getLevel(from buffer: AVAudioPCMBuffer) -> Float {
        guard let channelData = buffer.floatChannelData else { return 0 }
        let channelDataValue = channelData.pointee
        let channelDataValueArray = stride(from: 0, to: Int(buffer.frameLength), by: buffer.stride).map { channelDataValue[$0] }
        let rms = sqrt(channelDataValueArray.map { $0 * $0 }.reduce(0, +) / Float(buffer.frameLength))
        let avgPower = 20 * log10(rms)
        return avgPower
    }
    
    func playSound() {
        audioPlayerNode.pan = pan
        audioPlayerNode.play()
    }
    
    private func createToneBuffer(amplitude: Float) -> AVAudioPCMBuffer {
        let lengthInFrames = Int(sampleRate / frequency)
        
        let buffer = AVAudioPCMBuffer(pcmFormat: audioFormat, frameCapacity: AVAudioFrameCount(lengthInFrames))!
        
        let data = buffer.floatChannelData?[0]
        
        let thetaIncrement = 2.0 * Double.pi * frequency / sampleRate
        
        var theta = 0.0
        
        for frame in 0..<lengthInFrames {
            data?[frame] = Float32(sin(Float(theta)) * amplitude)
            theta += thetaIncrement
        }
        
        buffer.frameLength = AVAudioFrameCount(lengthInFrames)
        
        let dB = 20 * log10(amplitude)
        
        return buffer
    }
}
