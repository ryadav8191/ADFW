//
//  FoodViewController.swift
//  ADFW
//
//  Created by MultiTV on 24/05/25.
//

import UIKit

class FoodViewController: UIViewController, UITextFieldDelegate, HomeSessionTableViewCellDelegate {
   
    
    
    
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var navigationView: UIView!
    
    var allItems: [RestaurantData] = []

    var filteredItems: [RestaurantData] = []
    let viewModel = RestaurantViewModel()
    var updateWorkItem: DispatchWorkItem?
    var currentPage = 1
    var isLoading = false
    var hasMoreData = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getRestaurent(page: currentPage)
       
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
        
        navigationView.layer.shadowColor = UIColor(hex: "#0000000D").cgColor
        navigationView.layer.shadowOpacity = 0.25
        navigationView.layer.shadowOffset = CGSize(width: 0, height: 3) // bottom only
        navigationView.layer.shadowRadius = 1
        navigationView.layer.masksToBounds = false
        
//        let nib = UINib(nibName: "FoodSectionHeaderView", bundle: nil)
//        tableView.register(nib, forHeaderFooterViewReuseIdentifier: "FoodSectionHeaderView")

    }
    
    
    @objc func textFieldDidChange() {
        let searchText = searchTextField.text?.lowercased() ?? ""
        
        if searchText.isEmpty {
            filteredItems = allItems
        } else {
            filteredItems = allItems.compactMap { section -> RestaurantData? in
                let venueNameMatches = section.venue_name?.lowercased().contains(searchText) == true
                
                guard let restaurants = section.restaurants else {
                    return venueNameMatches ? section : nil
                }
                
                let filteredRestaurants = restaurants.filter {
                    $0.restaurant_name?.lowercased().contains(searchText) == true
                }
                
                if venueNameMatches || !filteredRestaurants.isEmpty {
                    var newSection = section
                    newSection.restaurants = venueNameMatches ? restaurants : filteredRestaurants
                    return newSection
                }
                return nil
            }
        }
        
        tableView.reloadData()
    }


    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}

extension FoodViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        filteredItems.count
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems[section].restaurants?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodTableViewCell") as! FoodTableViewCell
        let data =  filteredItems[indexPath.section].restaurants?[indexPath.row]
        cell.configureData(restaurant: data)
        cell.viewMenu = { [weak self] in
            guard let self = self else {return}
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(identifier: "FoodMenuViewController") as! FoodMenuViewController
            vc.id = self.filteredItems[indexPath.section].restaurants?[indexPath.row].restaurant_id ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
   

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView = FoodSectionHeaderView()
        headerView.delegate = self
        let bannerImageURL = filteredItems[section].venue_banner_logo
        headerView.configure(bannerImage: bannerImageURL, hide: true)
        
        return headerView
    }

    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = SectionHeaderView()
//        if section == 0 {
//            headerView.configure(dateText: "", dayText: "", showHeaderView: false, height: self.view.frame.height/3 - 37, image: self.filteredItems[section].venue_banner_logo)
//        } else {
//            
//            headerView.configure(dateText: "", dayText: "", showHeaderView: true, height: self.view.frame.height/3 - 37, image: self.filteredItems[section].venue_banner_logo)
//        }
//           return headerView
//   }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

            return self.view.frame.height/9
       
   }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        if section == filteredItems.count - 1,
           let restaurantCount = filteredItems[section].restaurants?.count,
           row == restaurantCount - 1 {
            currentPage += 1
            getRestaurent(page: currentPage)
        }
    }

    
   
    
}

extension FoodViewController {
    
    func getRestaurent(page: Int) {
        guard !isLoading, hasMoreData else { return }
        isLoading = true

        viewModel.fetchRestaurants(page: page, pageSize: 100, in: self.view) { result in
            self.isLoading = false
            switch result {
            case .success(let restaurants):
               // print("✅ Fetched restaurants:", restaurants)
                if page == 1 {
                    self.filteredItems = restaurants
                    self.allItems = restaurants
                } else {
                    self.filteredItems.append(contentsOf: restaurants)
                    self.allItems.append(contentsOf: restaurants)
                }

                self.hasMoreData = !restaurants.isEmpty
                self.tableView.reloadData()
            case .failure(let error):
                self.hasMoreData = false
                MessageHelper.showAlert(message: error.localizedDescription, on: self)
            }
        }
    }

    func homeSessionCellDidUpdateHeight() {
        updateWorkItem?.cancel()
        updateWorkItem = DispatchWorkItem {
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: updateWorkItem!)
    }
    
}
