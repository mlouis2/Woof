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
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeHealthMenu(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
}
