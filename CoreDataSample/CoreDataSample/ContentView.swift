//
//  ContentView.swift
//  CoreDataSample
//
//  Created by 0x2ab70001b1 on 2023/8/16.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var textFieldText: String = ""
    
    @FetchRequest(
        entity: Student.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Student.name, ascending: true)])
    private var students: FetchedResults<Student>
    
    let textBgColor = #colorLiteral(red: 0.9496834874, green: 0.9635508657, blue: 1, alpha: 1)
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField(text: $textFieldText) { Text("Add student name") }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.leading)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color(uiColor: textBgColor))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button {
                    addItem()
                } label: {
                    Text("ADD")
                        .foregroundColor(Color.white)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.leading)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                
                List {
                    ForEach(students) { student in
                        Text(student.name ?? "")
                            .onTapGesture {
                                updateItem(student: student)
                            }
                    }
                    .onDelete(perform: deleteItems)
                }
                .listStyle(.plain)
            }
            .navigationTitle("Core data sample")
        }
    }
    
    // Add
    private func addItem() {
        withAnimation {
            let newItem = Student(context: viewContext)
            newItem.name = textFieldText
            
            saveItem()
            
            textFieldText = ""
        }
    }
    
    // Delete
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            guard let index = offsets.first else { return }
            let student = students[index]
            viewContext.delete(student)
            saveItem()
        }
    }
    
    // Update
    private func updateItem(student: Student) {
        withAnimation {
            let name = student.name ?? ""
            let newName = name + "6"
            student.name = newName
            
            saveItem()
        }
    }
    
    private func saveItem() {
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
