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
            if viewModel.state.secondaryButtonState.isShown {
                HStack {
                    Spacer()
                    SecondaryButton(
                        type: viewModel.state.secondaryButtonState.type,
                        action: { viewModel.didTapSecondaryButton() })
                }
                .padding(.top, 90)
                .padding(.horizontal, 20)
            } else {
                HStack {
                    Spacer()
                    SecondaryButton(type: .none, action: { })
                        .padding(.top, 90)
                        .padding(.horizontal, 20)
                        .hidden()
                }
            }
            Spacer()
            if let message = viewModel.state.status.mainMessage {
                Text(message)
                    .font(.system(size: 15, weight: .heavy))
                    .foregroundColor(.white)
            } else {
                Text("placeholder")
                    .font(.system(size: 15, weight: .heavy))
                    .hidden()
            }
            ZStack {
                RippleAnimationView(
                    isActive: viewModel.state.actionButtonState.isActive,
                    size: CGSize(width: 100, height: 100))
                RippleAnimationView(
                    isActive: viewModel.state.actionButtonState.isActive,
                    size: CGSize(width: 60, height: 60))
                ActionButton(
                    isActive: viewModel.state.actionButtonState.isActive,
                    type: viewModel.state.actionButtonState.type,
                    action: { viewModel.didTapActionButton() })
            }
            .padding(.vertical, 25)
            Spacer()
            
            if viewModel.state.activityDetailsViewType == .none {
                ActivityDetailsView(type: viewModel.state.activityDetailsViewType)
                    .padding(.bottom, 120)
                    .hidden()
            } else {
                ActivityDetailsView(type: viewModel.state.activityDetailsViewType)
                    .padding(.bottom, 120)
            }
        }
        .sheet(
            isPresented: Binding(
                get: { viewModel.state.resultMessage != nil },
                set: { _ in viewModel.dismissMessageSheet() }),
            content: {
                    Text("Details View will be here")
                })
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
