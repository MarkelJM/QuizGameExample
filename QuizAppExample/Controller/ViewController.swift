//
//  ViewController.swift
//  QuizAppExample
//
//  Created by Markel Juaristi on 8/1/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var progressQuiz: UIProgressView!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var textQuestion: UILabel!
    @IBOutlet weak var imageQuestion: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var brainQuiz = QuizBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressQuiz.progress = brainQuiz.getProgess()
        
        imageQuestion.image = brainQuiz.getImage()
        imageQuestion.layer.cornerRadius = 25
        imageQuestion.layer.masksToBounds = true /* si ponemos la curbatura de las esquinas es obligatorioa activar la máscara,sino no funciona*/
        
        textQuestion.text = brainQuiz.getTextQuestion()
        textQuestion.textColor = brainQuiz.getColor()
        
        scoreLabel.text = "Score: \(brainQuiz.getScore()) points "
    }

    @IBAction func usersAnswerButtonTap(_ sender: UIButton) {
        let usersAnswer = sender.titleLabel?.text ?? "TRUE"
        
        let rightAnswer = brainQuiz.checkAnswer(userAnswer: usersAnswer)
        
        if rightAnswer {
            sender.backgroundColor = UIColor.green
            /*para indicar que la respuesta es correcta*/
        } else {
            sender.backgroundColor = UIColor.red
            
            //para hacer que vibre
            /*let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()*/
        }
        //para que no puedan volver a responder-->se bloquea
        falseButton.isEnabled = false
        trueButton.isEnabled = false
        
        if brainQuiz.nextQuestion() {
            let alert = UIAlertController(title: "END OF QUIZ", message: "DO YOU WANT TO TRY AGAIN?", preferredStyle: .alert)
            
            let yesAction = UIAlertAction(title: "Yes", style: .default){ _ in
                self.brainQuiz.score = 0
                Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.changeQuestion), userInfo: nil, repeats: false)
                
            }
            
            let noAction = UIAlertAction(title: "No", style: .cancel) { _ in
                exit(0)
            }
            alert.addAction(yesAction)
            alert.addAction(noAction)
            present(alert, animated:  true)

        } else {
            Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(changeQuestion), userInfo: nil, repeats: false)
        }
    }
    
    @objc func changeQuestion() {
        textQuestion.text = brainQuiz.getTextQuestion()
        textQuestion.textColor = brainQuiz.getColor()
        
        imageQuestion.image = brainQuiz.getImage()
        
        progressQuiz.progress = brainQuiz.getProgess()
        
        scoreLabel.text = "Score: \(brainQuiz.getScore()) points"
        
        trueButton.backgroundColor = UIColor.white
        falseButton.backgroundColor = UIColor.white
        
        
        falseButton.isEnabled = true
        trueButton.isEnabled = true
        
    }
}

