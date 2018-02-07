//
//  ViewController.swift
//  Todoey
//
//  Created by Bobby on 06/02/2018.
//  Copyright © 2018 Bobby Oeng. All rights reserved.
//

import UIKit

class TodolistViewController: UITableViewController {

    
    var itemArray = ["Find Bobby", "Buy Cookies", "Destroy honey"]
    
    let defaults = UserDefaults.standard //after (//MARK - Add New Items)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // This is persisting data
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }
    }

    // 1. MARK - Tableview Datasource Methods
    
    //1)numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count //it will return all item in itemArray
    }
    
    //1.1)cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell = UITableViewCell(style: default, reuseIdentifier: "ToDoItemCell") // (2.1)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) // (2.1)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    //1.didSelectRowAt 2.deselectRow 3.select checkmark in Assesories(m.storyBoard)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print (itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
        
    }

    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()//6
        
        //1-Create new Alert
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        //2-Create New Action
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happend once the user click the Add Item button on our UIAlert
            self.itemArray.append(textField.text!)
            
            self.defaults.setValue(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
            
        }
        //5
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            print(alertTextField)
            
        }
        
        alert.addAction(action) //3
       
        present(alert, animated: true, completion: nil) //4
        
    }
    
    
}

