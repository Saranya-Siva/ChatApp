//
//  ViewController.swift
//  ChatApp
//
//  Created by Saranya Kalyanasundaram on 7/1/20.
//  Copyright © 2020 Saranya. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

   
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        titleLabel.text = ""
        var i = 0.0
        let temp = C.appName
        for character in temp{
            i += 1
            Timer.scheduledTimer(withTimeInterval: 0.1*i, repeats: false) { (timer) in
                self.titleLabel.text?.append(character)
            }
        }
        
    }
    

}

