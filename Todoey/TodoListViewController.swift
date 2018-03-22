//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Mango Apps on 21/03/18.
//  Copyright © 2018 Mango Apps. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [itemModel]()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        let item = itemModel()
        item.title = "Find Mike"
        item.done = false
        itemArray.append(item)
        
        let item1 = itemModel()
        item1.title = "Be safe"
        item1.done = false
        itemArray.append(item1)
        if let items = defaults.array(forKey: "ToDoListArray") as? [itemModel] {
            itemArray = items
        }
        
        
    }
    
    //MARK: tableView datasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "toDoItemCell"
        let cell = tableView.dequeueReusableCell(withIdentifier:identifier , for: indexPath) as UITableViewCell
        cell.textLabel?.text = itemArray[indexPath.row].title
        let item = itemArray[indexPath.row]
        //item.done ? (cell.accessoryType = .checkmark) : (cell.accessoryType = .none)
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = itemArray[indexPath.row]
        item.done = !item.done
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
        
    }
    
    //MARK: add item
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        
        var alertTxtField = UITextField()
        let alertCtrl = UIAlertController(title: "Add Item",
                                          message: "Add something you need to do",
                                          preferredStyle: .alert)
        
        let alertAdd = UIAlertAction(title: "Add",
                                     style: .default) { (action) in
                                        
                                        let newItem = itemModel()
                                        newItem.title = alertTxtField.text!
                                        newItem.done = false
                                        self.itemArray.append(newItem)
                                        self.defaults.set(self.itemArray, forKey: "ToDoListArray")
                                        //self.defaults.synchronize()
                                        self.tableView.reloadData()
                                        
                        }
        
        let alertCancel = UIAlertAction(title: "Cancel",
                                        style: .destructive) { (action) in
                                            
                        }
        
        alertCtrl.addAction(alertAdd)
        alertCtrl.addAction(alertCancel)
        alertCtrl.addTextField { (txtField) in
            
            txtField.placeholder = "Create a new todo item"
            alertTxtField = txtField
            
        }
        
        self.navigationController?.present(alertCtrl,
                                           animated: true, completion: nil)
    }
}

