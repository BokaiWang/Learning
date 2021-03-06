//
//  ContentView.swift
//  Learning
//
//  Created by 王柏凱 on 2021-12-09.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                if model.currentModule != nil {
                    ForEach(0..<model.currentModule!.content.lessons.count, id: \.self) { index in
                        NavigationLink(
                            destination: {
                                ContentDetailView()
                                    .onAppear {
                                        model.beginLesson(lessonIndex: index)
                                    }
                        },
                            label: {
                                ContentViewRow(index: index)
                        })
                        
                    }
                }
            }
            .tint(.black)
            .padding()
            .navigationTitle("Learn \(model.currentModule?.category ?? "")")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
