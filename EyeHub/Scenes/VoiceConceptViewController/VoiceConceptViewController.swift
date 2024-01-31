//
//  VoiceConceptViewController.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 29/1/2567 BE.
//

import UIKit
import Speech
import AVFoundation

class VoiceConceptViewController: UIViewController, SFSpeechRecognizerDelegate {
    
    @IBOutlet weak var recognizeTextView: UILabel!
    @IBOutlet weak var buttonView: PrimaryButton!
    
    var player: AVAudioPlayer?
    let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-GB"))
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest!
    var recognitionTask: SFSpeechRecognitionTask!
    let audioEngine = AVAudioEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SFSpeechRecognizer.requestAuthorization { (status) in
            print(status)
        }
        commonInit()
    }
    
    func playSound(sound: String) {
        let url = Bundle.main.url(forResource: sound, withExtension: "mp3")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
            
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    func voiceRec() {
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(.record, mode: .measurement, options: .defaultToSpeaker)
        try? audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        
        self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        recognitionRequest.shouldReportPartialResults = true
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            if let result = result {
                print(result.bestTranscription.formattedString)
                self.recognizeTextView.text = result.bestTranscription.formattedString
                
                var bestString = result.bestTranscription.formattedString
                var lastString: String = ""
                for segment in result.bestTranscription.segments {
                    let indexTo = bestString.index(bestString.startIndex, offsetBy: segment.substringRange.location)
                    lastString = bestString.substring(from: indexTo)
                    print(lastString)
                }
                
                if lastString.lowercased() == "hello" {
                    try? self.audioEngine.stop()
                    self.playSound(sound: "Sound2")
                    bestString = ""
                    lastString = ""
                }
            }
        })
        
        let recordingFormat = audioEngine.inputNode.outputFormat(forBus: 0)
        audioEngine.inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        try? audioEngine.start()
    }
}

extension VoiceConceptViewController {
    func commonInit() {
        buttonView.setUp(.textOnly(text: "Start"), type: .primary, size: .large)
        self.view.backgroundColor = UIColor(cgColor:  EyeHubColor.backgroundColor)
        
        recognizeTextView.font = FontFamily.Kanit.medium.font(size: 18)
        let demoButtontapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(demoVoice)
        )
        buttonView.addGestureRecognizer(demoButtontapGesture)
    }
    
    @objc func demoVoice() {
        buttonView.buttonState = .disable
        playSound(sound: "Sound1")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.voiceRec()
        }
    }
}
