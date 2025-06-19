//
//  EnterntainmentViewController.swift
//  ADFW
//
//  Created by MultiTV on 28/05/25.
//

import UIKit
import SwiftUI

class EnterntainmentViewController: UIViewController, FilterSelectionDelegate, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var pagetitle: UILabel!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var headerBodyLabel: UILabel!
    
    
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    
    var isHeaderCollapsed = false
    private var gradientLayer: CAGradientLayer?
    var selectedIndex = -1
    var viewModel = EntertainmentViewModel()
    private let noDataView = NoDataView()
    var entertainments = [Entertainment]()
    var filteredItems = [Entertainment]()
    
    var currentPage = 1
    let pageSize = 10
    var isLoading = false
    var isLastPage = false
    
    
    //MARK:  viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        let headerRatio: CGFloat = 0.25
        headerViewHeightConstraint.constant = view.frame.height * headerRatio
        
        view.addSubview(noDataView)
        noDataView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noDataView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noDataView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noDataView.widthAnchor.constraint(equalTo: view.widthAnchor),
            noDataView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        noDataView.isHidden = true
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)

        //MARK: API Call
        getEnterainmentData()
        
    }
    
    
    override func viewDidLayoutSubviews() {
        DispatchQueue.main.async {
            if self.gradientLayer == nil {
                self.addAndroidStyleGradient()
            }
              self.gradientLayer?.frame = self.headerImageView.bounds
          }
    }
    
    func configureUI() {
        
        searchView.layer.borderColor = UIColor(hex: "#A3A6A7").cgColor
        searchView.layer.borderWidth = 1
        tableView.showsVerticalScrollIndicator = false
        
        pagetitle.setStyledTextWithLastWordColor(fullText: "Entertainment @ADFW", lastWordColor: .blueColor,fontSize: 19)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "EntertainmentADFWTableViewCell", bundle: nil), forCellReuseIdentifier: "EntertainmentADFWTableViewCell")
        
        tableView.register(UINib(nibName: "EntertainmentADFWTableViewCell", bundle: nil), forCellReuseIdentifier: "EntertainmentADFWTableViewCell")
        
       
    }
    
    private func addAndroidStyleGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.black.withAlphaComponent(0.0).cgColor,
            UIColor.black.cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        headerImageView.layer.addSublayer(gradient)
        self.gradientLayer = gradient
    }

    
    func didUpdateSelectedTags(_ tags: [String]) {
        print(tags)
    }
    
    private func showNoDataView(_ show: Bool) {
        DispatchQueue.main.async {
            self.noDataView.isHidden = !show
        }
    }
    
    
    
    @IBAction func calenderFilterAction(_ sender: Any) {
        
        let popupVC = ADFWPopupViewController()
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve

       
        popupVC.dates = self.getAllUniqueDates()
        popupVC.selectedIndex = self.selectedIndex

     
        popupVC.onDateSelected = { selectedDate, index in
            print("You selected: \(selectedDate) at index \(index)")
            self.selectedIndex = index

            if selectedDate.isEmpty {
                // Reset filter if deselected
                self.entertainments = self.filteredItems
            } else {
                self.entertainments = self.filteredItems.compactMap { entertainment in
                    // Filter each entertainment's artists by selected date
                    let filteredArtists = entertainment.artists?.filter { $0.date == selectedDate }
                    if let artists = filteredArtists, !artists.isEmpty {
                        return Entertainment(banner: entertainment.banner, name: entertainment.name, artists: artists)
                    } else {
                        return nil
                    }
                }
            }

            self.tableView.reloadData()
            self.showNoDataView(self.entertainments.isEmpty)
        }


        present(popupVC, animated: true)


    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func filterAction(_ sender: Any) {
        
        let overlay = FilterOverlayView(frame: view.bounds)
           overlay.alpha = 0
        overlay.delegate = self
           view.addSubview(overlay)

           UIView.animate(withDuration: 0.3) {
               overlay.alpha = 1
           }
   
    }
    
    
    
}



