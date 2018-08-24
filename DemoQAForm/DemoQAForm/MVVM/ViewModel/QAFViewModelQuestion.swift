//
//  QAFViewModelQuestion.swift
//  DemoVogueStore
//
//  Created by Bharat Byan on 16/08/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//
import Foundation
import UIKit

class QAFViewModelQuestion{
    
    typealias tupleAnswer = (String, Bool)
    
    var title: String?
    var description: String?
    var options_answers: [tupleAnswer] = []
    var options_correct: [Int]?
    var user_selected_answers: [Int]?
    var type: Int?
    var isRead: Bool?
    var isAnswered: Bool?
    var isCorrect: Bool?
        
    // Intialising the viewmodel with model object
    
    init(_ model: QAFModelQuestion){
        
        title = model.title
        self.title = model.title
        self.description = model.description
        
        for answerOption in model.options_answers! {
            var tupple: tupleAnswer
            tupple.0 = answerOption
            tupple.1 = false
            
            self.options_answers.append(tupple)
        }
        
        self.options_correct = model.options_correct
        self.user_selected_answers = model.user_selected_answers
        self.type = model.type
        self.isRead = model.isRead
        self.isAnswered = model.isAnswered
        self.isCorrect = model.isCorrect
    }
}

