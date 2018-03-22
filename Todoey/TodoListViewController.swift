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
      let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFilePath)
        
        loadData()
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
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = itemArray[indexPath.row]
        item.done = !item.done
        self.saveItem()
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
                                        self.itemArray.append(newItem)
                                        self.saveItem()
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
    
    func saveItem () {
        
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("\(error)")
            return
        }
    }
    
    func loadData(){
        
        if let itemsData = try? Data.init(contentsOf: dataFilePath!){
            
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([itemModel].self, from: itemsData)
            } catch {
                
                print("\(error)")
            }
            
        }

    }
}

