//
//  ViewController.swift
//  Hangman
//
//  Created by Gene Yoo on 10/13/15.
//  Copyright © 2015 cs198-ios. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {

    @IBOutlet weak var guessText: UITextField!
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var startOverButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var incorrectGuesses: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var hangmanObj: Hangman = Hangman()
    var hangmanState: Int = 1
    var win: Bool = false
    
    override func viewDidLoad() {
        imageView.image = UIImage(named: "hangman1")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func newGameAction(sender: AnyObject) {
        hangmanObj = Hangman()
        hangmanState = 1
        imageView.image = UIImage(named: "hangman1")
        incorrectGuesses.text = ""
        guessButton.resignFirstResponder()
        guessText.text = ""
        hangmanObj.start()
    }
    
    @IBAction func guessAction(sender: AnyObject) {
        if (hangmanState == 7 || win) {
            guessText.resignFirstResponder()
            guessText.text = ""
            return
        }
        
        hangmanObj.start()
        let guessMade = hangmanObj.guessLetter(guessText.text!)
        incorrectGuesses.text = hangmanObj.guesses()
        guessText.resignFirstResponder()
        guessText.text = ""
        if (!guessMade) {
            hangmanState += 1
            imageView.image = UIImage(named: "hangman" + String(hangmanState))
            
            if (hangmanState == 7) {
                let lostAlert = UIAlertController(title: "You Lost!", message: "T_T", preferredStyle: UIAlertControllerStyle.Alert)
                let tryAgain = UIAlertAction(title: "Try Again", style: UIAlertActionStyle.Cancel, handler: nil)
                lostAlert.addAction(tryAgain)
                presentViewController(lostAlert, animated: true, completion: nil)
                win = true
            }
        }
    }
    
}

