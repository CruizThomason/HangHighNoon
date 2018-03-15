//
//  WordBankController.swift
//  HangHighNoon
//
//  Created by brock tyler on 3/15/18.
//  Copyright © 2018 Cruiz. All rights reserved.
//

import Foundation


class WordBankController {
    
    static let shared = WordBankController()
    
    // Retrieve randomly selected word from WordBank
    func selectNewWord() -> String {
        
        var newWord = ""
        let randomNum = arc4random_uniform(UInt32(WordBank.wordBank.count))
        
        newWord = WordBank.wordBank[Int(randomNum)]
        
        return newWord
    }
    
    
    
}
