//
//  InsertViewController.swift
//  ToDoS
//
//  Created by Ciobanasu Ion on 18/05/2018.
//  Copyright © 2018 Laurean Mateiu. All rights reserved.
//

import UIKit
import RealmSwift

class InsertViewController: UIViewController {
    
    var incomingToDo: ToDo? = nil
    let realm = try! Realm()
    
    @IBOutlet var todoTextField: UITextField!
    @IBOutlet var todoSwitch: UISwitch!
    
    @IBAction func saveButtonAction(_ sender: Any) {
      
//      if (todoTextField.text?.isEmpty)! {
//        let alertController = UIAlertController(title: "To Do", message: "The field shouldn't be empty", preferredStyle: .alert)
//        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
//        alertController.addAction(action)
//        self.present(alertController, animated: true, completion: nil)
//      }
//
        if let goodToDo = incomingToDo {
            try! realm.write {
                goodToDo.IsDone = todoSwitch.isOn
                goodToDo.ToDoText = todoTextField.text!
            }
        }
        else {
            let todo = ToDo()
            todo.ToDoText = todoTextField.text!
            todo.IsDone = todoSwitch.isOn
            try! realm.write {
                realm.add(todo)
            }
        }
        navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let goodToDo = incomingToDo {
            todoTextField.text = goodToDo.ToDoText
            todoSwitch.isOn = goodToDo.IsDone
        }
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
