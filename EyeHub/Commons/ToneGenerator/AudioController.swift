import AVFoundation

class AudioController {
    var audioEngine = AVAudioEngine()
    var audioPlayerNode = AVAudioPlayerNode()
    
    func playTone(frequency: Double, duration: Double, startVolume: Float, endVolume: Float) {
        let audioFormat = AVAudioFormat(standardFormatWithSampleRate: 44100.0, channels: 1)!
        let frameCount = AVAudioFrameCount(duration * 44100.0)
        
        let toneBuffer = AVAudioPCMBuffer(pcmFormat: audioFormat, frameCapacity: frameCount)!
        toneBuffer.frameLength = frameCount
        
        let phaseIncrement = 2.0 * Double.pi * frequency / audioFormat.sampleRate
        var phase = 0.0
        
        for frame in 0..<Int(frameCount) {
            let sampleValue = sin(phase) * Double(UInt32.max)
            phase += phaseIncrement
            toneBuffer.floatChannelData?.pointee[frame] = Float(sampleValue)
        }
        
        let mixer = audioEngine.mainMixerNode
        
        audioEngine.attach(audioPlayerNode)
        audioEngine.connect(audioPlayerNode, to: mixer, format: audioFormat)
        
        try! audioEngine.start()
        
        audioPlayerNode.scheduleBuffer(toneBuffer, at: nil, options: .loops) {
            self.audioEngine.stop()
        }
        
        audioPlayerNode.play()
        
        let volumeRampTime = duration / 4.0 // Ramp up or down in 1/4 of the total duration
        DispatchQueue.global().asyncAfter(deadline: .now() + duration - volumeRampTime * 2) {
            mixer.outputVolume = endVolume / 100.0
        }
    }
    
    func stopPlayback() {
        audioPlayerNode.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
}




