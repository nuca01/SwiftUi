//
//  CardsView.swift
//  assignment28
//
//  Created by nuca on 23.05.24.
//

import SwiftUI

struct CardsView: View {
    //MARK: - Properties
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            card(of: .guitar)
            VStack(alignment: .leading, spacing: 15) {
                card(of: .chat)
                card(of: .voice)
            }
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 0))
    }
    
    @State private var chatCardBackgroundColor: Color = Color(
        red: 1,
        green: 0.518,
        blue: 0.294
    )
    @State private var guitarCardDescription: String = "We love property wrappers and closures"
    
    //MARK: - Helper Enum
    private enum Card {
        case guitar
        case chat
        case voice
    }
    
    //MARK: - Helper Methods
    private func card(of card: Card) -> some View {
        switch card {
        case .guitar:
            return cardWith(
                title: "ჯუზონები და რამე",
                description: guitarCardDescription,
                iconName: "voice",
                backgroundName: "guitarBackground",
                backgroundColor: Color(
                    red: 0.969,
                    green: 0.733,
                    blue: 0.212
                ),
                height: 232,
                card: card
            )
        case .chat:
            return cardWith(
                title: "ჩატაობა",
                iconName: "chat",
                backgroundName: "chatBackground",
                backgroundColor: chatCardBackgroundColor,
                height: 110,
                card: card
            )
        case .voice:
            return cardWith(
                title: "ცეცხლოვანი სიახლეები",
                iconName: "person",
                backgroundName: "voiceBackground",
                backgroundColor: Color(
                    red: 0.498,
                    green: 0.212,
                    blue: 0.969
                ),
                height: 110,
                card: card
            )
        }
    }
    
    private func cardWith(
        title: String,
        description: String? = nil,
        iconName: String,
        backgroundName: String,
        backgroundColor: Color,
        height: CGFloat,
        card: Card
    ) -> some View {
        ZStack(alignment: .topLeading) {
            
            ZStack(alignment: .bottomTrailing) {
                //rectangle with rounded corners
                RoundedRectangle(cornerRadius: 25)
                    .foregroundStyle(backgroundColor)
                
                //image on the rectangle
                Image(backgroundName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: height/1.27)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
            }
            
            VStack(alignment: .leading) {
                //icon
                cardIcon(of: iconName, card: card)
                //title
                cardTitle(with: title)
                
                //description
                if let description {
                    Spacer()
                    Spacer()
                    Spacer()
                    cardDescription(with: description)
                    Spacer()
                }
            }
            .padding(EdgeInsets(
                top: 15,
                leading: 11,
                bottom: 10,
                trailing: 40
            ))
        }
        .frame(width: 165, height: height)
    }
    
    private func cardIcon(of imageName: String, card: Card) -> some View {
        Button(action: {
            switch card {
            case .guitar:
                guitarCardDescription = "We don't like liars, Beqa!"
            case .chat:
                chatCardBackgroundColor = Color.blue
            case .voice:
                break
            }
        }) {
            ZStack {
                //background fill of the icon
                Circle()
                    .fill(Color.white.opacity(0.22))
                    .frame(width: 32, height: 32)
                
                //icon itself
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
            }
        }
    }
    
    private func cardTitle(with text: String) -> some View {
        Text(text)
            .font(.system(size: 9, weight: .medium))
            .lineLimit(2)
            .frame(width: 100, alignment: .leading)
            .multilineTextAlignment(.leading)
            .foregroundStyle(Color.white)
            .fixedSize(horizontal: false, vertical: true)
        
    }
    
    private func cardDescription(with text: String) -> some View {
        Text(text)
            .font(.system(size: 17, weight: .bold))
            .multilineTextAlignment(.leading)
            .lineLimit(4)
            .frame(width: 120)
            .foregroundStyle(Color.white)
    }
    
}
