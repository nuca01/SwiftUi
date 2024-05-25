//
//  ContentView.swift
//  assignment29
//
//  Created by nuca on 23.05.24.
//

import SwiftUI


struct Task: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let date: String
    var isCompleted: Bool
    var color: Color? = nil
}

struct ContentView: View {
    //MARK: - Properties
    var body: some View {
        HStack {
            Spacer()
                .frame(maxWidth: 20)
            
            VStack() {
                HStack(alignment: .top) {
                    title
                    
                    Spacer()
                    
                    photoView
                }
                
                Spacer()
                    .frame(maxHeight: 20)
                
                completeAllButton
                
                Spacer()
                
                ScrollView {
                    VStack(alignment: .center){
                        progressView
                        tasksList()
                    }
                }
                
                Spacer()
            }
            
            Spacer()
                .frame(maxWidth: 20)
        }
        .background(Color("Background"))
    }
    
    private let colorArray = [
        Color(red: 0.98, green: 0.796, blue: 0.729),
        Color(red: 0.843, green: 0.941, blue: 1),
        Color(red: 0.98, green: 0.85, blue: 1),
    ]
    
    //MARK: - Tasks
    //@ObservedObject არ გამოვიყენე რადგან კონტეინერს არ აქვს პროტოკოლი დაკონფორმებული
    @State private var tasks: [Task] = [
        Task(title: "Mobile App Research", date: "4 Oct", isCompleted: false),
        Task(title: "Prepare Wireframe for Main Flow", date: "4 Oct", isCompleted: false),
        Task(title: "Prepare Screens", date: "4 Oct", isCompleted: false),
        Task(title: "Website Research", date: "5 Oct", isCompleted: false),
        Task(title: "Prepare Wireframe for Main Flow", date: "5 Oct", isCompleted: false),
        Task(title: "Prepare Screens", date: "5 Oct", isCompleted: false)
    ]
    
     private var completedTasks: [Task] {
        var filtered = tasks.filter { $0.isCompleted }
         
        for (index, _) in filtered.enumerated() {
            filtered[index].color = colorArray[index % 3]
        }
        return filtered
    }
    
    private var incompleteTasks: [Task] {
        var filtered = tasks.filter { !$0.isCompleted }
        
        for (index, _) in filtered.enumerated() {
            filtered[index].color = colorArray[index % 3]
        }
        return filtered
    }
    
    //MARK: - Progress Bar View
    private var progressView: some View {
        VStack(alignment: .leading) {
            Spacer(minLength: 10)
            
            sectionTitle(with: "Progress")
            
            VStack(alignment: .leading) {
                progressText()
                progressBar()
            }
            .padding()
            .background(Color("SecondaryBackground"))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Spacer(minLength: 30)
        }
    }
    
    //MARK: - Upper View
    private var title: some View {
        Text("You have \(incompleteTasks.count) tasks to complete")
            .font(.system(size: 25, weight: .semibold))
            .lineLimit(2)
            .frame(width: 250, alignment: .leading)
            .multilineTextAlignment(.leading)
            .fixedSize(horizontal: false, vertical: true)
    }
    
    private var photoView: some View {
        VStack {
            Spacer()
                .frame(maxHeight: 3)
            
            ZStack(alignment: .bottomTrailing){
                profilePictureWithBackground()
                    .padding(EdgeInsets(
                        top: 0,
                        leading: 0,
                        bottom: 5,
                        trailing: 0
                    ))
                
                circleWithNumber()
                    .padding(EdgeInsets(
                        top: 0,
                        leading: 0,
                        bottom: 0,
                        trailing: 5
                    ))
            }
        }
    }
    
