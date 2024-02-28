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
    private func isHeadphoneConnected() -> Bool {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: .allowBluetooth)
            
            if audioSession.availableInputs?.first(where: { $0.portType == .bluetoothHFP }) != nil {
                return true
            }
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
}
