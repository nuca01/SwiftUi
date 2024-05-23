//
//  ContentView.swift
//  assignment28
//
//  Created by nuca on 22.05.24.
//

import SwiftUI

struct ContentView: View {
    //MARK: - Properties
    //MARK: - Main View
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading) {
                titleText
                cards
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 0))
                notes
            }
            reloadButton
        }
    }
    
    //MARK: - Title
    private var titleText: some View {
        Text("svibti iuai eksersaisi")
            .font(.system(size: 34, weight: .bold))
            .foregroundStyle(Color.white)
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
    }
    
    //MARK: - Cards
    @State private var chatCardBackgroundColor: Color = Color(
        red: 1,
        green: 0.518,
        blue: 0.294
    )
    @State private var guitarCardDescription: String = "We love property wrappers and closures"
    
    private var cards: some View {
        HStack(alignment: .top, spacing: 15) {
            card(of: .guitar)
            VStack(alignment: .leading, spacing: 15) {
                card(of: .chat)
                card(of: .voice)
            }
        }
    }
    
    //MARK: - Notes
    private var notes: some View {
        ScrollView {
            listOfNotes()
        }
    }
    
    //MARK: - Reload Button
    @State private var buttonBackgroundColor: Color = Color.blue
    
    private var reloadButton: some View {
        Button(action: {
            buttonBackgroundColor = Color.purple
        }) {
            Image(systemName: "arrow.clockwise")
                .foregroundColor(.white)
                .padding()
                .background(buttonBackgroundColor)
                .clipShape(Circle())
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
    }
    
    //MARK: - Dictionary
    private var notesContainer: [String : String] = [
        "არა რუსულ კანონს" : "ვინმემ ხომ არ იცით ქვეყნის ასაწყობი framework-ი? წინას 41.0 აფდეითი გავუკეთეთ და გაჭედა ვერ ვშველით",
        "რამდენი ჩურჩხელა დარჩა დავითს?" : "გასაგზავნი რო იქნება გაგვაგებინეთ",
        "31-ის რეალური ვიანობა" : "მამუკა მდინარაძის დაკვირვებით ოცდამეთერთმეტე რეალურად მეცხრეა. ასევე არსებობს სპეკულაციები რომ 31-ე ინფლაციამ მოიტანა",
        "ხანგრძლივი სიყვარულის ისტორია: swiftUI" : "თეთრ რაშზე ამხედრებული პრინცი? more like ადვილად ასაწყობი ui.",
        "რატომ აღარ უხსენებია ბექას ლელა?" : "შემდეგი კაჰუტისთვის გაარკვიეთ",
        "რა დაუწუნა ბარბარემ ნიკის?" : "ნიკის ამაზე ჯერ განცხადება არ გაუკეთებია, ფანები ელოდებიან რომ რომელიმე მალე სიჩუმეს გაფანტავს",
        "რა ზომის ფეხი აქვს ვასოს?" : "დეველოპერებმა განაცხადეს რომ თუ მას 42 და მეტი ზომა ფეხი აქვს მის მოსმენას აზრი არ აქვს და კომენტარის გარეშე დატოვებენ ლექციას",
    ]
    
    //MARK: - Cards' Helper Enum
    private enum Card {
        case guitar
        case chat
        case voice
    }
    
    //MARK: - Cards' Helper Methods
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
                backgroundColor: Color(red: 0.498, green: 0.212, blue: 0.969),
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
            .padding(EdgeInsets(top: 15, leading: 11, bottom: 10, trailing: 40))
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
    
    //MARK: - Notes' Helper Methods
    private func listOfNotes() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(notesContainer.sorted(by: <), id: \.key) { key, value in
                note(
                    with: key,
                    and: value
                )
                .padding(EdgeInsets(top: 13, leading: 13, bottom: 10, trailing: 40))
                separator()
            }
        }
    }
    
    private func separator() -> some View  {
        Rectangle()
            .frame(height: 1)
            .foregroundStyle(Color(red: 0.31, green: 0.31, blue: 0.31))
    }
    
    private func note(with title: String, and description: String) -> some View {
        
        HStack(alignment: .top, spacing: 16) {
            noteIcon()
            VStack(alignment: .leading) {
                noteTitle(with: title)
                noteDescription(with: description)
            }
        }
    }
    
    private func noteIcon() -> some View {
        Image("note")
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .frame(width: 40, height: 40)
    }
    
    private func noteTitle(with text: String) -> some View {
        Text(text)
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.white)
    }
    
    private func noteDescription(with text: String) -> some View {
        Text(text)
            .font(.system(size: 10, weight: .bold))
            .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
    }
    
}

#Preview {
    ContentView()
        .background(Color(red: 0.098, green: 0.145, blue: 0.169))
}
