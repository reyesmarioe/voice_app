//
//  MainViewState.swift
//  Voice App
//
//  Created by Sergey Prybysh on 9/30/23.
//

import Foundation

struct MainState {
    struct ActionButtonState {
        let type: ActionButtonType
        let isActive: Bool
    }
    
    struct SecondaryButtonState {
        let type: SecondaryButtonType
        let isShown: Bool
    }
    
    var status: MainViewModel.Status
    var actionButtonState: ActionButtonState
    var secondaryButtonState: SecondaryButtonState
    var activityDetailsViewType: ActivityDetailsViewType
    var resultMessage: AnalyzedMessage?
    var alert: (title: String, message: String)?
}

extension MainViewModel.Status {
    var mainMessage: String? {
        switch self {
        case .readyToRecord:
            return "Tap to record the message"
        case .recording, .analyzing:
            return nil
        case .readyToAnalize:
            return "Tap to analyze. Or re-record."
        }
    }
    
    var actionMessage: String? {
        switch self {
        case .readyToRecord:
            return nil
        case .recording:
            return "Listening... Record a message to analyze."
        case .readyToAnalize:
            return "Tap to analyze. Or re-record."
        case .analyzing:
            return "Analyzing..."
        }
    }
    
    static let timeoutAlert = ("Time limit exceeded", "You can not record messages for more than 30 seconds.")
    static let recordingFailedAlert = ("Error", "The recording failed. Try again.")
    static let serverAlert = ("Error", "There was an error while analyzing the message. Try again.")
}
