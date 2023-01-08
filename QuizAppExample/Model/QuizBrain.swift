//
//  QuizBrain.swift
//  QuizAppExample
//
//  Created by Markel Juaristi on 8/1/23.
//

import Foundation

import UIKit

struct QuizBrain {
    let questions = [
        Question(text: "Tokyo always has been the capital of Japan.", answer: "FALSE", color: UIColor.black, image: UIImage(named: "tokyo")!),
        Question(text: "Los nativos americanos enterraban sus hachas cuando hacían las paces.", answer: "TRUE", color: UIColor.black, image: UIImage(named: "indios")!),
        Question(text: "El punto llamado NEMO es el punto más difícil de alcanzar de todo el planeta.", answer: "TRUE", color: UIColor.black, image: UIImage(named: "nemo")!)
        
    ]
    
    var numQuestion = 0
    var score = 0
    
    mutating func checkAnswer( userAnswer: String) -> Bool {
        if userAnswer == questions[numQuestion].answer {
            score += 1
            return true
        } else {
            return false
        }
        
    }
    
    func getScore() -> Int {
        return score
        
    }
    
    func getTextQuestion() -> String {
        return questions[numQuestion].text
    }
    func getProgess() -> Float    {
        let progress = Float(numQuestion + 1 ) / Float(questions.count)
        return progress
    }
    
    func getColor() -> UIColor {
        return questions[numQuestion].color
    }
    
    func getImage() ->UIImage {
        return questions[numQuestion].image
    }
    mutating func nextQuestion() ->Bool {
        if numQuestion + 1 < questions.count {
            numQuestion += 1
            return false
        } else {
            numQuestion = 0
            return true
            
        }
    }
}
