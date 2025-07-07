//
//  ChatViewController.swift
//  ADFW
//
//  Created by MultiTV on 16/05/25.
//

import UIKit

class ChatViewController: UIViewController {
    
    
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        configureUI()
       
    }
    
    func configureUI() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatTableViewCell")

        pageLabel.font = FontManager.font(weight: .semiBold, size: 19)
        
        navigationView.layer.shadowColor = UIColor(hex: "#0000000D").cgColor
        navigationView.layer.shadowOpacity = 0.25
        navigationView.layer.shadowOffset = CGSize(width: 0, height: 3) // bottom only
        navigationView.layer.shadowRadius = 1
        navigationView.layer.masksToBounds = false
    }
    
    
    
    @IBAction func profileAction(_ sender: Any) {
        
    }
    
    
    @IBAction func backAction(_ sender: Any) {
   
    }
    
    
    @IBAction func searchAction(_ sender: Any) {
   
    }
    
}


extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      //  return data.count
        return 10
    }

    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as! ChatTableViewCell
      //  let item = data[indexPath.row]
      //  cell.textLabel?.text = item.title
        return cell
    }

    // Row selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "ChatDetailViewController") as! ChatDetailViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
