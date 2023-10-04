//
//  MainViewState.swift
//  Voice App
//
//  Created by Sergey Prybysh on 9/30/23.
//

import Foundation

struct MainState {
    enum Status: Equatable {
        case readyToRecord
        case recording
        case readyToAnalize
        case analyzing
    }
    
    var status: Status
    var alert: (title: String, message: String)?
}

extension MainState {
    var isRecording: Bool {
        status == .recording
    }
    
    var isAnalyzing: Bool {
        status == .analyzing
    }
    
    var recordButtonIsEnabled: Bool {
        status != .analyzing
    }
    
    var analyzeButtonIsEnabled: Bool {
        switch status {
        case .readyToRecord, .recording:
            return false
        case .readyToAnalize, .analyzing:
            return true
        }
    }
    
    var mainMessage: String {
        switch status {
        case .readyToRecord:
            return "Record the message to analize."
        case .recording:
            return "Record in progress..."
        case .readyToAnalize:
            return "Tap to analyze. Or re-record."
        case .analyzing:
            return "Analyzing..."
        }
    }
    
    static let timeoutAlert = ("Time limit exceeded", "You can not record messages for more than 30 seconds.")
    static let recordingFailedAlert = ("Error", "The recording failed. Try again.")
}
