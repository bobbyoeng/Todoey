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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath)

        loadItems()
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
        
        let item = itemArray[indexPath.row]
        
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
        
        saveItems()
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        } //這是舊的版本，只供參考
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
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveItems()
        }
        //5
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action) //3
       
        present(alert, animated: true, completion: nil) //4
        
    }
    
    //MARK -: Model Manupulation Methods
    func saveItems(){
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to:dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems(){
       if let data = try? Data(contentsOf: dataFilePath!) {
         let decoder = PropertyListDecoder()
        do{
            itemArray = try decoder.decode([Item].self, from: data)
        } catch{
            print("Errors decoding item array \(error)")
        }
    }
    }

}
