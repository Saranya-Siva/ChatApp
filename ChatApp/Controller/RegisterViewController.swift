//
//  RegisterViewController.swift
//  ChatApp
//
//  Created by Saranya Kalyanasundaram on 7/1/20.
//  Copyright © 2020 Saranya. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text{
           Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let err = error{
                print(err.localizedDescription)
            }
            else{
                self.performSegue(withIdentifier: C.registerSegue, sender: self)
            }
            }
        }
    }
    
}