extension EnterntainmentViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.entertainments.first?.artists?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.entertainments.first?.artists?[section].shows?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntertainmentADFWTableViewCell") as! EntertainmentADFWTableViewCell
        
  
        
        if let data = self.entertainments.first?.artists?[indexPath.section].shows?[indexPath.row] {
            
            cell.configureUI(data)
        }
        
        
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         let headerView = SectionHeaderView()
         if section == 0 {
             headerView.configure(dateText: self.entertainments.first?.artists?[section].date ?? "", dayText: "Day \(section + 1)", showHeaderView: false, height: self.view.frame.height/3 - 37, image: self.entertainments.first?.banner)
         } else {
             
             headerView.configure(dateText:  self.entertainments.first?.artists?[section].date ?? "", dayText: "Day \(section + 1)", showHeaderView: true, height: self.view.frame.height/3 - 37, image: "")
         }
            return headerView
    }

     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         if section == 0 {
             return self.view.frame.height/3
         } else {
             return 37
         }
    }

     func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude // Eliminate extra spacing
    }
    


    
    func updateGradientLayer() {
        if self.gradientLayer == nil {
            self.addAndroidStyleGradient()
        }
        self.gradientLayer?.frame = self.headerImageView.bounds
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height * 1.5 {
            getEnterainmentData(page: currentPage + 1)
        }
    }

    
}




extension EnterntainmentViewController {
    
    
    func getEnterainmentData(page: Int = 1) {
        guard !isLoading, !isLastPage else { return }

        isLoading = true
        viewModel.fetchEntertainmentData(page: page, pageSize: pageSize, in: self.view) { result in
            self.isLoading = false

            switch result {
            case .success(let response):
                self.showNoDataView(false)

                guard let data = response.entertainments else {
                    self.isLastPage = true
                    if self.entertainments.isEmpty {
                        self.showNoDataView(true)
                        MessageHelper.showToast(message: "No entertainment data available.", in: self.view)
                    }
                    return
                }

                if data.count < self.pageSize {
                    self.isLastPage = true
                }

                if page == 1 {
                    self.entertainments = data
                } else {
                    self.entertainments.append(contentsOf: data)
                }

                self.filteredItems = self.entertainments
                self.tableView.reloadData()
                self.currentPage = page

            case .failure(let error):
                self.showNoDataView(true)
                MessageHelper.showToast(message: error.localizedDescription, in: self.view)
            }
        }
    }
  


    func getAllUniqueDates() -> [String] {
        var dateSet = Set<String>()
        filteredItems.forEach { entertainment in
            entertainment.artists?.forEach { artist in
                if let date = artist.date {
                    dateSet.insert(date)
                }
            }
        }
        return Array(dateSet).sorted() // sort if needed
    }
    
    
}





extension EnterntainmentViewController {
    
    
    @objc func searchTextChanged(_ textField: UITextField) {
        guard let query = textField.text?.lowercased(), !query.isEmpty else {
            self.entertainments = self.filteredItems // Reset
            self.tableView.reloadData()
            return
        }

        self.entertainments = self.filteredItems.compactMap { entertainment in
            let filteredArtists = entertainment.artists?.compactMap { artist in
                let filteredShows = artist.shows?.filter {
                    ($0.name?.lowercased().contains(query) ?? false) ||
                    ($0.location?.name?.lowercased().contains(query) ?? false)
                }
                if let filtered = filteredShows, !filtered.isEmpty {
                    return Artist(date: artist.date, shows: filtered)
                }
                return nil
            }

            if let artists = filteredArtists, !artists.isEmpty {
                return Entertainment(banner: entertainment.banner, name: entertainment.name, artists: artists)
            }
            return nil
        }

        self.tableView.reloadData()
        self.showNoDataView(self.entertainments.isEmpty)
    }

    
}


