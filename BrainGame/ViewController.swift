//
//  ViewController.swift
//  BrainGame
//
//  Created by Francis Tsang on 2/18/22.
//

import Foundation
import UIKit



class ViewController: UIViewController {
    var timer = Timer()
    var timeLeft = 59
    var isPaused = false
    var score = 0
    
    let colorMeaning = ["red", "orange", "yellow", "blue", "purple"]
    
    let colors: [String:UIColor] = [
        "red": UIColor.red,
        "orange": UIColor.orange,
        "yellow": UIColor.yellow,
        "blue": UIColor.blue,
        "purple": UIColor.purple
    ]
    
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var meaning: UILabel!
    @IBOutlet weak var textColor: UILabel!
    @IBOutlet weak var countdown: UILabel!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func restart(_ sender: UIButton) {
        // reset score back to 0
        score = 0
        points.text = String(score)
        
        // change labels
        changeColorMeaning()
        changeTextColor()
        
        // restart timer
        isPaused = true
        timer.invalidate()
        timeLeft = 59
        
        // start game button reappears
        startButton.isHidden = false
    }
    

    @IBAction func noButtonPressed(_ sender: UIButton) {
        updateScore(tappedYes: false)
        changeColorMeaning()
        changeTextColor()
    }
    
    @IBAction func yesButtonPressed(_ sender: UIButton) {
        updateScore(tappedYes: true)
        changeColorMeaning()
        changeTextColor()
    }
    
    @IBAction func startTimer(_ sender: UIButton) {
        sender.isHidden = true
        
        changeColorMeaning();
        changeTextColor();
        runTimer();
    }
    func runTimer(){
        isPaused = false
        
        timer = Foundation.Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        if timeLeft >= 0 {
            let minutes = String(timeLeft / 60)
            let seconds = String(timeLeft % 60)
            countdown.text = minutes + ":" + seconds
            timeLeft -= 1
        }
    }
    
    func changeColorMeaning() {
        let randomIndex = Int.random(in: 0 ..< colorMeaning.count)
        meaning.text = colorMeaning[randomIndex]
        addColortoText()
    }
    
    func changeTextColor() {
        let randomIndex = Int.random(in: 0 ..< colorMeaning.count)
        textColor.text = colorMeaning[randomIndex]
    }
    
    func addColortoText() {
        self.meaning.textColor = colors.randomElement()?.value
        self.textColor.textColor = colors.randomElement()?.value
    }
    
    func updateScore(tappedYes: Bool) {
        
        if textColor.textColor == colors[meaning.text!] {
            print("yay -- match")
            if tappedYes{
                score += 10
            }else{
                score -= 10
            }
            points.text = String(score)
        } else {
            print("boo -- no match")
            if tappedYes{
                score -= 10
            }else{
                score += 10
            }
            points.text = String(score)
        }
    }
    
}

