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
            
            // Show next lesson button, only if there's a next lesson
            if model.hasNextLesson() {
                let nextLesson = model.currentModule!.content.lessons[model.currentLessonIndex+1]
                
                Button(
                    action: {
                        model.nextLesson()
                    },
                    label: {
                        ZStack {
                            Rectangle()
                                .frame(height: 50)
                                .foregroundColor(.green)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                            
                            Text("Next lesson: \(nextLesson.title)")
                                .foregroundColor(.white)
                                .bold()
                        }
                        
                    })
            }
            
        }
        .padding()
        
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
