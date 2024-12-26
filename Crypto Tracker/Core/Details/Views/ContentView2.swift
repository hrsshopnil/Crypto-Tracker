//
//  ContentView.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 26/12/24.
//


import SwiftUI

struct ContentView2: View {
    @State private var currentQuestionIndex = 0
    @State private var selectedOptionIndex: Int? = nil
    @State private var isQuizFinished = false
    @State private var timeElapsed = 0
    @State private var timer: Timer? = nil
    
    let questions: [QuizQuestion] = [
        QuizQuestion(question: "What is the capital of France?",
                     options: ["Berlin", "Madrid", "Paris", "Rome"],
                     correctOptionIndex: 2),
        QuizQuestion(question: "What is 2 + 2?",
                     options: ["3", "4", "5", "6"],
                     correctOptionIndex: 1),
        QuizQuestion(question: "Who wrote 'Macbeth'?",
                     options: ["Charles Dickens", "William Shakespeare", "J.K. Rowling", "George Orwell"],
                     correctOptionIndex: 1)
    ]
    
    var body: some View {
        VStack {
            Text("Time: \(timeElapsed) seconds")
                .font(.headline)
                .padding()
            
            if isQuizFinished {
                List {
                    ForEach(0..<questions.count, id: \.self) { index in
                        QuestionResultView(
                            question: questions[index],
                            userAnswerIndex: selectedOptionIndex == index ? selectedOptionIndex : nil
                        )
                    }
                }
                Button("Restart Quiz") {
                    restartQuiz()
                }
                .padding()
            } else {
                Text(questions[currentQuestionIndex].question)
                    .font(.title)
                    .padding()
                
                ForEach(0..<4, id: \.self) { optionIndex in
                    Button(action: {
                        selectedOptionIndex = optionIndex
                        moveToNextQuestion()
                    }) {
                        Text(questions[currentQuestionIndex].options[optionIndex])
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(8)
                    }
                }
            }
        }
        .padding()
        .onAppear(perform: startTimer)
        .onDisappear(perform: stopTimer)
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            timeElapsed += 1
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func moveToNextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            isQuizFinished = true
            stopTimer()
        }
    }
    
    func restartQuiz() {
        currentQuestionIndex = 0
        selectedOptionIndex = nil
        isQuizFinished = false
        timeElapsed = 0
        startTimer()
    }
}

struct QuizQuestion {
    let question: String
    let options: [String]
    let correctOptionIndex: Int
}

struct QuestionResultView: View {
    let question: QuizQuestion
    let userAnswerIndex: Int?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(question.question)
                .font(.headline)
            ForEach(0..<4, id: \.self) { index in
                Text(question.options[index])
                    .padding()
                    .background(
                        userAnswerIndex == index
                            ? (index == question.correctOptionIndex ? Color.green : Color.red)
                            : (index == question.correctOptionIndex ? Color.green.opacity(0.2) : Color.clear)
                    )
                    .cornerRadius(8)
            }
        }
        .padding(.vertical)
    }
}

#Preview(body: {
    ContentView2()
})
