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
                        ForEach(0..<model.currentQuestion!.answers.count, id: \.self) { index in
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
                                        if index == model.currentQuestion!.correctIndex {
                                            // The right answer
                                            RectangleCard(color: .green)
                                                .frame(height:50)
                                        }
                                        else if index != model.currentQuestion!.correctIndex && index == selectedAnswerIndex {
                                            // User selected the wrong answer
                                            RectangleCard(color: .red)
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
                    // Check if answer has been submitted
                    if submitted == true {
                        // Answer has already been submitted, move to next question
                        model.nextQuestion()
                        // Reset properties
                        submitted = false
                        selectedAnswerIndex = -1
                    }
                    else {
                        // Change submitted state to true
                        submitted = true
                        // Check the answer and increment the counter if correct
                        if selectedAnswerIndex == model.currentQuestion!.correctIndex {
                            numCorret += 1
                        }
                    }
                } label: {
                    ZStack {
                        RectangleCard(color: .green)
                            .frame(height:50)
                        Text(buttonText)
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
    
    var buttonText:String {
        if submitted {
            // This is the last question
            if model.currentQuestionIndex+1 == model.currentModule!.test.questions.count {
                return "Finish"
            }
            else {
                // There is a next question
                return "Next"
            }
        }
        else {
            return "Submit"
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
