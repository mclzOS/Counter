//
//  ViewController.swift
//  Counter
//
//  Created by Mircea Zahacinschi on 29.11.18.
//  Copyright © 2018 Mircea Zahacinschi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    var longestStreakTime = 0
    var currentStreakTime = 0
    
    
    @IBOutlet weak var longestStreak: UILabel!
    
    @IBOutlet weak var currentStreak: UILabel!
    
    @IBOutlet weak var nameProject: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        checkForProjectName()
        adjustingTime()
        checkForCurrentAndLongestStreakValue()
      
        
    }

    @IBAction func beginProject(_ sender: Any) {
        
        defaults.set(Date(), forKey: "startDate")
        
        
        }
    
    
    @IBAction func resetProject(_ sender: Any) {
        
        
        currentStreak.text = "\(0)"
        
        addToStreak()
        
        print ("Streak restarted")
        
        
    }
    
    
    @IBAction func renameProject(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Rename Project", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Rename Project", style: .default) { (action) in
            
            self.defaults.set(textField.text, forKey: "titleOfProject")
            self.nameProject.text = self.defaults.string(forKey: "titleOfProject")
            
        }
        
        alert.addTextField { (alertTextfield) in
            textField.placeholder = "Rename Project"
            textField = alertTextfield
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
}
    
    
    
    
    @IBAction func resetButton(_ sender: Any) {
        resetValues()
    }
    
    
    
    
    // Mark: - Methods
    
    func adjustingTime (){
        
        let interval = Date().timeIntervalSince(defaults.object(forKey: "startDate")as! Date)
        
        if interval > 86400 {
                currentStreakTime += 1
                defaults.set(currentStreakTime, forKey: "currentStreakTime")
        }
        else{
            currentStreak.text = String(defaults.integer(forKey: "currentStreakTime"))
        }
    }
    
    func addToStreak() {
        longestStreakTime += 1
        longestStreak.text = "\(longestStreakTime)"
        defaults.set(longestStreakTime, forKey: "longestStreakTime")
        
    }
    
    func checkForCurrentAndLongestStreakValue() {
        
        
        currentStreak.text = String(defaults.integer(forKey: "currentStreakTime"))
        
        longestStreak.text = String(defaults.integer(forKey: "longestStreakTime"))
        
    }
    
    func checkForProjectName() {
        if (defaults.string(forKey: "titleOfProject") == nil) {
            nameProject.text = "New Journey"
        }
        else {
            nameProject.text = defaults.string(forKey: "titleOfProject")
        }
        
        
    }
    
    func resetValues() {
        currentStreak.text = "\(0)"
        longestStreak.text = "\(0)"
        defaults.set(0, forKey: "longestStreakTime")
        defaults.set(0, forKey: "currentStreakTime")
    }
    }

