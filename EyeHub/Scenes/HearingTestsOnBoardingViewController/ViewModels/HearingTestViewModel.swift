//
//  HearingTestViewModel.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 15/2/2567 BE.
//

import Foundation
import AVFAudio
import UIKit

class HearingTestViewModel {
    
    // MARK: - Properties
    var onHeadphoneConnectionChanged: ((Bool) -> Void)?
    var onVolumeChanged: ((Bool) -> Void)?
    var onNavigationBackButtonTap: (() -> Void)?
    
    // MARK: - Public Methods
    func checkHeadphoneConnection() {
        let isConnected = isHeadphoneConnected()
        onHeadphoneConnectionChanged?(isConnected)
    }
    
    func checkVolumeMax() {
        let isMax = isVolumeMax()
        onHeadphoneConnectionChanged?(isMax)
    }

    func backButtonTapped() {
        onNavigationBackButtonTap?()
    }
    
    func isVolumeMax() -> Bool {
        let vol = AVAudioSession.sharedInstance().outputVolume
        if vol < 1 {
            return false
        }
        return true
    }
    
    // MARK: - Private Methods
    func isHeadphoneConnected() -> Bool {
        let currentRoute = AVAudioSession.sharedInstance().currentRoute
        let feedbackGenerator = UINotificationFeedbackGenerator()
        if currentRoute.outputs != nil {
            for description in currentRoute.outputs {
                if description.portType == AVAudioSession.Port.headphones || description.portType == AVAudioSession.Port.bluetoothA2DP {
                    feedbackGenerator.notificationOccurred(.success)
                    return true
                } else {
                    return true
                }
            }
        } else {
            print("requires connection to device")
            feedbackGenerator.notificationOccurred(.error)
        }
        return true
    }
}


