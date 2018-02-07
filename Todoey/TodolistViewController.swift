//
//  ViewController.swift
//  Todoey
//
//  Created by Bobby on 06/02/2018.
//  Copyright © 2018 Bobby Oeng. All rights reserved.
//

import UIKit

class TodolistViewController: UITableViewController {

    
    let itemArray = ["Find Bobby", "Buy Cookies", "Destroy honey"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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

    
    
    
}

