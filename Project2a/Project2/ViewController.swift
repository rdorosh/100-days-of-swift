//
//  ViewController.swift
//  Project2
//
//  Created by Ruslan Dorosh on 05.05.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questions = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 12
        button2.layer.borderWidth = 12
        button3.layer.borderWidth = 12
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(scoreShow))


    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
        
        title = countries[correctAnswer].uppercased() + " Score: \(score)"
    }
    
    
    @IBAction func buttonTouched(_ sender: UIButton) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 5, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        })
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 5, options: [], animations: {
            sender.transform = .identity
        })
            
        var title: String
        
        questions += 1
        
        if sender.tag == correctAnswer{
            title = "Correct!"
            score += 1
            if questions == 10 {
                title = "Congratulations! It was the last question."
            }
        } else {
            title = "Wrong! That’s the flag of \(countries[sender.tag].uppercased())."
            score -= 1
            if questions == 10 {
                title = "Congratulations! It was the last question."
            }
        }

        let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
        if questions >= 10 {
            ac.addAction(UIAlertAction(title: "Try again", style: .default, handler: askQuestion))
            
            score = 0
            correctAnswer = 0
            questions = 0

        } else {
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        }
        present(ac, animated: true)
    }
    
    @objc func scoreShow() {
        let scoreAlert = UIAlertController(title: "SCORE", message: nil, preferredStyle: .actionSheet)
        scoreAlert.addAction(UIAlertAction(title: "Your current score is \(score).", style: .default, handler: nil))
        present(scoreAlert, animated: true)
    }
    
}

