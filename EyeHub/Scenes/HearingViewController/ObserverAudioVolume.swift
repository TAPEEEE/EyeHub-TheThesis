//
//  ObserverAudioVolume.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 20/3/2567 BE.
//

import AVFoundation

class AudioSessionObserver {
    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(audioSessionDidChangeRoute),
            name: AVAudioSession.routeChangeNotification,
            object: AVAudioSession.sharedInstance()
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func audioSessionDidChangeRoute(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let reasonValue = userInfo[AVAudioSessionRouteChangeReasonKey] as? UInt,
              let reason = AVAudioSession.RouteChangeReason(rawValue: reasonValue) else {
            return
        }

        if reason == .newDeviceAvailable || reason == .oldDeviceUnavailable {
            // Handle changes in available audio input sources here
            print("Available audio input sources changed.")
            print("Bluetooth headphones connected: \(isHeadphoneConnected())")
        }
    }

    func isHeadphoneConnected() -> Bool {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: .allowBluetooth)
            
            if audioSession.availableInputs?.contains(where: { $0.portType == .bluetoothHFP }) ?? false {
                return true
            }
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
}
