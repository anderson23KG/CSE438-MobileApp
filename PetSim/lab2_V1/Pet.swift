//
//  Pet.swift
//  lab2_V1
//
//  Created by Anderson Gonzalez on 6/25/20.
//  Copyright © 2020 Anderson Gonzalez. All rights reserved.
//

//import Foundation
//import AVFoundation
class Pet{
    //data
    private (set) var happiness:Int
    private (set) var foodLevel:Int
    private (set) var numTimesFed:Int
    private (set) var numTimesPlayed:Int
    private (set) var hungry:Bool
    //var song:URL?
    var name: pet?
    
    enum pet{
        case dog
        case cat
        case fish
        case bird
        case bunny
    }
    
    //behavior
    func feed(){
        if foodLevel < 10 && foodLevel >= 0{
            foodLevel += 1
            numTimesFed += 1
        }
      
    }
    func play(){
        if foodLevel > 0 {
            if happiness <= 9
            {
                happiness += 1
            }
            numTimesPlayed += 1
            foodLevel -= 1
            hungry = false
        }
        else {
            hungry = true
        }
    }
    //init
    init(name:pet){
        self.name = name
        self.foodLevel = 0
        self.happiness = 0
        self.numTimesFed = 0
        self.numTimesPlayed = 0
        self.hungry = true
    }
    
    
}
