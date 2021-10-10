//
//  Highscore.swift
//  typeThis
//
//  Created by Tyler Hernandez on 7/18/21.
//

import Foundation

class Highscore {
    
    private var currentScore = 0
    private var currentUsername = "BLANK"
    private var historyScore : [Int]
    private var historyName : [String]
    
    init() {
        // replace these with getHighScores once complete
        self.currentScore = 9999999
        self.currentUsername = "testName"
        self.historyScore = [9999998]
        self.historyName = ["testHistoryName"]
        // end replace

    }
    
    func getHighScores() { // TODO: retrieve high scores from device (just like YoshApp)
        self.currentScore = 1
        self.currentUsername = "testName"
        self.historyScore.append(1)
        self.historyName.append("testHistoryName")
        return
    }
    
    func checkHighScore (newScore : Int, newUsername : String){
        if currentScore > newScore {
           // add current score to history
            guard addScoreToHistory() else { print("Something went wrong saving scores!") ; return }
           // replace variables with updated info
            setHighScore(newHighScore: newScore, newUsername: newUsername)
        }
    }
    
    func setHighScore (newHighScore : Int, newUsername : String) {
        currentScore = newHighScore
        currentUsername = newUsername
    }
    
    func addScoreToHistory () -> Bool {
        historyScore.append(currentScore)
        historyName.append(currentUsername)
        return true
    }
    func toString () {
        print("\ncurrentScore:")
        print(currentScore)
        print("\ncurrentUsername:")
        print(currentUsername)
        print("\nhistoryScore:")
        print(historyScore)
        print("\nhistoryName:")
        print(historyName)
    }
}
