//
//  InsertViewController.swift
//  ToDoS
//
//  Created by Ciobanasu Ion on 18/05/2018.
//  Copyright © 2018 Laurean Mateiu. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

class InsertViewController: UIViewController, UITextFieldDelegate{

    var isGranted = false
    //MARK: - Function snooze
    func setCategories(){
        let snoozeAction5 = UNNotificationAction(identifier: "snooze", title: "Snooze after 5 minutes", options: [])
        let snoozeAction15 = UNNotificationAction(identifier: "snooze", title: "Snooze after 15 minutes", options: [])
        let snoozeAction30 = UNNotificationAction(identifier: "snooze", title: "Snooze after 30 minutes", options: [])
        let alarmCategory = UNNotificationCategory(identifier: "alarm.category",actions: [snoozeAction5,snoozeAction15,snoozeAction30],intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([alarmCategory])
    }
    
    var incomingToDo: ToDo? = nil
    let realm = try! Realm()
    var timeAmount: Double = 0
    
    var hour:Int = 0
    var minutes:Int = 0
    var seconds:Int = 0

    @IBOutlet var todoTextField: UITextField!
    @IBOutlet var todoSwitch: UISwitch!
    @IBOutlet var dataPicker: UIDatePicker!
    @IBOutlet var dateLabel: UILabel!
    
    @IBAction func remindSwitch(_ sender: UISwitch) {
        if (sender.isOn == true) {
            dataPicker.isHidden = false
            dismissKeyboard()
        } else {
            dataPicker.isHidden = true
            dateLabel.text = "dd-MM-yyyy HH:mm"
        }
    }
    
    // hide keyboard
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
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
        getNotification()
    }
    
    // notifications to do
    func getNotification() {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()

        content.title = "To DO"
        content.body = todoTextField.text!
        content.sound = UNNotificationSound(named: "notification.mp3")
        content.categoryIdentifier = "alarm.category"

        var dateComponents = DateComponents()
        
        let componenets = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: dataPicker.date)
        dateComponents.day = componenets.day
        dateComponents.month = componenets.month
        dateComponents.year = componenets.year
        dateComponents.hour = componenets.hour
        dateComponents.minute = componenets.minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        center.add(request, withCompletionHandler: nil)
        center.removeAllDeliveredNotifications()
}
    
    // datepicker changed
    @objc func dateChanged(_ sender: UIDatePicker) {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd-MM-yyyy HH:mm"
        let strDate = dateFormater.string(from: sender.date)
        self.dateLabel.text = strDate
    }
    // did load
    override func viewDidLoad() {
        super.viewDidLoad()
        todoTextField.delegate = self
        if let goodToDo = incomingToDo {
            todoTextField.text = goodToDo.ToDoText
            todoSwitch.isOn = goodToDo.IsDone
        }
    navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        self.title = "Add new to do"
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.red]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        dataPicker.isHidden = true
        dataPicker.minimumDate = Date()
        dataPicker.locale = Locale.current
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (didAllow, error) in
            self.isGranted = didAllow
            if didAllow {
                self.setCategories()
            } else {
                let alert = UIAlertController(title: "Notification Access", message: "In order to use this application, turn on notification permissions.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
                alert.addAction(alertAction)
                self.present(alert , animated: true, completion: nil)
            }
        }
        dataPicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
