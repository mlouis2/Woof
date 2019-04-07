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
    
    init(food: Int, water: Int) {
        self.food = food
        self.water = water
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
    
    func decrementFood(sender: UIButton, amount: Int) {
        if (self.food - amount < 0) {
            self.food = 0
        } else {
            self.food -= amount
        }
    }
    func decrementWater(sender: UIButton, amount: Int) {
        if (self.water - amount < 0) {
            self.water = 0
        } else {
            self.water -= amount
        }
    }
    func emptyWaterBowl(_ sender: UIButton, waterBowlLevel: Int) {
        if (waterBowlLevel != 0) {
          sender.setImage(UIImage(named: "emptyWaterBowl"), for: UIControl.State.normal)
        }
    }
    func emptyFoodBowl(_ sender: UIButton, foodBowlLevel: Int) {
        if (foodBowlLevel != 0) {
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
        sender.image = UIImage.gif(asset: "sadDog")
    }
    func makeMegaSad(sender: UIImageView) {
        sender.image = UIImage.gif(asset: "extraSadDog")
    }
    func makeHappy(sender: UIImageView) {
        sender.image = UIImage.gif(asset: "happyDog")
    }
    
}

class MainViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var foodBowlButton: UIButton!
    @IBOutlet weak var waterBowlButton: UIButton!
    @IBOutlet weak var nextDayButton: UIButton!
    @IBOutlet weak var dogImage: UIImageView!
    @IBOutlet weak var dogNameField: UITextField!
    @IBOutlet weak var foodBar: UIProgressView!
    @IBOutlet weak var waterBar: UIProgressView!
    
    
    var waterBowlLevel = 0
    var foodBowlLevel = 0
    var dayCount = 0
    
    let dog = Dog(food: 70, water: 70)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dog.makeHappy(sender: dogImage)
        assignBackground()
        foodBar.progress = Float((Double(dog.getFood()) / 100.0))
        waterBar.progress = Float((Double(dog.getWater()) / 100.0))
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
    
    
    @IBAction func incrementDay(_ sender: Any) {
        dayCount += 1
        if (foodBowlLevel < 3) {
            if (foodBowlLevel == 0) {
                foodBar.progress -= 0.5
                dog.decrementFood(sender: foodBowlButton, amount: 50)
            } else if (foodBowlLevel == 1) {
                foodBar.progress -= 0.4
                dog.decrementFood(sender: foodBowlButton, amount: 40)
            } else {
                foodBar.progress -= 0.2
                dog.decrementFood(sender: foodBowlButton, amount: 20)
            }
        }
        if (waterBowlLevel < 3) {
            if (waterBowlLevel == 0) {
                waterBar.progress -= 0.5
                dog.decrementWater(sender: waterBowlButton, amount: 50)
            } else if (waterBowlLevel == 1) {
                waterBar.progress -= 0.4
                dog.decrementWater(sender: waterBowlButton, amount: 40)
            } else {
                waterBar.progress -= 0.2
                dog.decrementWater(sender: waterBowlButton, amount: 20)
            }
        }
        dog.emptyFoodBowl(foodBowlButton, foodBowlLevel: foodBowlLevel)
        dog.emptyWaterBowl(waterBowlButton, waterBowlLevel: waterBowlLevel)
        foodBowlLevel = 0
        waterBowlLevel = 0
        updateStatus()
    }
    
    @objc func updateStatus() {
        let smallerOfFoodAndWater = min(dog.getWater(), dog.getFood())
        if ((0 <= smallerOfFoodAndWater) && smallerOfFoodAndWater <= 30) {
            dog.makeMegaSad(sender: dogImage)
        } else if ((31 <= smallerOfFoodAndWater) && smallerOfFoodAndWater < 70) {
            dog.makeSad(sender: dogImage)
        } else {
            dog.makeHappy(sender: dogImage)
        }
    }
    
    @IBAction func hydrateCurrentDog(_ sender: Any) {
        waterBowlLevel = dog.hydrate(waterBowlButton, waterBowlLevel: waterBowlLevel)
        updateStatus()
        waterBar.progress = Float(Double(dog.getWater()) / 100.0)
    }
    @IBAction func feedCurrentDog(_ sender: Any) {
        foodBowlLevel = dog.feed(foodBowlButton, foodBowlLevel: foodBowlLevel)
        updateStatus()
        foodBar.progress = Float(Double(dog.getFood()) / 100.0)
    }
    
}
