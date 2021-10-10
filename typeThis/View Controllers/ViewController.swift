//
//  ViewController.swift
//  typeThis
//
//  Created by Tyler Hernandez on 4/16/21.
//

import UIKit
import AVFoundation
import Pods_typeThis

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var prompt: UILabel!
    @IBOutlet weak var yourText: UILabel!
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var millisLabel: UILabel!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var youTypedLabel: UILabel!
    @IBOutlet weak var resultsLabel: UILabel!
    var timeStart = 0
    var timeEnd = 0
    var timeTaken = 0
    var promptArray : [Character] = []
    let randomSentences = [
    "The elephant did not want to talk about the person in the room",
    "The truth is that you pay for your lifestyle in hours",
    "She realized the only way she was getting into heaven was to cheat",
    "He wondered if it could be called a beach if there was no sand",
    "Her screams immediately silenced the rowdy group of teenagers",
    "There was no telling what thoughts would come from the machine",
    "With a single flip of the coin his life changed forever",
    "I think I will either buy the red car or lease the blue one",
    "She could not decide if the glass was half empty or half full",
    "He had accidentally hacked into his own company server"
    ] //10 prompts as of 4/16
   // test prompts
    // let randomSentences = ["the apple", "the apple", "the apple", "the apple", "the apple", "the apple", "the apple", "the apple", "the apple", "the apple"]
    let highscore = Highscore()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.userInput.delegate = self
        self.view.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        self.view.endEditing(true)
//        return false
//    }
    

    
    func getTimeMillis() -> Int {
        return Int(Int64(Date().timeIntervalSince1970 * 1000))
    }
    
//    func setHighscore() ->Void {
//
//    }
    
    func choosePrompt() -> String {
        let randomInt = Int.random(in: 0..<10) // will generate any number between and including 0-9
        return randomSentences[randomInt]
    }
    
    func displayEndLabels() -> Void {
        promptLabel.text = "Prompt:"
        youTypedLabel.text = "You typed:"
        resultsLabel.text = "Results: "
    }
    
    func clearEndLabels() -> Void {
        promptLabel.text = " "
        youTypedLabel.text = " "
        yourText.text = " "
    }
    
    @IBAction func onStartTyping(_ sender: Any) {
        //first let's clear the unnecessary labels
        clearEndLabels()
        
        //lets clear our variables from perhaps a previous game
        
        
        //now lets display the prompt
        prompt.text = choosePrompt()
        
        //turn the prompt into an array so we can index with integers
        promptArray = Array(prompt.text!)
        
        //change the screen color to indicate start
        self.view.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        
        //now start the timer!
        timeStart = getTimeMillis()
        
        //print(timeStart)
    }
    
    @IBAction func onEveryLetter(_ sender: Any) { //userInput gets updated with new letter -> function is called
        
        
        //if user has finished, end game
        if userInput.text == prompt.text {
            self.view.endEditing(true)
        } else {
            yourText.text = userInput.text
        }
        
        
        let inputLength = userInput.text!.count
        
//          #      UNCOMMENT FOR DEBUGGING        #
//        print(inputLength)
//        print(promptArray[inputLength-1])
//        print(promptArray[inputLength-1] == userInput.text?.last)
       
        
        
        // make sure we don't call an out of range element in prompyArray
        guard inputLength != 0  && promptArray.count >= inputLength else { return }
        //&& inputLength <= (prompt.text!.count) {
            
            // check if user has entered the right letter according to the promptArray
            if promptArray[inputLength-1] != userInput.text?.last{
                //vibrate device to indicate wrong letter typed
                UIDevice.vibrate()
                //prevent them from typing more wrong letters
                //userInput.text?.removeLast()
            }
    
    }
    
    @IBAction func onFinishedTyping(_ sender: UITextField) {
//        print("user has finished typing")
//        print(userInput.text)
//        print(getTimeMillis())
        
        //first end the timer!
        timeEnd = getTimeMillis()
        
        //change the color of the screen so user knows timer has ended
        self.view.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        
        //get users results
        timeTaken = timeEnd - timeStart
        
        highscore.toString()
        //check to see if user has set a new high score
        highscore.checkHighScore(newScore: timeTaken, newUsername: "TYH")
        highscore.toString()
        
        //display users results
        millisLabel.text = "\(String(timeTaken)) \(" Milliseconds")"
        displayEndLabels()
        yourText.text = userInput.text
        userInput.text = ""
        //-------- maybe add words per second
    }
    
    //TODO: Create button that resets screen
    
    //TODO: Add random sentence generator API
    
    //TODO: Create high score

}

