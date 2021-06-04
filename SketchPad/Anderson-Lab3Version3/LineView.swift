//
//  LineView.swift
//  Anderson-Lab3Version1
//
//  Created by Anderson Gonzalez on 7/3/20.
//  Copyright © 2020 Anderson Gonzalez. All rights reserved.
//

import UIKit

class LineView: UIView {

   
    var theLine: Line?{
        didSet {
            setNeedsDisplay()
        }
    }
    
    var lines: [Line] = [] {
        didSet{
            setNeedsDisplay()
        }
    }
    
    private func midpoint(first: CGPoint, second: CGPoint) -> CGPoint { // implement this function here
        let x_value : CGFloat = (first.x + second.x) / 2
        let y_value : CGFloat = (first.y + second.y) / 2
        let point = CGPoint(x: x_value, y: y_value)
        return point
    }
    
    private func createQuadPath(points: [CGPoint]) -> UIBezierPath {
    let path = UIBezierPath() //Create the path object
    if(points.count < 2){ //There are no points to add to this pat
        return path }
    path.move(to: points[0]) //Start the path on the first point
        for i in 1..<points.count - 1{
    let firstMidpoint = midpoint(first: path.currentPoint, second: points[i]) //Get midpoint between the path's last point and the next one in the array
    let secondMidpoint = midpoint(first: points[i], second:
    points[i+1]) //Get midpoint between the next point in the array and the one
       //after it
    path.addCurve(to: secondMidpoint, controlPoint1: firstMidpoint, controlPoint2: points[i]) //This creates a cubic Bezier curve using math!
    }
    return path }

    func drawLine(_ line: Line)
    {
        line.lineColor.set()
        if line.heighlight == true{
            if(line.linePoints.count < 2)
            {
                let path = UIBezierPath()
                path.addArc(withCenter: line.linePoints[0], radius: line.lineWidth, startAngle:0.0, endAngle: 360, clockwise: true)
                path.lineCapStyle = .round
                path.fill(with: .normal, alpha: 0.4)
            }
            else {
                let path = createQuadPath(points:line.linePoints)
                path.lineWidth = line.lineWidth * 2
                path.lineCapStyle = .round
                path.stroke(with: .normal, alpha: 0.4)
            }
        }
        else {
            if(line.linePoints.count < 2)
            {
                let path = UIBezierPath()
                path.addArc(withCenter: line.linePoints[0], radius: line.lineWidth/2, startAngle:0.0, endAngle: 360, clockwise: true)
                path.lineCapStyle = .round
                path.fill()
            }
            else{
                let path = createQuadPath(points:line.linePoints)
                    path.lineWidth = line.lineWidth
                    path.lineCapStyle = .round
                    path.stroke()
            }
        }
        
    }
    /*
    override init(frame: CGRect){
        super.init(frame:frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    */
    override func draw(_ rect: CGRect) {
        // Drawing code
        for line in lines {
            self.drawLine(line)
        }
        if (theLine != nil){
            self.drawLine(theLine!)
        }
    }
    

}