    private var completeAllButton: some View {
        Button(action: {
            for index in tasks.indices {
                tasks[index].isCompleted = true
            }
        }) {
            Text("Complete All")
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(LinearGradient(
                    gradient: Gradient(colors: [
                        Color(
                            red: 0.45,
                            green: 0.67,
                            blue: 1
                        ),
                        Color(
                            red: 0.27,
                            green: 0.75,
                            blue: 0.76
                        )
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                ))
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
    
    //MARK: - Methods
    private func toggleTaskCompletion(task: Task, isCompleted: Bool) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted = isCompleted
        }
    }
    
    private func semiTitle(with text: String) -> some View {
        Text(text)
            .font(.system(size: 16))
    }
    
    
    private func sectionTitle(with text: String) -> some View {
        Text(text)
            .font(.system(size: 22))
    }

    //MARK: - Upper View HelperMethods
    private func profilePictureWithBackground() -> some View {
        ZStack(alignment: .center) {
            Circle()
                .frame(width: 49, height: 49)
                .foregroundStyle(
                    Gradient(
                        colors: [
                            Color(
                                red: 0.73,
                                green: 0.51,
                                blue: 0.87
                            ),
                            Color(
                                red: 0.851,
                                green: 0.851,
                                blue: 0.851,
                                opacity: 0
                            )
                        ]
                    )
                )
            
            Image("profile")
                .resizable()
                .frame(width: 44, height: 45)
        }
    }
    
    private func circleWithNumber() -> some View {
        ZStack(alignment: .center) {
            Circle()
                .foregroundStyle(Color(
                    red: 1,
                    green: 0.46,
                    blue: 0.23
                ))
                .frame(width: 15, height: 15)
            
            Text("\(incompleteTasks.count)")
                .font(.system(size: 9))
                .foregroundStyle(Color.white)
        }
    }
    
    private func tasksList() -> some View {
        VStack(alignment: .leading) {
            sectionTitle(with: "Completed Tasks")
            
            ForEach(completedTasks, id: \.self) { task in
                taskCell(of: task)
            }
            
            Spacer(minLength: 30)
            
            ForEach(incompleteTasks, id: \.self) { task in
                taskCell(of: task)
            }
        }
    }
    
    //MARK: - Tasks List Helper Methods
    private func taskCell(of task: Task) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.system(size: 16))
                
                dateView(with: task.date)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(EdgeInsets(
                top: 20,
                leading: 25,
                bottom: 20,
                trailing: 20
            ))
            .overlay(alignment: .leading) {
                Rectangle()
                    .frame(width: 15)
                    .frame(alignment: .leading)
                    .foregroundStyle(task.color ?? Color.black)
            }
            
            if task.isCompleted {
                Button(action: {
                    toggleTaskCompletion(task: task, isCompleted: false)
                }, label: {
                    Image("checkImage")
                        .resizable()
                        .frame(width: 26, height: 26)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                })
            } else {
                Button(action: {
                    toggleTaskCompletion(task: task, isCompleted: true)
                }, label: {
                    Circle()
                        .stroke(lineWidth: 2)
                        .frame(width: 26, height: 26)
                        .foregroundStyle(Color.blue)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                })
            }
        }
        .background(Color("SecondaryBackground"))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    private func dateView(with date: String) -> some View {
        HStack {
            Image("date")
                .resizable()
                .renderingMode(.template)
                .frame(width: 15, height: 16.67)
                .opacity(0.8)
            
            
            Text(date)
                .font(.system(size: 14))
                .opacity(0.8)
        }
    }
    
    //MARK: - ProgressBarView Helper Methods
    private func progressText() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Daily Task")
                .font(.system(size: 18, weight: .medium))
            
            Text("\(completedTasks.count)/\(tasks.count) Task Completed")
                .font(.system(size: 16))
                .opacity(0.8)
            
            if incompleteTasks.count > 0 {
                Text("Keep Working")
                    .font(.system(size: 14, weight: .light))
                    .opacity(0.8)
            } else {
                Text("Good Job")
                    .font(.system(size: 14, weight: .light))
                    .opacity(0.8)
            }
        }
    }
    
    private func progressBar() -> some View {
        var percent = Double(completedTasks.count) / Double(tasks.count)
        
        return ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(.shadow(.inner(
                    color:Color.black,
                    radius: 5,
                    x:3,
                    y: 3
                )))
                .frame(height: 18)
                .foregroundStyle(Color(
                    red: 0.45,
                    green: 0.67,
                    blue: 1,
                    opacity: 0.25
                ))
            
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(.shadow(.inner(
                        color:Color.black.opacity(0.5),
                        radius: 5,
                        x: 3,
                        y: 3
                    )))
                    .frame(width: geometry.size.width * percent, height: 18)
                    .foregroundStyle(Color(
                        red: 0.45,
                        green: 0.67,
                        blue: 1
                    ))
            }
        }
    }
}

#Preview {
    ContentView()
}
