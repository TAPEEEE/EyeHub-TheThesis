//
//  HearingTestViewController.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 5/4/2567 BE.
//

import UIKit
import AVFoundation

class HearingTestViewController: UIViewController {
    
    var decibel: Float = 4
    var key = "leftEar"
    let testHz: [Double] = [125, 250, 500, 1000, 2000, 4000, 8000]
    var test: [String: [Float]] = ["leftEar": [], "RightEar": []]
    var count = 0
    let toneGen = ToneGenerator()
    var pan: Float = 1.0
    var frequency: Double = 500
    
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btn.isEnabled = false
        delay()
    }
    
    @IBAction func action(_ sender: Any) {
        guard count < testHz.count else { return }
        appendValueToArray(decibel: Float(toneGen.value))
        toneGen.stopSound()
        count += 1
        if count == testHz.count && key != "RightEar" {
            key = "RightEar"
            pan = -1.0
            count = 0
        } else {
            btn.isEnabled = false
        }
        if let array = test[key], array.count == testHz.count {
            return
        }
        btn.isEnabled = false
        delay()
    }
    
    func appendValueToArray(decibel: Float) {
        if var existingArray = test[key] {
            existingArray.append(decibel)
            test[key] = existingArray
        } else {
            test[key] = [decibel]
        }
    }
    
    func delay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
            btn.isEnabled = true
            toneGen.setupAudio()
            toneGen.setUp(frequency: testHz[count], pan: pan)
            toneGen.playSound()
        }
        test.forEach { print("\($0): \($1)") }
    }
}
