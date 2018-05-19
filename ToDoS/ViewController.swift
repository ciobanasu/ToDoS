//
//  ViewController.swift
//  ToDoS
//
//  Created by Ciobanasu Ion on 18/05/2018.
//  Copyright © 2018 Laurean Mateiu. All rights reserved.
//

import UIKit
import RealmSwift

var todos: Results<ToDo>!
var realm = try! Realm()

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    

    @IBOutlet var toDoTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todos                          = realm.objects(ToDo.self)
        toDoTableView.dataSource       = self
        toDoTableView.delegate         = self
        reload()
        //self.toDoTableView.rowHeight   = 50
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.5450980392, blue: 0.5450980392, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reload()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  // hide status bar
//  override var prefersStatusBarHidden: Bool {
//    return true
//  }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "todoCell" {
            let destination             = segue.destination as! InsertViewController
            let todo                    = todos[toDoTableView.indexPathForSelectedRow!.row]
            destination.incomingToDo    = todo
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! ToDoCell
        cell.todoText.font               = UIFont(name: "Apple SD Gothic Neo", size: 20)
        cell.isDoneText.font             = UIFont(name: "Apple SD Gothic Neo", size: 20)
        cell.todoText.numberOfLines      = 0
        let todo                         = todos[indexPath.row]
        cell.todoText.text               = todo.ToDoText
        cell.isDoneText.text             = todo.IsDone ? "Done" : "Do it"
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numOfSections: Int            = 0
        if (todos.count > 0) {
            toDoTableView.separatorStyle  = .singleLine
            numOfSections                 = todos.count
            toDoTableView.backgroundView  = nil
        } else {
            let imageName                 = "to-do.png"
            let image                     = UIImage(named: imageName)
            let imageView                 = UIImageView(image: image!)
            imageView.frame               = CGRect(x: 0, y: 0, width: toDoTableView.bounds.size.width,
                                                   height: toDoTableView.bounds.size.height - 10)
            imageView.layer.masksToBounds = true
            imageView.contentMode         = UIViewContentMode.scaleAspectFit
            imageView.backgroundColor     = #colorLiteral(red: 0, green: 0.5450980392, blue: 0.5450980392, alpha: 1)
            toDoTableView.backgroundColor = #colorLiteral(red: 0, green: 0.5450980392, blue: 0.5450980392, alpha: 1)
            toDoTableView.backgroundView  = imageView
            toDoTableView.separatorStyle  = .none
            toDoTableView.addSubview(imageView)
        }
        return numOfSections
  }
    func reload() {
        toDoTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! realm.write {
                realm.delete(todos[indexPath.row])
            }
            reload()
        }
    }
}

class ToDo : Object {
    @objc dynamic var ToDoText = ""
    @objc dynamic var IsDone = false
}

class ToDoCell: UITableViewCell {
    @IBOutlet weak var isDoneText: UILabel!
    @IBOutlet weak var todoText: UILabel!
}

