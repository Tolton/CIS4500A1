//
//  ViewController.swift
//  Swift4500
//
//  Created by Jack on 2018-01-18.
//  Copyright © 2018 Jack. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textFieldOne: UITextField!
    @IBOutlet weak var textViewOne: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func calcButton(_ sender: Any) {
        let newStr = textFieldOne.text!
        let wordArr = countWords(newStr + "\n")
        let syllableCount = calcSyllables(wordArr)
        let sentenceCount = calcSentences(newStr + "\n")
        let indexCount    = calcIndex(syllableCount, wordArr.count, sentenceCount)
        
        textViewOne.text = "Index\t\t=" + String(indexCount)
        textViewOne.text = textViewOne.text + "\nSyllable Count\t= " + String(syllableCount)
        textViewOne.text = textViewOne.text + "\nWord count\t\t= " + String(wordArr.count)
        textViewOne.text = textViewOne.text + "\nSentence count\t= " + String(sentenceCount)
    }
    
    func countWords(_ allWords:String) -> Array<String>{
        var wordArray: [String] = []
        var word = String("")
        
        for letter in allWords {
            if letter == " " || letter == "\n" {
                if !word.isEmpty {
                    wordArray.append(word)
                    word = ""
                }
            } else {
                word += String(letter)
            }
        }
        return wordArray
    }
    
    func calcSyllables(_ words:Array<String>) -> Int {
        var vowel = String("")
        var syllables = 0
        var hadVowel = 0
        var newWord = String("")
        
        for word in words {
            if word.last == "e" && word.count > 1 {
                newWord = String(word.dropLast())
            } else {
                newWord = word
            }
            for c in newWord {
                
                if c == "a"  || c == "e" || c == "i" || c == "o" || c == "u" || c == "y" {
                    if !vowel.isEmpty {
                        vowel = ""
                    } else {
                        vowel = String(c)
                        syllables += 1
                    }
                    hadVowel += 1
                } else {
                    vowel = ""
                }
            }
            vowel = ""
            if hadVowel == 0 {
                syllables += 1
            }
            hadVowel = 0
        }
        return syllables
        
    }
    
    func calcSentences(_ strInput:String) -> Int {
        var sentences = 0
        var moreMarks = 0
        //. : ; ? !
        for c in strInput {
            //Assumes finding a newline is the end of a sentence eg "Hey! How are you" would be 2 sentences
            if c == "?" || c == "!" || c == ";" || c == ":" || c == "." || c == "\n" {
                if moreMarks == 0 {
                    moreMarks = 1
                    sentences += 1
                }
            } else {
                moreMarks = 0
            }
        }
        return sentences
    }
    
    func calcIndex(_ syllables:Int, _ words:Int, _ sentences:Int) -> Double {
        let sylPerWord = Double(syllables) / Double(words)
        let wordPerSentence = Double(words) / Double(sentences)

        let indexCalc = 206.835 - 84.6 * sylPerWord - 1.015 * wordPerSentence
        
        return indexCalc
    }
}

