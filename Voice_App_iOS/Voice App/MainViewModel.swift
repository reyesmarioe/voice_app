//
//  MainViewModel.swift
//  Voice App
//
//  Created by Sergey Prybysh on 9/22/23.
//

import AVFoundation
import Foundation

class MainViewModel: ObservableObject {
    @Published var state: MainState
    private var provider: AnalyzerProviding
    
    private lazy var recorder = Recorder(
        timeoutExpired: { [weak self] in
            self?.state.alert = MainState.timeoutAlert
            self?.state.status = .readyToAnalize
        },
        recordingFailed: { [weak self] in
            self?.state.alert = MainState.recordingFailedAlert
            self?.state.status = .readyToRecord
        })
    
    // TODO: Replace with real when ready
    init(provider: AnalyzerProviding = FakeAnalyzerProvider()) {
        self.provider = provider
        state = MainState(status: .readyToRecord, alert: nil)
    }
    
    func didTapRecordButton() {
        if state.status == .recording {
            state.status = .readyToAnalize
            recorder.stopRecording()
        } else {
            state.status = .recording
            recorder.startRecording()
        }
    }
    
    func didTapAnalizeButton() {
        guard state.status != .analyzing else { return }
        state.status = .analyzing
        
        guard let recordingURL = recorder.fileURL else { return }
        
        provider.requestToAnalyze(url: recordingURL) { [weak self] result in
            guard let self else { return }
            state.status = .readyToRecord
        }
    }
    
    func dismissAlert() {
        state.alert = nil
    }
    
    func cancelRequest() {
        state.status = .readyToAnalize
    }
}
