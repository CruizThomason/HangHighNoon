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
    let hangImages: [UIImage] = [] // Add images in order of hanging sequence. Image displayed is determined by incorrectGuessCount.
    let loserImage: UIImage = #imageLiteral(resourceName: <#T##String#>)
    let winnerImage: UIImage = #imageLiteral(resourceName: <#T##String#>)
    
    // Word Display Properties
    let block: String = "█"
    var wordLength: Int = 0
    var newWord: String = ""
    var realWord: String = ""
    var formattedWord: String = ""
    
    // Outlets
    @IBOutlet weak var hangImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    @IBAction func newWordButtonTapped(_ sender: Any) {
        
        newWord = WordBankController().selectNewWord()
        realWord = ""
        wordCompleted = false
        userWon = false
        userLost = false
        incorrectGuessCount = 0
        correctGuessCount = 0
        guessedCharacters.removeAll()
        updateWordDisplayFormat(wordToFormat: newWord, selectedChar: "*")
        updateHangImage(incorrectGuessCount: incorrectGuessCount)
    }

    func updateWordDisplayFormat(wordToFormat: String, selectedChar: Character) -> Void {
        
        realWord = wordToFormat
        
        if selectedChar != "*" {
            
            guessedCharacters.append(selectedChar)
            
            if !realWord.contains(guessedCharacters.last!) {
                self.incorrectGuessCount += 1
                guard self.incorrectGuessCount != maxIncorrectGuesses else { gameLost() }
            } else {
                for (index, char) in realWord.enumerated() {
                    if char == guessedCharacters.last {
                        
                    }
                }
            }
            // reveal guessed characters and increment guessCounts
            
            
        } else {
            
            // Spacing format for brand new word
            for char in wordToFormat {
                if char != wordToFormat.last {
                    realWord += "\(char) "
                    formattedWord += "\(block) "
                } else {
                    realWord += "\(char)"
                    formattedWord += "\(block)"
                }
            }
        }
        
        
    }
    
    
    
    func updateHangImage(incorrectGuessCount: Int) {
        let index = incorrectGuessCount
        hangImageView.image = hangImages[index]
    }
    
    func gameWon() {
        
    }
    
    func gameLost() {
        
    }
    

}

