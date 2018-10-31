//
//  ViewController.swift
//  Flashcards
//
//  Created by Rodrigo Andrade on 10/13/18.
//  Copyright © 2018 Rodrigo Andrade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!

    @IBOutlet weak var btnOptionOne: UIButton!
    
    @IBOutlet weak var btnOptionTwo: UIButton!
    
    @IBOutlet weak var btnOptionThree: UIButton!
    
    
    
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
        
        
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if frontLabel.isHidden == true {
            frontLabel.isHidden = false }
        
    }
    
    func updateFlashcard(question: String, correctAnswer: String, answerB: String, answerC: String) {
        frontLabel.text = question
        backLabel.text = correctAnswer
        btnOptionOne.setTitle(correctAnswer, for: .normal)
        btnOptionTwo.setTitle(answerB, for: .normal)
        btnOptionThree.setTitle(answerC, for: .normal)
    }
    
    @IBAction func didTapOptionOne(_ sender: UITapGestureRecognizer) {
        frontLabel.isHidden = true}
    
    @IBAction func didTapOptionTwo(_ sender: UITapGestureRecognizer) {
        frontLabel.isHidden = false}
    
    @IBAction func didTapOptionThree(_ sender: Any) {
    frontLabel.isHidden = false}
    
}

