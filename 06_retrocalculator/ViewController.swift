//
//  ViewController.swift
//  06_retrocalculator
//
//  Created by David Raygoza on 01/08/17.
//  Copyright © 2017 David Raygoza. All rights reserved.
//
/*David Raygoza
 david.raygoza.ramirez@gmail.com
 https://www.linkedin.com/in/davidraygoza/
 Optionals exercise
 */

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLabel: UILabel!
    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    var currentOperation = Operation.Empty
    var leftValue = ""
    var rightValue = ""
    var result = ""
    enum Operation: String{
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = Bundle.main.path(forResource:"btn",ofType:"wav")
        let soundURL = URL(fileURLWithPath: path!)
        do{
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError{
            print(err.debugDescription)
        }
        outputLabel.text="0"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        runningNumber += "\(sender.tag)"
        outputLabel.text = runningNumber
    }
    @IBAction func onDividePressed(sender: AnyObject){
         processOperation(operation: .Divide)
    }
    @IBAction func onMultiplyPressed(sender: AnyObject){
        processOperation(operation: .Multiply)
    }
    @IBAction func onSubtractPressed(sender: AnyObject){
        processOperation(operation: .Subtract)
    }
    @IBAction func onAddPressed(sender: AnyObject){
        processOperation(operation: .Add)
    }
    @IBAction func onEqualPressed(sender: AnyObject){
        processOperation(operation: currentOperation)
    }
    @IBAction func onClearPressed(sender: AnyObject){
        playSound()
        currentOperation = Operation.Empty
        leftValue = ""
        rightValue = ""
        outputLabel.text="0"
    }
    func playSound(){
        if btnSound.isPlaying{
            btnSound.stop()
        }
        btnSound.play()
    }
    func processOperation(operation: Operation){
        playSound()
        if currentOperation != Operation.Empty {
            if runningNumber != ""{
                rightValue = runningNumber
                runningNumber = ""
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValue)! * Double(rightValue)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValue)! / Double(rightValue)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValue)! - Double(rightValue)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValue)! + Double(rightValue)!)"
                }
                leftValue = result
                outputLabel.text = result
            }
            currentOperation = operation
        }else{
            //first time in operation 
            leftValue = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }


}

