//
//  ContentView.swift
//  Learning
//
//  Created by 王柏凱 on 2021-12-07.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model: ContentModel
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("What do you want to do today?")
                    .padding(.leading, 20)
                ScrollView {
                    LazyVStack {
                        ForEach(model.modules) { module in
                            VStack(spacing: 20) {
                                NavigationLink(
                                    tag: module.id,
                                    selection: $model.currentContentSelected,
                                    destination: {
                                        ContentView()
                                            .onAppear {
                                            model.beginModule(moduleId: module.id)
                                        }
                                    },
                                    label: {
                                        // Learning Card
                                        HomeViewRow(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, count: "\(module.content.lessons.count) Lessons", time: module.content.time)
                                    })
                                
                                NavigationLink(
                                    tag: module.id,
                                    selection: $model.currentTestSelected,
                                    destination: {
                                        TestView()
                                            .onAppear {
                                            model.beginTest(moduleId: module.id)
                                        }
                                    },
                                    label: {
                                        // Test Card
                                        HomeViewRow(image: module.test.image, title: "\(module.category) Test", description: module.test.description, count: "\(module.test.questions.count) Lessons", time: module.test.time)
                                    })
                            }
                            .padding(.bottom, 12)
                        } // ForEach
                    } // LazyVStack
                    .tint(.black)
                    .padding()
                    
                }
            }
            .navigationTitle("Get started")
        }
        .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
