//
//  ViewController.swift
//  BirthdayTracker
//
//  Created by Oleksandr Solokha on 08.01.20.
//  Copyright © 2020 Oleksandr Solokha. All rights reserved.
//

import UIKit

protocol AddBirthdayViewControllerDelegate {
    func addBirthdayViewController(_ addBirthdayViewController: AddBirthdayViewController, didAddBirthday birthday: Birthday) 
}

class AddBirthdayViewController: UIViewController {
    
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var birthdatePicker: UIDatePicker!
    
    var delegate : AddBirthdayViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        birthdatePicker.maximumDate = Date()
    }
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        print("Button is ON!")
        
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        print("My name \(firstName) \(lastName)!")
        
        let birthDate = birthdatePicker.date
        print("Date of my Birthday is \(birthDate)")
        
        let newBirthday = Birthday.init(firstName: firstName, lastName: lastName, birthDate: birthDate)
        
        print("My name \(newBirthday.firstName)")
        print("My lastname \(newBirthday.lastName)")
        print("My dirthday \(newBirthday.birthDate)")
        
        delegate?.addBirthdayViewController(self, didAddBirthday: newBirthday)
        dismiss(animated: true, completion: nil)

    }
    
    @IBAction func cancelTapped(_ sendr: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}

