//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Dishit Kotecha on 6/4/20.
//  Copyright © 2020 Dishit Kotecha. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    @IBOutlet weak var outputLabel: UILabel!
    var btnSound: AVAudioPlayer!
    
    enum Operation: String{
        case Add = "+"
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Empty = "Empty"
        case Clear = "Clear"
        
    }
    var currentOperation = Operation.Empty
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    @IBAction func numberPressed(sender: UIButton){
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
    @IBAction func onAddPressed(sender: AnyObject){
        processOperation(operation: .Add)
    }
    @IBAction func onSubtractPressed(sender: AnyObject){
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject){
        processOperation(operation: currentOperation)
    }
    
    @IBAction func onClearPressed(sender: AnyObject){
        playSound()
        outputLabel.text = "0"
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        result = ""
        currentOperation = Operation.Empty
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
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                }else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }
                leftValStr = result
                outputLabel.text = result
            }
            currentOperation = operation
        } else {
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }


}

