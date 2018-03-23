//
//  dummyTodDoListViewController.swift
//  Todoey
//
//  Created by Mango Apps on 22/03/18.
//  Copyright © 2018 Mango Apps. All rights reserved.
//

import UIKit

class dummyTodDoListViewController: UITableViewController {

    var itemsList = [itemModel]()
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("dummyItems.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Dummy List"
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        
        let barBtn = UIBarButtonItem(title: "Add",
                                     style: .done,
                                     target: self,
                                     action: #selector(addTodoItem))
        self.navigationItem.rightBarButtonItem = barBtn
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dummyCell", for: indexPath)
        
        let item = itemsList[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        self.saveData()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = itemsList[indexPath.row]
        item.done = !item.done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func saveData() {
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemsList)
            try data.write(to: filePath!)
        } catch {
            print("error in storing data : \(error)")
            return
        }

    }
    
    func loadData() {
        
        if let data = try? Data.init(contentsOf: filePath!) {
            
            let coder = PropertyListDecoder()
            do {
                itemsList = try coder.decode([itemModel].self, from: data)
            } catch {
                print("\(error)")
                return
            }
            
        }
    }
    @objc func addTodoItem (){
        
        var alertTxtField = UITextField()
        let alertCtrl = UIAlertController(title: "Add Item",
                                          message: "Add something you need to do",
                                          preferredStyle: .alert)
        
        let alertAdd = UIAlertAction(title: "Add",
                                     style: .default) { (action) in
                                        
                                        let newItem = itemModel()
                                        newItem.title = alertTxtField.text!
                                        self.itemsList.append(newItem)
                                        self.saveData()
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
        
        present(alertCtrl,animated: true, completion: nil)
    }
}
