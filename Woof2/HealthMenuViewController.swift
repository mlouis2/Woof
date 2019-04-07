//
//  HealthMenuViewController.swift
//  Woof2
//
//  Created by Maddie Louis on 4/7/19.
//  Copyright © 2019 Maddie Louis. All rights reserved.
//
import UIKit
class HealthMenuViewController: UIViewController {
    
    
    @IBOutlet weak var healthMenu: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignBackground()
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
    
    @IBAction func closeHealthMenu(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
}
