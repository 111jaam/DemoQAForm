//
//  QAFModelQuestion.swift
//  DemoVogueStore
//
//  Created by Bharat Byan on 16/08/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//
import Foundation
import SwiftyJSON

class QAFModelQuestion {
    
    var title: String?
    var description: String?
    var options_answers: [String]?
    var options_correct: [Int]?
    var user_selected_answers: [Int]?
    var type: Int?
    var isRead: Bool?
    var isAnswered: Bool?
    var isCorrect: Bool?
    
    //Initialising model with JSON object
    init(obj:JSON?) {
        self.title = obj!["title"].string
        self.description = obj!["description"].string
        self.options_answers = obj!["options_answers"].arrayValue.compactMap({ $0.string })
        self.options_correct = obj!["options_correct"].arrayValue.compactMap({ $0.int })
        self.user_selected_answers = obj!["user_selected_answers"].arrayValue.compactMap({ $0.int })
        self.type = obj!["type"].int
        self.isRead = obj!["isRead"].bool
        self.isAnswered = obj!["isAnswered"].bool
        self.isCorrect = obj!["isCorrect"].bool
    }
}
