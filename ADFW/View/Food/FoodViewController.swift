//
//  FoodViewController.swift
//  ADFW
//
//  Created by MultiTV on 24/05/25.
//

import UIKit

class FoodViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    let allItems = ["Apple", "Banana", "Orange", "Mango", "Grapes", "Pineapple"]
       var filteredItems: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
       
    }
    
    func configureUI() {
        
        pageTitle.setStyledTextWithLastWordColor(fullText: "Food @ADFW", lastWordColor: .blueColor,fontSize: 19)
        
        searchView.layer.borderColor = UIColor(hex: "#A3A6A7").cgColor
        searchView.layer.borderWidth = 1
        tableView.register(UINib(nibName: "FoodTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        filteredItems = allItems
        tableView.delegate = self
        tableView.dataSource = self
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    
    @objc func textFieldDidChange() {
            let searchText = searchTextField.text ?? ""
            if searchText.isEmpty {
                filteredItems = allItems
            } else {
                filteredItems = allItems.filter { $0.lowercased().contains(searchText.lowercased()) }
            }
            tableView.reloadData()
        }
    

    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}

extension FoodViewController: UITableViewDelegate,UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodTableViewCell") as! FoodTableViewCell
     
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "FoodMenuViewController") as! FoodMenuViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
