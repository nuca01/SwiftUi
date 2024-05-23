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
                CardsView()
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
    
    //MARK: - Notes
    private var notes: some View {
        ScrollView {
            listOfNotes()
        }
    }
    
    //MARK: - Reload Button
    @State private var buttonBackgroundColor: Color = Color(
        red: 0.424,
        green: 0.784,
        blue: 0.992
    )
    
    private var reloadButton: some View {
        Button(action: {
            buttonBackgroundColor = Color.purple
        }) {
            Image("reload")
                .resizable()
                .frame(width: 18, height: 16)
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
    
    //MARK: - Notes' Helper Methods
    private func listOfNotes() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(notesContainer.sorted(by: <), id: \.key) { key, value in
                note(
                    with: key,
                    and: value
                )
                .padding(EdgeInsets(
                    top: 13,
                    leading: 13,
                    bottom: 10,
                    trailing: 40
                ))
                separator()
            }
        }
    }
    
    private func separator() -> some View  {
        Rectangle()
            .frame(height: 1)
            .foregroundStyle(Color(
                red: 0.31,
                green: 0.31,
                blue: 0.31
            ))
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
            .foregroundColor(Color(
                red: 0.4,
                green: 0.4,
                blue: 0.4
            ))
    }
}

#Preview {
    ContentView()
        .background(Color(red: 0.098, green: 0.145, blue: 0.169))
}
