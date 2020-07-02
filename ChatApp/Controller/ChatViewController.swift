//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Saranya Kalyanasundaram on 7/1/20.
//  Copyright © 2020 Saranya. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = C.appName
        navigationItem.hidesBackButton = true
        tableView.dataSource = self
        tableView.register(UINib(nibName: C.cellNibName, bundle: nil), forCellReuseIdentifier: C.cellIdentifier)
        loadMessages()
    }
    
    func loadMessages(){
        
        db.collection(C.FStore.collectionName).order(by: C.FStore.dateField).addSnapshotListener() { (querySnapShot, error) in
            
            self.messages = []
            
            if let err = error{
                print("Error retrieving data \(err.localizedDescription)")
            }
            else{
                if let snapShotDocuments = querySnapShot?.documents{
                    for document in snapShotDocuments{
                        if let sender = document.data()[C.FStore.senderField] as? String, let message = document.data()[C.FStore.bodyField] as? String{
                            let newMsg = Message(sender: sender, messageBody: message)
                            self.messages.append(newMsg)
                            
                            DispatchQueue.main.async{
                                let indexPath = IndexPath(item: self.messages.count-1, section: 0)
                                self.tableView.reloadData()
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                            }
                        }
                        
                    }
                }
            }
        }
        
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let message = messageTextfield.text, let sender = Auth.auth().currentUser?.email{
            let date = Date().timeIntervalSince1970
            
            db.collection(C.FStore.collectionName).addDocument(data: [C.FStore.senderField : sender, C.FStore.bodyField : message, C.FStore.dateField : date]){(error) in
                if let err = error{
                    print(err.localizedDescription)
                }else{
                    print("Successfully saved data.")
                    DispatchQueue.main.async{
                         self.messageTextfield.text = ""
                    }
                   
                }
            }
            
        }
    }
    

    @IBAction func logOutPressed(_ sender: Any) {
        do{
            try Auth.auth().signOut()
             navigationController?.popToRootViewController(animated: true)
        }catch let signOutError as NSError{
            print("Error signing out %@",signOutError)
        }
        
       
    }
}

extension ChatViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: C.cellIdentifier, for: indexPath) as! MessageTableViewCell
        cell.messageLabel.text = message.messageBody
        
        if message.sender == Auth.auth().currentUser?.email{
            cell.meAvatar.isHidden = false
            cell.youAvatar.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: C.BrandColors.purple)
            cell.messageLabel.textColor = UIColor(named: C.BrandColors.lightPurple)
        }
        else{
            cell.meAvatar.isHidden = true
            cell.youAvatar.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: C.BrandColors.lightPurple)
            cell.messageLabel.textColor = UIColor(named: C.BrandColors.purple)
        }
        
        
        return cell
    }
}

extension ChatViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        messageTextfield.text = ""
    }
    
}
