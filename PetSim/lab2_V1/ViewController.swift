//
//  ViewController.swift
//  lab2_V1
//
//  Created by Anderson Gonzalez on 6/24/20.
//  Copyright © 2020 Anderson Gonzalez. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player: AVAudioPlayer?
    
    var sound: String?
    
    var petDog = Pet(name: .dog)
    
    var petBird = Pet(name: .bird)
    
    var petCat = Pet(name: .cat)
    
    var petFish = Pet(name: .fish)
    
    var petBunny = Pet(name: .bunny)
    
    var currentPet: Pet?
    
    var petCollection = [Pet?]()
    
    //var urlString : fileURLWithPath?
    
    var songURL: URL?
    
    @IBOutlet weak var petImage: UIImageView!
    
    
    @IBOutlet weak var playLabel: UILabel!
    
    @IBOutlet weak var happinessBar: DisplayView!
    
    @IBOutlet weak var foodBar: DisplayView!
    
    @IBOutlet weak var foodLabel: UILabel!
    
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        petDog = Pet(name: .dog)
           
        petBird = Pet(name:.bird)
           
        petCat = Pet(name: .cat)
           
        petFish = Pet(name: .fish)
           
        petBunny = Pet(name: .bunny)
        
        petCollection.append(petDog)
        petCollection.append(petCat)
        petCollection.append(petBird)
        petCollection.append(petBunny)
        petCollection.append(petFish)
        currentPet = petCollection[0]
        happinessBar.color = UIColor.systemRed
        foodBar.color = UIColor.systemRed
        backgroundView.backgroundColor = UIColor.systemRed
        songURL = URL(fileURLWithPath:Bundle.main.path(forResource: "dogBarking", ofType: "m4a")!)
    }

    @IBAction func playedPress(_ sender: Any) {
        currentPet?.play()
        updatePlayDisplay()
        let foodNum = Double((currentPet?.foodLevel)!)/10
        foodBar.animateValue(to: CGFloat(foodNum))
        playMusic()
       
    }
    
    @IBAction func feedPress(_ sender: Any) {
        currentPet?.feed()
        updateFoodDisplay()
    }
    
    @IBAction func dogButton(_ sender: Any) {
        if currentPet?.name != .dog {
        changePet(newPet: petCollection[0], PetImage: "dog", color: UIColor.systemRed)
        updatePlayDisplay()
        updateFoodDisplay()
        songURL = URL(fileURLWithPath:Bundle.main.path(forResource: "dogBarking", ofType: "m4a")!)
        }
    }
    
    @IBAction func catButton(_ sender: Any) {
        if currentPet?.name != .cat {
        changePet(newPet: petCollection[1], PetImage: "cat", color: UIColor.systemBlue)
        updatePlayDisplay()
        updateFoodDisplay()
        songURL = URL(fileURLWithPath:Bundle.main.path(forResource: "catSound2", ofType: "m4a")!)
        }
    }
    
    @IBAction func birdButton(_ sender: Any) {
        if currentPet?.name != .bird {
            changePet(newPet: petCollection[2], PetImage: "bird", color: UIColor.systemYellow)
        updatePlayDisplay()
        updateFoodDisplay()
        songURL = URL(fileURLWithPath:Bundle.main.path(forResource: "birdSound", ofType: "m4a")!)
        }
    }
    
    @IBAction func fishButton(_ sender: Any) {
        if currentPet?.name != .fish {
            changePet(newPet: petCollection[4], PetImage: "fish", color: UIColor.systemPurple)
        updatePlayDisplay()
        updateFoodDisplay()
        songURL = URL(fileURLWithPath:Bundle.main.path(forResource: "fishSound", ofType: "m4a")!)
        }
    }
    
    
    @IBAction func bunnyButton(_ sender: Any) {
        if currentPet?.name != .bunny {
            changePet(newPet: petCollection[3], PetImage: "bunny", color: UIColor.systemOrange)
        updatePlayDisplay()
        updateFoodDisplay()
        songURL = URL(fileURLWithPath:Bundle.main.path(forResource: "bunnySound", ofType: "m4a")!)
        }
    }
    
    
    func updatePlayDisplay(){
        playLabel.text = "played: \(String((currentPet?.numTimesPlayed)!))"
        playLabel.textColor = UIColor.systemGray2
        let happyNum = Double((currentPet?.happiness)!)/10
         happinessBar.animateValue(to:CGFloat(happyNum))
    }
    
    func updateFoodDisplay(){
        foodLabel.text = "fed: \(String((currentPet?.numTimesFed)!))"
        foodLabel.textColor = UIColor.systemGray2
        let foodNum = Double((currentPet?.foodLevel)!)/10
        foodBar.animateValue(to: CGFloat(foodNum))
    }
    
    func changePet(newPet:Pet?, PetImage:String,color:UIColor?)
    {
        currentPet = newPet
        petImage.image =  UIImage(named: PetImage)
        backgroundView.backgroundColor = color
        foodBar.color = color!
        happinessBar.color = color!
    }
    
    //the following code was obtained from various online tutorials
    //but the code follows the instructions provide by the iOSAcademy
    //the url link for the video has been provide below:
    //https://www.youtube.com/watch?v=2kflmGGMBOA
    
    func playMusic(){
        if (currentPet?.hungry)! == true{
        //set up player and play
            do {
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options:.notifyOthersOnDeactivation)
                player = try AVAudioPlayer(contentsOf:songURL!)
                guard let player = player else {
                    return
                }
                player.play()
            } catch  {
                print("something went wrong")
            }
        }
        else if (currentPet?.hungry)! != true
        {
            if let player = player, player.isPlaying{
                player.stop()
            }
        }
        
    }
    
}

