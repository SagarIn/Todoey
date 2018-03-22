//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Mango Apps on 21/03/18.
//  Copyright © 2018 Mango Apps. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Find mike", "Buy Eggos", "Distroy Demogorgen"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: tableView datasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "toDoItemCell"
        let cell = tableView.dequeueReusableCell(withIdentifier:identifier , for: indexPath) as UITableViewCell
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let pathSelected = indexPath.row
        print("your to is :\(itemArray[pathSelected])")
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.accessoryType == UITableViewCellAccessoryType.checkmark{
            cell?.accessoryType = .none
        } else{
            cell?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: add item
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        
        var alertTxtField = UITextField()
        let alertCtrl = UIAlertController(title: "Add Item",
                                          message: "Add something you need to do",
                                          preferredStyle: .alert)
        
        let alertAdd = UIAlertAction(title: "Add",
                                     style: .default) { (action) in
                                        
                                        self.itemArray.append(alertTxtField.text!)
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

