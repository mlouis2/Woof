//
//  MainViewController.swift
//  Woof2
//
//  Created by Maddie Louis on 4/6/19.
//  Copyright © 2019 Maddie Louis. All rights reserved.
//

import UIKit
import SwiftGifOrigin

extension UIImage {
    public class func gif(asset: String) -> UIImage? {
        if let asset = NSDataAsset(name: asset) {
            return UIImage.gif(data: asset.data)
        }
        return nil
    }
}

class Dog {
    
    private var food: Int
    private var water: Int
    private var isHappy: Bool
    
    init(food: Int, water: Int, isHappy: Bool) {
        self.food = food
        self.water = water
        self.isHappy = isHappy
    }
    
    @objc func hydrate(_ sender: UIButton, waterBowlLevel: Int) -> Int {
        if (waterBowlLevel < 3) {
            fillWaterBowl(sender, waterBowlLevel: waterBowlLevel)
            return waterBowlLevel + 1
        }
        return waterBowlLevel
    }
    
    @objc func feed(_ sender: UIButton, foodBowlLevel: Int) -> Int {
        if (foodBowlLevel < 3) {
            fillFoodBowl(sender, foodBowlLevel: foodBowlLevel)
            return foodBowlLevel + 1
        }
        return foodBowlLevel
    }
    
    func getFood() -> Int {
        return self.food
    }
    
    func getWater() -> Int {
       return self.water
    }
    
    func getIsHappy() -> Bool {
        return self.isHappy
    }
    
    func decrementFood(sender: UIButton) {
        if (self.food > 0) {
            self.food -= 10
        }
    }
    func decrementWater(sender: UIButton) {
        if (self.water > 0) {
            self.water -= 10
        }
    }
    func decrementWaterBowl(_ sender: UIButton, waterBowlLevel: Int) {
        if (waterBowlLevel == 3) {
            sender.setImage(UIImage(named: "mediumWaterBowl"), for: UIControl.State.normal)
        } else if (waterBowlLevel == 2) {
            sender.setImage(UIImage(named: "smallWaterBowl"), for: UIControl.State.normal)
        } else if (waterBowlLevel == 1) {
          sender.setImage(UIImage(named: "emptyWaterBowl"), for: UIControl.State.normal)
        }
    }
    func decrementFoodBowl(_ sender: UIButton, foodBowlLevel: Int) {
        if (foodBowlLevel == 3) {
            sender.setImage(UIImage(named: "mediumFoodBowl"), for: UIControl.State.normal)
        } else if (foodBowlLevel == 2) {
            sender.setImage(UIImage(named: "smallFoodBowl"), for: UIControl.State.normal)
        } else if (foodBowlLevel == 1) {
          sender.setImage(UIImage(named: "emptyFoodBowl"), for: UIControl.State.normal)
        }
    }
    func fillWaterBowl(_ sender: UIButton, waterBowlLevel: Int) {
        if (self.water < 100) {
            self.water += 10
        }
        if (waterBowlLevel == 2) {
            sender.setImage(UIImage(named: "fullWaterBowl"), for: UIControl.State.normal)
        } else if (waterBowlLevel == 1) {
            sender.setImage(UIImage(named: "mediumWaterBowl"), for: UIControl.State.normal)
        } else if (waterBowlLevel == 0) {
            sender.setImage(UIImage(named: "smallWaterBowl"), for: UIControl.State.normal)
        }
    }
    func fillFoodBowl(_ sender: UIButton, foodBowlLevel: Int) {
        if (self.food < 100) {
            self.food += 10
        }
        if (foodBowlLevel == 2) {
            sender.setImage(UIImage(named: "FullFoodBowl"), for: UIControl.State.normal)
        } else if (foodBowlLevel == 1) {
            sender.setImage(UIImage(named: "mediumFoodBowl"), for: UIControl.State.normal)
        } else if (foodBowlLevel == 0) {
            sender.setImage(UIImage(named: "smallFoodBowl"), for: UIControl.State.normal)
        }
    }
    func makeSad(sender: UIImageView) {
        sender.image = UIImage(named: "saddog")
        self.isHappy = false
    }
    func makeHappy(sender: UIImageView) {
        sender.image = UIImage.gif(asset: "happyDog")
        self.isHappy = true
    }
    
}

class MainViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var foodBowlButton: UIButton!
    @IBOutlet weak var waterBowlButton: UIButton!
    @IBOutlet weak var dogImage: UIImageView!
    @IBOutlet weak var dogNameField: UITextField!
    @IBOutlet weak var foodBar: UIProgressView!
    @IBOutlet weak var waterBar: UIProgressView!
    
    
    var waterBowlLevel = 0
    var foodBowlLevel = 0
    var timer: Timer?
    
    let dog = Dog(food: 70, water: 70, isHappy: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dog.makeHappy(sender: dogImage)
        assignBackground()
        foodBar.progress = Float((Double(dog.getFood()) / 100.0))
        waterBar.progress = Float((Double(dog.getWater()) / 100.0))
        startTimer()
        dogNameField.delegate = self
    }
    
    @IBAction func openHealthMenu(_ sender: Any) {
        let healthMenu = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HealthMenuViewController") as! HealthMenuViewController
        self.addChild(healthMenu)
        healthMenu.view.frame = self.view.frame
        self.view.addSubview(healthMenu.view)
        healthMenu.didMove(toParent: self)
    }
    
    
    //Thanks StackOverFlow!
    func assignBackground() {
        let background = UIImage(named: "background")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }

    @IBAction func endOnDone(_ sender: Any) {
        dogNameField.resignFirstResponder()
    }
    
    @objc func updateStatus() {
        updateBowls()
        updateHappiness()
    }
    
    @objc func updateBowls() {
        if (foodBowlLevel > 0) {
            dog.decrementFoodBowl(foodBowlButton, foodBowlLevel: foodBowlLevel)
            foodBowlLevel -= 1
        } else {
            dog.decrementFood(sender: foodBowlButton)
        }
        
        if (waterBowlLevel > 0) {
            dog.decrementWaterBowl(waterBowlButton, waterBowlLevel: waterBowlLevel)
            waterBowlLevel -= 1
        } else {
            dog.decrementWater(sender: waterBowlButton)
        }
        foodBar.progress = Float(Double(dog.getFood()) / 100.0)
        waterBar.progress = Float(Double(dog.getWater()) / 100.0)
    }
    
    @objc func updateHappiness() {
        if ((dog.getFood() < 50 || dog.getWater() < 50) && dog.getIsHappy()) {
            dog.makeSad(sender: dogImage)
        }
        
        if ((dog.getFood() >= 50 && dog.getWater() >= 50) && !dog.getIsHappy()) {
            dog.makeHappy(sender: dogImage)
        }
    }
    
    func resetTimer() {
        timer?.invalidate()
        startTimer()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(updateStatus), userInfo: nil, repeats: true);
    }
    
    @IBAction func hydrateCurrentDog(_ sender: Any) {
        if (waterBowlLevel == 0) {
            resetTimer()
        }
        waterBowlLevel = dog.hydrate(waterBowlButton, waterBowlLevel: waterBowlLevel)
        updateHappiness()
        waterBar.progress = Float(Double(dog.getWater()) / 100.0)
    }
    @IBAction func feedCurrentDog(_ sender: Any) {
        if (foodBowlLevel == 0) {
            resetTimer()
        }
        foodBowlLevel = dog.feed(foodBowlButton, foodBowlLevel: foodBowlLevel)
        updateHappiness()
        foodBar.progress = Float(Double(dog.getFood()) / 100.0)
    }
    
}
