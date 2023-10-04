//
//  MainView.swift
//  Voice App
//
//  Created by Sergey Prybysh on 9/22/23.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
        
    var body: some View {
        VStack {
            Spacer()
            Text(viewModel.state.mainMessage)
                .font(.caption)
                .padding(.horizontal, 35)
            AnalyzeView(
                action: { viewModel.didTapAnalizeButton() },
                isAnalyzing: viewModel.state.isAnalyzing,
                isEnabled: viewModel.state.analyzeButtonIsEnabled)
            .padding(.vertical, 20)
            Spacer()
            MicCircleView(
                action: { viewModel.didTapRecordButton() },
                isRecording: viewModel.state.isRecording,
                isEnabled: viewModel.state.recordButtonIsEnabled)
            .padding(.bottom, 100)
        }
        .alert(
            viewModel.state.alert?.title ?? "",
            isPresented: Binding(
                get: { viewModel.state.alert != nil },
                set: { _ in viewModel.dismissAlert() }),
            actions: {
              Button("Ok", role: .cancel, action: {})
            },
            message: {
                Text(viewModel.state.alert?.message ?? "")
            })
    }
}

#Preview {
    MainView(viewModel: MainViewModel())
}
