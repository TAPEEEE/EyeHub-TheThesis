//
//  HearingTestViewModel.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 17/4/2567 BE.
//

import Foundation
import AVFoundation

//class HearingViewModel {
//    var audioPlayer: AVAudioPlayer?
//    var currentEarKey = "leftEar"
//    var testFrequencies: [TestFrequency] = TestFrequency.allCases
//    var testResults: [String: [Int]] = ["leftEar": [], "rightEar": []]
//    var currentTestIndex = 0
//    var pan: Float = 1.0
//    var testStateText: String = "ทดสอบหูซ้าย"
//    var progressValue: Float = 0.0
//    var isButtonEnabled: Bool = false
//    var navigationTitle: String = "ทดสอบระดับการได้ยิน"
//    
//    func setUpTest() {
//        currentEarKey = "leftEar"
//        testStateText = "ทดสอบหูซ้าย"
//        progressValue = 0.0
//        isButtonEnabled = false
//        currentTestIndex = 0
//        testResults = ["leftEar": [], "rightEar": []]
//    }
//    
//    func startTestWithDelay(completion: @escaping (String) -> Void) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
//            isButtonEnabled = true
//            let frequency = testFrequencies[currentTestIndex].stringValue
//            let frequencyString = "\(frequency) Hz"
//            testStateText = frequencyString
//            completion(frequencyString)
//            playSound(soundFileName: String(frequency), pan: pan)
//        }
//    }
//    
//    func appendDecibelValueToArray(decibel: Int) {
//        if var existingArray = testResults[currentEarKey] {
//            existingArray.append(decibel)
//            testResults[currentEarKey] = existingArray
//        } else {
//            testResults[currentEarKey] = [decibel]
//        }
//    }
//    
//    func switchToRightEarTest() {
//        currentEarKey = "rightEar"
//        testStateText = "ทดสอบหูขวา"
//        pan = -1.0
//        currentTestIndex = 0
//    }
//    
//    func navigateToSummary() -> HearingTestResult {
//        return HearingTestResult(
//            leftEarResults: testResults["leftEar"] ?? [],
//            rightEarResults: testResults["rightEar"] ?? []
//        )
//    }
//    
//    func playSound(soundFileName: String, pan: Float) {
//        guard let url = Bundle.main.url(forResource: soundFileName, withExtension: "mp3") else {
//            print("Sound file not found.")
//            return
//        }
//        
//        do {
//            audioPlayer = try AVAudioPlayer(contentsOf: url)
//            audioPlayer?.pan = pan
//            audioPlayer?.play()
//        } catch {
//            print("Error playing sound: \(error.localizedDescription)")
//        }
//    }
//    
//    func stopSound() {
//        if let player = audioPlayer, player.isPlaying {
//            player.stop()
//        }
//    }
//    
//    func calculateDecibel(x: Double) -> Double {
//        let slope = 1.5
//        let y = slope * x
//        return y
//    }
//}
