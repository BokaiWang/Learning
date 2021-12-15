//
//  ContentDetailView.swift
//  Learning
//
//  Created by Bo-Kai Wang on 2021-12-11.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        
        VStack {
            // Only show video if we get a valid url
            if url != nil {
                VideoPlayer(player: AVPlayer(url: url!))
                    .cornerRadius(10)
            }
            
            // Description
            CodeTextView()
            
            // Show next lesson button, only if there's a next lesson
            if model.hasNextLesson() {
                let nextLesson = model.currentModule!.content.lessons[model.currentLessonIndex+1]
                
                Button(
                    action: {
                        model.nextLesson()
                    },
                    label: {
                        ZStack {
                            RectangleCard(color: .green)
                                .frame(height: 50)
                            
                            Text("Next lesson: \(nextLesson.title)")
                                .foregroundColor(.white)
                                .bold()
                        }
                        
                    })
            }
            else {
                // Show the complete button
                Button(
                    action: {
                        // Take the user back to the homeview
                        model.currentContentSelected = nil
                    },
                    label: {
                        ZStack {
                            RectangleCard(color: .green)
                                .frame(height: 50)
                            
                            Text("Complete")
                                .foregroundColor(.white)
                                .bold()
                        }
                    })
            }
            
        }
        .padding()
        .navigationTitle(lesson?.title ?? "")
        
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
