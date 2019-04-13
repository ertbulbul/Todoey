//
//  ViewController.swift
//  Todoey
//
//  Created by Sociable on 13.04.2019.
//  Copyright © 2019 Sociable. All rights reserved.
//

import UIKit
import SVProgressHUD

class ToDoListViewController: UITableViewController {
    
    var itemArray = ["Her","Zaman","Her","Yerde","En","Büyük","Fener"]
    
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }
    }

    //MARK - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
        
    }

    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var enteredMessage = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) {(action) in
            //what happen click add
            if enteredMessage.text == "" {
                SVProgressHUD.showError(withStatus: "You Can Not Enter Empty Note")
            }else {
                self.itemArray.append(enteredMessage.text!)
                self.defaults.set(self.itemArray, forKey: "TodoListArray")
                self.tableView.reloadData()
            }
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            enteredMessage=alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        

    }
    
}

