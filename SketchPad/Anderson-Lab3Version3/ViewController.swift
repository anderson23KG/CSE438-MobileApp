//
//  ViewController.swift
//  Anderson-Lab3Version3
//
//  Created by Anderson Gonzalez on 7/4/20.
//  Copyright © 2020 Anderson Gonzalez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //var lineCanvas: LineView!
    
    @IBOutlet weak var lineCanvas: LineView!
    
    var currentLine: Line?
    
    var heighlightStatus = false
    
    var currentColor = UIColor.systemGreen
    
    @IBOutlet weak var widthSlider: UISlider!
    
    @IBOutlet weak var greenButton: UIButton!
    
    @IBOutlet weak var indigoButton: UIButton!
    
    @IBOutlet weak var orangeButton: UIButton!
    
    
    @IBOutlet weak var tealButton: UIButton!
    
    @IBOutlet weak var purpleButton: UIButton!
    
    @IBOutlet weak var blueButton: UIButton!
    
    @IBOutlet weak var redButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       //the following lines of code were taken from
       //stack overflow to create circular buttons
      // the url for the page has been copied below
    /*https://stackoverflow.com/questions/41298597/circular-gradient-buttons-in-swift */
       greenButton.layer.cornerRadius = greenButton.frame.size.width/2
       indigoButton.layer.cornerRadius = indigoButton.frame.size.width/2
        orangeButton.layer.cornerRadius = orangeButton.frame.size.width/2
        tealButton.layer.cornerRadius = tealButton.frame.size.width/2
        purpleButton.layer.cornerRadius = purpleButton.frame.width/2
        blueButton.layer.cornerRadius = blueButton.frame.width/2
        redButton.layer.cornerRadius = blueButton.frame.width/2
    }
    
    @IBAction func clearDrawing(_ sender: Any) {
        lineCanvas.theLine = nil
        lineCanvas.lines = []
    }
    
    @IBAction func undoLast(_ sender: Any) {
        if lineCanvas.theLine != nil {
            lineCanvas.theLine = nil
        }
        if !(lineCanvas.lines.isEmpty ){
            lineCanvas.lines.remove(at: lineCanvas.lines.count-1)}
        
    }
    
    @IBAction func changeWidth(_ sender: Any) {
        currentLine?.lineWidth = CGFloat((widthSlider.value) * 45)
    }
    @IBAction func greenPencil(_ sender: Any) {
        currentColor = greenButton.backgroundColor!
        heighlightStatus = false
    }
    
    @IBAction func orangePencil(_ sender: Any) {
        currentColor = orangeButton.backgroundColor!
        heighlightStatus = false
    }
    @IBAction func indigoPencil(_ sender: Any) {
        currentColor = indigoButton.backgroundColor!
        heighlightStatus = false
    }
    
    @IBAction func tealPencil(_ sender: Any) {
        currentColor = tealButton.backgroundColor!
        heighlightStatus = false
    }
    
    @IBAction func redPencil(_ sender: Any) {
       currentColor = redButton.backgroundColor!
        heighlightStatus = false
    }
    @IBAction func purplePencil(_ sender: Any) {
        currentColor = purpleButton.backgroundColor!
        heighlightStatus = false
    }
    
    @IBAction func bluePencil(_ sender: Any) {
        currentColor = blueButton.backgroundColor!
        heighlightStatus = false
    }
    
    @IBAction func highlighterMode(_ sender: Any) {
        currentColor = UIColor.yellow
        heighlightStatus = true
    }
    @IBAction func eraseMode(_ sender: Any) {
        currentColor = UIColor.systemBackground
        heighlightStatus = false
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint = touches.first?.location(in: lineCanvas) else { return }
         print("Started Touching...\(touchPoint)")
        var lineArray: [CGPoint] = []
        lineArray.append(touchPoint)
        currentLine = Line(linePoints: lineArray, lineWidth:CGFloat((widthSlider.value) * 45), lineColor: currentColor, heighlight: heighlightStatus)
        //lineCanvas.theLine = currentLine
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint = touches.first?.location(in: lineCanvas) else { return }
        print("Moving Finger...\(touchPoint)")
        currentLine?.linePoints.append(touchPoint)
        lineCanvas.theLine = currentLine
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       if let newLine = currentLine {
           lineCanvas.lines.append(newLine)
        }
    }
}

