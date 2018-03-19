//
//  ViewController.swift
//  HangHighNoon
//
//  Created by cruizthomason on 3/15/18.
//  Copyright © 2018 Cruiz. All rights reserved.
//



/*
 TODO: Upload images to Assets

 TODO: Word Formatting for Display
 A) Create formatNewWord() method - gets size and spacing; returns a new string that becomes the display string (e.g. displayString = formatNewWord(newWord)) [PLACED IN 'NEW WORD' BUTTON ACTION METHOD?]
 B) Create updateWordDisplay() method

 TODO: Create updateDisplayString method to be called when correct char selected

 TODO: Create incrementGuessCounter() method
 
*/

import UIKit

class ViewController: UIViewController {
    
    // Guessing Properties
    var wordCompleted: Bool = false
    var userWon: Bool = false
    var userLost: Bool = false
    var incorrectGuessCount: Int = 0
    var correctGuessCount: Int = 0
    let maxIncorrectGuesses = 7
    var guessedCharacters: [Character] = []
    
    // Image Properties
    let hangImages: [UIImage] = [#imageLiteral(resourceName: "Hang0"), #imageLiteral(resourceName: "Hang1"), #imageLiteral(resourceName: "Hang2"), #imageLiteral(resourceName: "Hang3"), #imageLiteral(resourceName: "Hang4"), #imageLiteral(resourceName: "Hang5"), #imageLiteral(resourceName: "Hang6")] // Add images in order of hanging sequence. Image displayed is determined by incorrectGuessCount.
    let loserImage: UIImage = #imageLiteral(resourceName: "Loser")
    let winnerImage: UIImage = #imageLiteral(resourceName: "Winner")
    
    // Word Display Properties
    let block: String = "█"
    var wordLength: Int = 0
    var newWord: String = ""
    var realWord: String = ""
    var formattedWord: String = ""
    
    // Button properties
    var buttonArray: [UIButton] = []
    
    // Outlets
    @IBOutlet weak var hangImageView: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var wordDisplayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    @IBAction func letterButtonTapped(_ sender: UIButton) {
    
        updateWordDisplayFormat(wordToFormat: formattedWord, selectedChar: Character((sender.titleLabel?.text)!))
        sender.isSelected = true
        sender.isEnabled = false
        buttonArray.append(sender)
    }
    
    @IBAction func newWordButtonTapped(_ sender: Any) {
        
        newWord = WordBankController().selectNewWord()
        realWord = ""
        formattedWord = ""
        wordCompleted = false
        userWon = false
        userLost = false
        incorrectGuessCount = 0
        correctGuessCount = 0
        guessedCharacters.removeAll()
        updateWordDisplayFormat(wordToFormat: newWord, selectedChar: "*")
        updateHangImage(incorrectGuessCount: incorrectGuessCount)
        
        for button in buttonArray {
            button.isEnabled = true
            button.isSelected = false
        }
        
    }

    func updateWordDisplayFormat(wordToFormat: String, selectedChar: Character) -> Void {
        
        realWord = wordToFormat
        
        // "*" used as selectedChar only if a brand new word was generated.
        if selectedChar != "*" {
            
            guessedCharacters.append(selectedChar)
            
            if !realWord.contains(guessedCharacters.last!) {
                self.incorrectGuessCount += 1
                if self.incorrectGuessCount == maxIncorrectGuesses {
                    updateScore(incorrectGuessCount: incorrectGuessCount)
                    updateHangImage(incorrectGuessCount: incorrectGuessCount)
                    gameLost()
                }
                updateScore(incorrectGuessCount: incorrectGuessCount)
                updateHangImage(incorrectGuessCount: incorrectGuessCount)
            } else {
            
                for char in Array(realWord) {
                    
                    // TODO: Set formattedWord char equal to realWord at indexes of guessedCharacters.last
                    var count = 0
                    if char == guessedCharacters.last {
                        let newFormattedWord = self.formattedWord.prefix(count) + "\(char)" + self.formattedWord.dropFirst(count + 1)
                        self.formattedWord = "\(newFormattedWord)"
                        count += 1
                    }
                }
            }
            
            wordDisplayLabel.text = formattedWord
            // reveal guessed characters and increment guessCounts
            
            
        } else {
            
            let endIndex = realWord.index(realWord.endIndex, offsetBy: 0)
            
            // Spacing format for brand new word

            for char in Array(realWord) {
                if realWord.index(of: char) != endIndex {
                    realWord += "\(char) "
                    realWord.removeFirst()
                    formattedWord += "\(block) "
                } else {
                    realWord += "\(char)"
                    realWord.removeFirst()
                    formattedWord += "\(block)"
                }
            }
            
            String(realWord)
            
            wordDisplayLabel.text = formattedWord
    
            print(realWord)
            print(formattedWord)
        }
        
        
    }
    
    func updateScore(incorrectGuessCount: Int) {
        scoreLabel.text = "Score: \(incorrectGuessCount) / 7"
    }
    
    func updateHangImage(incorrectGuessCount: Int) {
        let index = incorrectGuessCount
        hangImageView.image = hangImages[index]
    }
    
    func gameWon() {
        hangImageView.image = winnerImage
    }
    
    func gameLost() {
        hangImageView.image = loserImage
    }
    

}

