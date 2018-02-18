//
//  ViewController.swift
//  Todoey
//
//  Created by Bobby on 06/02/2018.
//  Copyright © 2018 Bobby Oeng. All rights reserved.
//

import UIKit

class TodolistViewController: UITableViewController {

    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard //after (//MARK - Add New Items)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newItem = Item()
        newItem.title = "Find Bobby"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Find Minions"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Find Dylan"
        itemArray.append(newItem3)
        // This is persisting data
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
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
        
        let item = itemArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) // (2.1)
        
        cell.textLabel?.text = item.title
        
        //Ternary operator ==>
        //value = Condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    //1.didSelectRowAt 2.deselectRow 3.select checkmark in Assesories(m.storyBoard)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print (itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done //set 對反 （check = uncheck）這是新版
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        } //這是舊的版本，只供參考
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
        
    }

    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()//6
        
        let newItem = Item()
        newItem.title = textField.text!
        
        //1-Create new Alert
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        //2-Create New Action
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happend once the user click the Add Item button on our UIAlert
            self.itemArray.append(newItem)
            
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

