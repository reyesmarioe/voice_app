//
//  MessageDetailsView.swift
//  Voice App
//
//  Created by Sergey Prybysh on 11/19/23.
//

import SwiftUI

struct MessageDetailsView: View {
    let analyzedMessage: MessageData
    let cancelAction: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                SecondaryButton(type: .close) {
                    cancelAction()
                }
                .padding(.horizontal, 5)
                Spacer()
                ShareLink(
                    item: analyzedMessage.text,
                    preview: SharePreview(
                        analyzedMessage.text,
                        image: Image(systemName: "paperplane.circle.fill")))
                .foregroundColor(.white)
                .padding(.horizontal, 10)
            }
            .padding(20)

            Text(analyzedMessage.text)
                .frame(maxWidth: .infinity)
                .padding(20)
                .foregroundColor(.black)
                .background(RoundedRectangle(cornerRadius: 12).fill(.white))
                .padding(.horizontal,20)

            HStack {
                Text("Number of characters: \(analyzedMessage.numChar)")
                    .padding(.horizontal, 26)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                    .foregroundColor(.white)
                    .font(.system(size: 15, weight: .heavy))

                Spacer()
            }
            
            HStack {
                Text("Sentiment: \(analyzedMessage.sentiment)")
                    .padding(.horizontal, 26)
                    .padding(.bottom, 20)
                    .foregroundColor(.white)
                    .font(.system(size: 15, weight: .heavy))

                Spacer()
            }
            
            EmotionChartView(barData: analyzedMessage.barData)
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 12).fill(.white))
                .padding(20)

            Spacer(minLength: 60)
        }
        .background(.teal.gradient)
    }
}
