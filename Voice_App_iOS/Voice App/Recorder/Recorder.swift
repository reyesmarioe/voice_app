//
//  Recorder.swift
//  Voice App
//
//  Created by Sergey Prybysh on 9/30/23.
//

import Foundation
import AVFoundation
import AVFAudio
import os

class Recorder: NSObject, AVAudioRecorderDelegate {
    
    private let session = AVAudioSession.sharedInstance()
    private let recordingName = "recordedAudio.wav"
    private let logger = Logger()
    
    private var timer: Timer?
    
    private var audioRecorder: AVAudioRecorder?
    private(set) var isRecording = false
    
    private var timeoutExpired: (() -> Void)?
    private var recordingFailed: (() -> Void)?
    
    init(timeoutExpired: (() -> Void)?, recordingFailed: (() -> Void)?) {
        self.timeoutExpired = timeoutExpired
        self.recordingFailed = recordingFailed
    }
    
    var fileURL: URL? {
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let pathArray = [dirPath, recordingName]
        return NSURL.fileURL(withPathComponents: pathArray)
    }
    
    func startRecording() {
        guard let fileURL else { logger.error("Unable to create recording URL"); return }
        
        try! session.setCategory(.playAndRecord)
        try! audioRecorder = AVAudioRecorder(url: fileURL, settings: [:])
        audioRecorder?.delegate = self
        audioRecorder?.isMeteringEnabled = true
        audioRecorder?.prepareToRecord()
        audioRecorder?.record()
        startTimer()
        isRecording = true
    }
    
    func stopRecording() {
        audioRecorder?.stop()
        try! session.setActive(false)
                
        isRecording = false
        timer = nil
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(
            timeInterval: 30,
            target: self,
            selector: #selector(timerAction),
            userInfo: nil,
            repeats: false)
    }
        
    @objc private func timerAction() {
        guard isRecording else { return }
        stopRecording()
        timeoutExpired?()
    }
    
    //MARK: AVAudioRecorderDelegate
        
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            recordingFailed?()
        }
    }
}
