//
//  ActivityDetailsView.swift
//  Voice App
//
//  Created by Sergey Prybysh on 10/20/23.
//

import SwiftUI

enum ActivityDetailsViewType {
    case recording
    case analyzing
    case none
    
    var imageName: String {
        switch self {
        case .recording:
            return "waveform"
        case .analyzing:
            return "bolt.horizontal"
        case .none:
            return "waveform"
        }
    }
    
    var title: String {
        switch self {
        case .recording:
            return "Listening..."
        case .analyzing:
            return "Analyzing..."
        case .none:
            return "None"
        }
    }
    
    var message: String {
        switch self {
        case .recording:
            return "Record your message."
        case .analyzing:
            return "Pleasse, wait."
        case .none:
            return "None"
        }
    }
}
struct ActivityDetailsView: View {
    let type: ActivityDetailsViewType
    
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: type.imageName)
                .foregroundColor(.white)
                .font(.system(size: 20))
            Text(type.title)
                .foregroundColor(.white)
                .font(.system(size: 15, weight: .semibold))
            
            Text(type.message)
                .foregroundColor(.white)
                .font(.system(size: 13))
        }
    }
}
