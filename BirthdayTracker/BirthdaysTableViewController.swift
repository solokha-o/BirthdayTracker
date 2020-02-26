//
//  BirthdaysTableViewController.swift
//  BirthdayTracker
//
//  Created by Oleksandr Solokha on 28.01.20.
//  Copyright © 2020 Oleksandr Solokha. All rights reserved.
//

import UIKit
import CoreData

class BirthdaysTableViewController: UITableViewController {
    
    
    
    @IBOutlet var birthdayTableView: UITableView!
    
    var birthdays = [Birthday]()
    
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = Birthday.fetchRequest() as NSFetchRequest<Birthday>
        do {
            birthdays = try context.fetch(fetchRequest)
        } catch let error {
            print("Не удалось загрузить данные из-за ошибки: \(error).")
            
        }
        tableView.reloadData()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return birthdays.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "birthdayCellIdentifier", for: indexPath)

        // Configure the cell...
        let birthday = birthdays[indexPath.row]
        let firstName = birthday.firstName ?? ""
        let lastName = birthday.lastName ?? ""
        cell.textLabel?.text = firstName + " " + lastName
        if let date = birthday.birthDate as Date? {
            cell.detailTextLabel?.text = dateFormatter.string(from: date)
        } else {
            cell.detailTextLabel?.text = " "
        }
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
   
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: "DELETE") {  [weak self] (_, _, _) in
           // let birthday = self?.birthdays[indexPath.row]
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            context.delete((self?.birthdays[indexPath.row])!)
            self?.birthdays.remove(at: indexPath.row)
            print("Remove birthday \(String(describing: self?.birthdays[indexPath.row]))")
            self?.tableView.deleteRows(at:[indexPath],with: .fade)
            do{
                try context.save()
            } catch let error {
                print("Не удалось сохранить из-за ошибки \(error).")
            }
      //      self?.tableView.reloadSections([indexPath.section], with: .automatic)
            print("DELETE HAPPENS")
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        swipeActions.performsFirstActionWithFullSwipe = false
        
        return swipeActions

    }
    
    // TODO - finish moveRow in Core Data
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let element1 = birthdays[sourceIndexPath.row]
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        context.delete(element1)
        birthdays.remove(at: sourceIndexPath.row)
        birthdays.insert(element1, at: destinationIndexPath.row)
        let element2 = birthdays[destinationIndexPath.row]
        context.insert(element2)
        do{
            try context.save()
        } catch let error {
            print("Не удалось сохранить из-за ошибки \(error).")
        }
        print(birthdays)
    }
    @IBAction func editAction(_ sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        sender.title = tableView.isEditing ? "Done" : "Edit"
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let birthday = birthdays[indexPath.row]
        performSegue(withIdentifier: "ShowDetails", sender: birthday)
    }

    
    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        switch editingStyle {
//        case .none:
//            print("None")
//        default:
//            return
//        }
//    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
   

}
