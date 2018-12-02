//
//  ViewController.swift
//  Flashcards
//
//  Created by Rodrigo Andrade on 10/13/18.
//  Copyright © 2018 Rodrigo Andrade. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var correctAnswer: String
    var answerB: String
    var answerC: String
}

class ViewController: UIViewController {
    
    
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!

    @IBOutlet weak var btnOptionOne: UIButton!
    
    @IBOutlet weak var btnOptionTwo: UIButton!
    
    @IBOutlet weak var btnOptionThree: UIButton!
    
    @IBOutlet weak var prevButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    // Array to hold flashcard objects
    var flashcards = [Flashcard]()
    
    var currentIndex = 0
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //We Know the destination of the segue is the Navigation Controller
        let navigationController = segue.destination as! UINavigationController
        
        //We Know the navigation controller only contains a creation view controller
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
        
        if segue.identifier == "EditSegue" {
            creationController.initialQuestion = frontLabel.text
        
            creationController.initialCorrectAnswer = backLabel.text
        
            creationController.initialCorrectAnswer = btnOptionOne.currentTitle
        
            creationController.initalAnswerB = btnOptionTwo.currentTitle
        
            creationController.initialAnswerC = btnOptionThree.currentTitle}
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        card.layer.cornerRadius = 20.0
        
        frontLabel.layer.cornerRadius=20.0
        frontLabel.clipsToBounds = true
        backLabel.layer.cornerRadius=20.0
        backLabel.clipsToBounds = true
        
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        
        btnOptionOne.layer.cornerRadius = 20.0
        btnOptionOne.layer.borderWidth = 3.0
        btnOptionOne.layer.borderColor = #colorLiteral(red: 0.4712838093, green: 0.7465088433, blue: 1, alpha: 1)
        
        btnOptionTwo.layer.cornerRadius = 20.0
        btnOptionTwo.layer.borderWidth = 3.0
        btnOptionTwo.layer.borderColor = #colorLiteral(red: 0.4712838093, green: 0.7465088433, blue: 1, alpha: 1)
        
        btnOptionThree.layer.cornerRadius = 20.0
        btnOptionThree.layer.borderWidth = 3.0
        btnOptionThree.layer.borderColor = #colorLiteral(red: 0.4712838093, green: 0.7465088433, blue: 1, alpha: 1)
        
        // Read saved flashcards
        readSavedFlashcards()
        
        // Defualt initial cards
        if flashcards.count == 0 {
            updateFlashcard(question: "What is the capital of Perú?", correctAnswer: "Lima", answerB: "Bogotá", answerC: "Rio de Janeiro", isExisting: true)
            
        }
        else{
            updateLabels()
            updateNextPrevButtons()}
        }

    
    @IBAction func didTapOnDelete(_ sender: UIButton) {
        
        // Delete confirmation
        let alert = UIAlertController(title: "Delete flaschard", message: "Are you sure you want to delete this flashcard?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in self.deleteCurrentFlashcard()}
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(deleteAction)
        
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func deleteCurrentFlashcard(){
        
        if currentIndex > 0{
            // Delete current if more than 1 card left
            flashcards.remove(at: currentIndex)
            print ("flashcard deleted")
        
            // Special Cases: Check if last card was deleted
            if currentIndex > flashcards.count - 1{
                currentIndex = flashcards.count - 1}}
        
        else if currentIndex == 0{
            
            // Add default card
            updateFlashcard(question: "What is the capital of Perú?", correctAnswer: "Lima", answerB: "Bogotá", answerC: "Rio de Janeiro", isExisting: true)
        
            // Delete previous card
            flashcards.remove(at: currentIndex - 1)
            currentIndex = flashcards.count - 1
        
            print ("We now have \(flashcards.count) flashcards")
            print("Our current index is \(currentIndex)")}
        updateNextPrevButtons()
        updateLabels()
        }
        
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if frontLabel.isHidden == true {
            frontLabel.isHidden = false }
        
    }
    
    @IBAction func didTapOnPrev(_ sender: UIButton) {
        //Increase current index
        currentIndex = currentIndex - 1
        
        //Update labels
        updateLabels()
        
        //Update buttons
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnNext(_ sender: UIButton) {
    
        //Increase current index
        currentIndex = currentIndex + 1
        
        //Update labels
        updateLabels()
        
        //Update buttons
        updateNextPrevButtons()
    }
    func updateNextPrevButtons() {
        
        // Disable next button if at end
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false}
        else{
            nextButton.isEnabled = true}
        
        // Disable prev button if at start
        if currentIndex == 0 {
            prevButton.isEnabled = false}
        else{
            prevButton.isEnabled = true}}
        
    func updateLabels() {
        
        // Get current flashcard
        let currentFlashcard = flashcards[currentIndex]
        
        //Update Labels
        
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.correctAnswer
        
        btnOptionOne.setTitle(currentFlashcard.correctAnswer, for: .normal)
        btnOptionTwo.setTitle(currentFlashcard.answerB, for: .normal)
        btnOptionThree.setTitle(currentFlashcard.answerC, for: .normal)
    }
    func updateFlashcard(question: String, correctAnswer: String, answerB: String, answerC: String, isExisting: Bool) {
        
        
        let flashcard = Flashcard(question: question, correctAnswer: correctAnswer, answerB: answerB, answerC: answerC)
        
        if isExisting {
            // Replace current flashcard
            flashcards[currentIndex] = flashcard
        }
            
        else {
            
        
            flashcards.append(flashcard)
        
            print ("Added new flashcard")
            print ("We now have \(flashcards.count) flashcards")
        
            currentIndex = flashcards.count - 1
            print("Our current index is \(currentIndex)")}
        
        // Update buttons
        updateNextPrevButtons()
        
        // Update labels
        updateLabels()
        
        // Save flashcards to disk
        saveAllFlashcardsToDisk()
    }
    
    func saveAllFlashcardsToDisk(){
        
        // Convert flashcard array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String: String] in return ["question": card.question, "correctAnswer": card.correctAnswer, "answerB":card.answerB, "answerC":card.answerC]
            
        }
        
        // Save array on disk w/ user defaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        // Logging
        print("Flashcards have been saved to User Defaults")
    }
    
    func readSavedFlashcards(){
        // Read dictionary array (if any)
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards:") as? [[String:String]]{
            
            // We now know we are dealing with previous dictionary
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, correctAnswer: dictionary["correctAnswer"]!, answerB: dictionary["answerB"]!, answerC: dictionary["answerC"]!)}
            
            // Add cards into flashcard array
            flashcards.append(contentsOf: savedCards)}
        
        }
    
    @IBAction func didTapOptionOne(_ sender: UITapGestureRecognizer) {
        frontLabel.isHidden = true}
    
    @IBAction func didTapOptionTwo(_ sender: UITapGestureRecognizer) {
        frontLabel.isHidden = false}
    
    @IBAction func didTapOptionThree(_ sender: Any) {
    frontLabel.isHidden = false}
    
}

