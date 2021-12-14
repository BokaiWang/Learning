//
//  TestView.swift
//  Learning
//
//  Created by Bo-Kai Wang on 2021-12-14.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var model: ContentModel
    @State var selectedAnswerIndex = -1
    @State var numCorret = 0
    @State var submitted = false
    
    var body: some View {
        if model.currentQuestion != nil {
            VStack(alignment:.leading) {
                // Question number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                    .padding(.leading, 20)
                // Question
                CodeTextView()
                    .padding(.horizontal, 20)
                
                // Answers
                ScrollView {
                    VStack {
                        ForEach(0..<model.currentQuestion!.answers.count) { index in
                            Button {
                                // Track the selected index
                                selectedAnswerIndex = index
                            } label: {
                                ZStack {
                                    if !submitted {
                                        // Answer hasn't been submitted
                                        RectangleCard(color: index == selectedAnswerIndex ? .gray : .white)
                                            .frame(height:50)
                                        
                                    }
                                    else {
                                        // Answer has been submitted
                                        if index == selectedAnswerIndex && index == model.currentQuestion!.correctIndex {
                                            // User selcted the right answer
                                            RectangleCard(color: .green)
                                                .frame(height:50)
                                        }
                                        else if index == selectedAnswerIndex && index != model.currentQuestion!.correctIndex {
                                            // User selected the wrong answer
                                            RectangleCard(color: .red)
                                                .frame(height:50)
                                        }
                                        else if index == model.currentQuestion!.correctIndex {
                                            RectangleCard(color: .green)
                                                .frame(height:50)
                                        }
                                        else {
                                            RectangleCard(color: .white)
                                                .frame(height:50)
                                        }
                                    }
                                    Text(model.currentQuestion!.answers[index])
                                    
                                }
                            }
                            .disabled(submitted)
                        }
                    } // VStack
                    .tint(.black)
                    .padding()
                } // ScrollView
                
                // Submit Button
                Button {
                    // Change submitted state to true
                    submitted = true
                    // Check the answer and increment the counter if correct
                    if selectedAnswerIndex == model.currentQuestion!.correctIndex {
                        numCorret += 1
                    }
                    
                } label: {
                    ZStack {
                        RectangleCard(color: .green)
                            .frame(height:50)
                        Text("Submit")
                            .bold()
                            .tint(Color.white)
                            
                    }
                    .padding()
                }
                .disabled(selectedAnswerIndex == -1)

            }
            .navigationTitle("\(model.currentModule?.category ?? "") Test")
        }
        else {
            // Test hasn't loaded yet
            ProgressView()
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
