//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Rodrigo Andrade on 10/27/18.
//  Copyright © 2018 Rodrigo Andrade. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {
    
    var flashcardsController: ViewController!
    
    @IBOutlet weak var questionTextField: UITextField!
    
    @IBOutlet weak var correctAnswerTextField: UITextField!
    
    @IBOutlet weak var answerBTextField: UITextField!
    
    @IBOutlet weak var answerCTextField: UITextField!
    
    var initialQuestion: String? = "Question"
    var initialCorrectAnswer: String? = "Correct Answer"
    var initalAnswerB: String? = "Answer B"
    var initialAnswerC: String? = "Answer C"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionTextField.text = initialQuestion
        
        correctAnswerTextField.text = initialCorrectAnswer
        
        answerBTextField.text = initalAnswerB
        
        answerCTextField.text = initialAnswerC

        // Do any additional setup after loading the view.
    }
    

    let alert = UIAlertController(title: "Missing text you twat", message: "You need to enter both a question and an answer", preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default)
    var ok_error_flag = false
    
    @IBAction func didTapOnCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
       
        // Question Field Text
        
        let questionText = questionTextField.text
        
        // Answer Field Text
        
        let correctAnswerText = correctAnswerTextField.text
        
        let answerBText = answerBTextField.text
        
        let answerCText = answerCTextField.text
        
//        show error
        if questionText == nil || correctAnswerText == nil || answerBText == nil || answerCText == nil || questionText!.isEmpty || correctAnswerText!.isEmpty || answerBText!.isEmpty || answerCText!.isEmpty {

            if ok_error_flag == false{
                alert.addAction(okAction)
                ok_error_flag = true}
            present(alert, animated:true)
            
        }
        
        else {
            flashcardsController.updateFlashcard(question: questionText!, correctAnswer: correctAnswerText!, answerB: answerBText!, answerC: answerCText!)
        
            dismiss(animated: true)}
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
