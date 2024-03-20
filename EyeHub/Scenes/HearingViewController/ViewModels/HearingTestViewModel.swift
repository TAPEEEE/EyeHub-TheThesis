//
//  HearingTestViewModel.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 15/2/2567 BE.
//

import Foundation
import AVFAudio

class HearingTestViewModel {
    
    // MARK: - Properties
    var onHeadphoneConnectionChanged: ((Bool) -> Void)?
    var onNavigationBackButtonTap: (() -> Void)?
    
    // MARK: - Public Methods
    func checkHeadphoneConnection() {
        let isConnected = isHeadphoneConnected()
        onHeadphoneConnectionChanged?(isConnected)
    }

    func backButtonTapped() {
        onNavigationBackButtonTap?()
    }
    
    // MARK: - Private Methods
    func isHeadphoneConnected() -> Bool {
        let currentRoute = AVAudioSession.sharedInstance().currentRoute
        if currentRoute.outputs != nil {
            for description in currentRoute.outputs {
                if description.portType == AVAudioSession.Port.headphones || description.portType == AVAudioSession.Port.bluetoothA2DP {
                    print("headphone plugged in")
                    return true
                } else {
                    print("headphone pulled out")
                    return false
                }
            }
        } else {
            print("requires connection to device")
        }
        return false
    }
}


