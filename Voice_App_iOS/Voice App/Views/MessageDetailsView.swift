//
//  MessageDetailsView.swift
//  Voice App
//
//  Created by Sergey Prybysh on 10/25/23.
//

import SwiftUI

struct MessageDetailsView: View {
    let analyzedMessage: AnalyzedMessage
    let cancelAction: () -> Void
            
    var body: some View {
        VStack {
            HStack {
                SecondaryButton(type: .close) {
                    cancelAction()
                }
                .padding(.horizontal, 5)
                Spacer()
                ShareLink(
                    item: analyzedMessage.message,
                    preview: SharePreview(
                        analyzedMessage.message,
                        image: Image(systemName: "paperplane.circle.fill")))
                .foregroundColor(.white)
                .padding(.horizontal, 10)
            }
            .padding(20)
            
            Text(analyzedMessage.message)
                .frame(maxWidth: .infinity)
                .padding(20)
                .foregroundColor(.black)
                .background(RoundedRectangle(cornerRadius: 12).fill(.white))
                .padding(.horizontal,20)
                
            HStack {
                Text("Number of words: \(analyzedMessage.numOfWords)")
                    .padding(.horizontal, 26)
                    .padding(.vertical, 20)
                    .foregroundColor(.white)
                    .font(.system(size: 15, weight: .heavy))

                Spacer()
            }
            
            Spacer()
        }
        .background(.teal.gradient)
    }
}

#Preview {
    MessageDetailsView(analyzedMessage: AnalyzedMessage(
        message: "Some recorded text",
        numOfWords: 14), cancelAction: {})
}
