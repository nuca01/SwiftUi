//
//  SearchPageView.swift
//  assignment34
//
//  Created by nuca on 06.06.24.
//

import SwiftUI
import SwiftData

struct SearchPageView: View {
    //MARK: - Properties
    @ObservedObject private var viewModel: SearchPageViewModel
    @Environment(\.modelContext) var context
    
    @State private var showPicker: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack {
                        CustomSearchBar(searchText: $viewModel.searchQuery)
                        
                        picker
                    }
                    
                    MoviesList(viewModel: MoviesListViewModel(movies: viewModel.results))
                        .modelContainer(context.container)
                }
                .background(Color(uiColor: UIColor.secondarySystemBackground))
                
                explanationText
            }        }
    }
    
    private var explanationText: some View {
        VStack(spacing: 20) {
            if let results = viewModel.results, results.isEmpty {
                Text(
                    viewModel.searchQuery.isEmpty ?
                    "Use The magic Search!" : "oh no isn’t this so embarrassing?"
                )
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                
                Text(
                    viewModel.searchQuery.isEmpty ? 
                    "I will do my best to search everything relevant, I promise!" : "I cannot find any movie with this name."
                )
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
            }
        }
    }
    
    private var picker: some View {
        Menu {
            Picker(selection: $viewModel.selection, label: pickerImage, content: {
                Text("Name").tag("Name")
                
                Text("Genre").tag("Genre")
                
                Text("Year").tag("Year")
            })
        } label: {
             pickerImage
        }
        .padding(.trailing)
    }
    
    private var pickerImage: some View {
        Image("Picker")
            .resizable()
            .foregroundStyle(Color(uiColor: UIColor.label))
            .frame(width: 30, height: 30)
    }
    
    //MARK: - Initializer
    init(viewModel: SearchPageViewModel) {
        self.viewModel = viewModel
    }
}


//MARK: - CustomSearchBar
struct CustomSearchBar: View {
    //MARK: - Properties
    @Binding var searchText: String
    @State private var isEditing = false

    var body: some View {
        HStack {
            textfield

            if isEditing {
                cancelButton
            }
        }
    }
    
    private var cancelButton: some View {
        Button(action: {
            self.isEditing = false
            self.searchText = ""
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }) {
            Text("Cancel")
        }
        .padding(.trailing, 10)
        .transition(.move(edge: .trailing))
    }
    
    private var clearButton: some View {
        Button(action: {
            self.searchText = ""
        }) {
            Image(systemName: "multiply.circle.fill")
                .foregroundColor(.gray)
                .padding(.trailing, 8)
        }
    }
    
    private var textfield: some View {
        TextField("Search...", text: $searchText)
            .padding(12)
            .padding(.horizontal, 10)
            .background(Color("SearchBarColor", bundle: nil))
            .cornerRadius(18)
            .overlay(
                HStack {
                    Spacer()
                    
                    if isEditing {
                        clearButton
                    } else {
                        magnifyingGlassImage
                    }
                }
            )
            .padding(.horizontal, 10)
            .onTapGesture {
                self.isEditing = true
            }
    }
    
    private var magnifyingGlassImage: some View {
        Image("search")
            .resizable()
            .foregroundColor(Color(uiColor: UIColor.systemGray))
            .frame(width: 20, height: 20)
            .padding(.trailing, 12)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Movie.self, configurations: config)

    return SearchPageView(viewModel: SearchPageViewModel())
        .modelContainer(container)
}
