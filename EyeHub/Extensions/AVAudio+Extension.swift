//
//  AVAudio+Extension.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 20/8/2567 BE.
//

import Foundation
import AVFoundation

func configureAudioSession() {
    let audioSession = AVAudioSession.sharedInstance()
    do {
        try audioSession.setCategory(.playback, mode: .default)
        try audioSession.setActive(true)
    } catch {
        print("การตั้งค่า AVAudioSession ล้มเหลว: \(error.localizedDescription)")
    }
}
