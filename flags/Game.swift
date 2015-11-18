//
//  Game.swift
//  Flags
//
//  Created by Stephen Henderson on 2015-11-17.
//  Copyright © 2015 hevets. All rights reserved.
//

import GameplayKit
import Foundation

protocol Questionable {
    var items:[String] { get set }
    var right:Int { get set }
    var wrong:Int { get set }
    var score:Int { get set }
    var correctAnswer:Int { get set }
    var maxWrong:Int { get set }
//    var possibleAnswers:[String] { get set }
    func prepareNextQuestion() -> [String]
    func askQuestion() -> (answer: Int, items: [String])
    func checkAnswer(answer:Int) -> Bool
    func isGameOver() -> Bool
}

class Game: NSObject, Questionable {
    var items:[String]
    var right:Int
    var wrong:Int
    var score:Int
    var maxWrong:Int
    var correctAnswer:Int
//    var possibleAnswers:[String]

    init(newItems:[String], newMaxWrong:Int = 9999999) {
        items = newItems
        right = 0
        wrong = 0
        score = 0
        correctAnswer = -1
//        possibleAnswers = []
        maxWrong = newMaxWrong
    }

    func prepareNextQuestion() -> [String] {
        correctAnswer = GKRandomSource.sharedRandom().nextIntWithUpperBound(3) // can make the game more variable (ie number of buttons here)
        items = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(self.items) as! [String]

        return Array(items.prefix(3))
    }

    func askQuestion() -> (answer: Int, items: [String]) {
        let possibleAnswers = self.prepareNextQuestion()
        return (answer: correctAnswer, items: possibleAnswers)
    }

    func checkAnswer(answer: Int) -> Bool {
        if answer == correctAnswer {
            ++right
            return true
        } else {
            ++wrong
            return false
        }
    }

    func isGameOver() -> Bool {
        return false
    }

    private func formatName(name: String) -> String {
        return String(name.stringByReplacingOccurrencesOfString("_", withString: " "))
    }
}
