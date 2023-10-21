//
//  MainViewModel.swift
//  Voice App
//
//  Created by Sergey Prybysh on 9/22/23.
//

import AVFoundation
import Foundation

class MainViewModel: ObservableObject {
    enum Status: Equatable {
        case readyToRecord
        case recording
        case readyToAnalize
        case analyzing
    }
    
    @Published var state: MainState
    
    private var status: Status {
        didSet {
            switch status {
            case .readyToRecord:
                state = MainState(
                    status: status,
                    actionButtonState: .init(type: .recorder, isActive: false),
                    secondaryButtonState: .init(type: .none, isShown: false),
                    activityDetailsViewType: .none,
                    alert: nil)
            case .recording:
                state = MainState(
                    status: status,
                    actionButtonState: .init(type: .recorder, isActive: true),
                    secondaryButtonState: .init(type: .stop, isShown: true),
                    activityDetailsViewType: .recording,
                    alert: nil)
            case .readyToAnalize:
                state = MainState(
                    status: status,
                    actionButtonState: .init(type: .analyzer, isActive: false),
                    secondaryButtonState: .init(type: .record, isShown: true),
                    activityDetailsViewType: .none,
                    alert: nil)
            case .analyzing:
                state = MainState(
                    status: status,
                    actionButtonState: .init(type: .analyzer, isActive: true),
                    secondaryButtonState: .init(type: .cancel, isShown: true),
                    activityDetailsViewType: .analyzing,
                    alert: nil)
            }
        }
    }
    
    private var provider: AnalyzerProviding
    
    private lazy var recorder = Recorder(
        timeoutExpired: { [weak self] in
            self?.status = .readyToAnalize
            self?.state.alert = MainViewModel.Status.timeoutAlert
        },
        recordingFailed: { [weak self] in
            self?.state.alert = MainViewModel.Status.recordingFailedAlert
            self?.status = .readyToRecord
        })
    
    init(provider: AnalyzerProviding = AnalyzerProvider()) {
        self.provider = provider
        self.status = .readyToRecord
        
        state = MainState(
            status: .readyToRecord,
            actionButtonState: .init(type: .recorder, isActive: false),
            secondaryButtonState: .init(type: .none, isShown: false),
            activityDetailsViewType: .none,
            alert: nil)
    }
    
    func didTapActionButton() {
        switch status {
        case .readyToRecord:
            status = .recording
            recorder.startRecording()
        case .recording:
            break
        case .readyToAnalize:
            status = .analyzing
            requestToAnalyze()
        case .analyzing:
            break
        }
    }
    
    func didTapSecondaryButton() {
        switch status {
        case .readyToRecord:
            break
        case .recording:
            status = .readyToAnalize
            recorder.stopRecording()
        case .readyToAnalize:
            status = .recording
            recorder.startRecording()
        case .analyzing:
            status = .readyToRecord
            provider.cancelRequest()
        }
    }
    
    func dismissAlert() {
        state.alert = nil
    }
    
    func dismissMessageSheet() {
        state.resultMessage = nil
    }
    
    private func requestToAnalyze() {
        guard let recordingURL = recorder.fileURL else { return }
        provider.requestToAnalyze(url: recordingURL) { [weak self] result in
            guard let self else { return }
            status = .readyToRecord
            switch result {
            case .success(let message):
                state.resultMessage = message
            case .failure:
                state.alert = MainViewModel.Status.serverAlert
            }
        }
    }
}
