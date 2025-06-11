//
//  MajorEventViewController.swift
//  ADFW
//
//  Created by MultiTV on 22/05/25.
//

import UIKit

class MajorEventViewController: UIViewController {
    
    
    @IBOutlet weak var listViewButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationView: UIView!
    
    weak var delegate: FilterSelectionDelegate?

  
    var selectedIndex = 0
    var viewModel = MajorEventAgandaViewModel()
    
    var agendas = [Agendas]()
    var data = [MajorEventAgandaData]()
    var arrDate = [MajorEventAgandaData]()
    var isList = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource  = self
        tableView.dataSource = self
        tableView.delegate = self
        self.navigationController?.navigationBar.isHidden = true
        self.delegate = self
        registerCell()
        configureUI()
        getMajorEventData(date: "")
        listViewButton.setImage(UIImage.calendarToList, for: .normal)
    }
    

    func registerCell() {
        collectionView.register(UINib(nibName: "DateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DateCollectionViewCell")
        
        tableView.register(UINib(nibName: "MajorEventTableViewCell", bundle: nil), forCellReuseIdentifier: "MajorEventTableViewCell")
        
        tableView.register(UINib(nibName: "CalenderTableViewCell", bundle: nil), forCellReuseIdentifier: "CalenderTableViewCell")
        
        
        let nib = UINib(nibName: "AgendaHeaderView", bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: "AgendaHeaderView") //
       
        
        
    }
    
    func configureUI() {
        let fullText = "What’s Happening in ADFW 2024"
        let attributedString = NSMutableAttributedString(string: fullText)

        // Split text into words
        let words = fullText.components(separatedBy: " ")

        if words.count > 2,
           let firstRange = fullText.range(of: "What’s Happening in"),
           let secondRange = fullText.range(of: "ADFW 2024") {

            let nsFirst = NSRange(firstRange, in: fullText)
            let nsSecond = NSRange(secondRange, in: fullText)

            // Style for "Event"
            attributedString.addAttributes([
                .font: FontManager.font(weight: .semiBold, size: 19),
                .foregroundColor: UIColor.black
            ], range: nsFirst)

            // Style for "Agenda"
            attributedString.addAttributes([
                .font: FontManager.font(weight: .bold, size: 19),
                .foregroundColor: UIColor.blueColor
            ], range: nsSecond)
        }

        pageTitle.attributedText = attributedString
        searchBarView.layer.borderColor = UIColor(hex: "#A3A6A7").cgColor
        searchBarView.layer.borderWidth = 1
        navigationView.layer.shadowColor = UIColor(hex: "#0000000D").cgColor
        navigationView.layer.shadowOpacity = 0.25
        navigationView.layer.shadowOffset = CGSize(width: 0, height: 3) // bottom only
        navigationView.layer.shadowRadius = 1
        navigationView.layer.masksToBounds = false
        
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
    
    @IBAction func showListViewDataAction(_ sender: Any) {
        isList.toggle()
        
        if isList {
            listViewButton.setImage(UIImage.calendarToggleIcon, for: .normal)
            
        } else {
            listViewButton.setImage(UIImage.calendarToList, for: .normal)
            
        }
        tableView.reloadData()
        
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}


extension MajorEventViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrDate.count + 1
       }

       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCollectionViewCell", for: indexPath) as! DateCollectionViewCell
           
           let isSelected = indexPath.item == selectedIndex
           
           if indexPath.row == 0 {
               cell.configure(with: "Full Week", isSelected: isSelected)
           } else {
               
               let date = arrDate[indexPath.row - 1]
               cell.configure(with: Helper.formatToDayMonth(from: date.date ?? "") ?? "", isSelected: isSelected)
           }
           
           return cell
       }

       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           selectedIndex = indexPath.item
           if indexPath.row == 0 {
               getMajorEventData(date: "")
           } else {
               getMajorEventData(date: arrDate[indexPath.row - 1].date ?? "")
           }
        
           collectionView.reloadData()
           // Update agenda table based on selected date
       }
    
}

extension MajorEventViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 40)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8) // Adjust spacing as needed
       }
}



extension MajorEventViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return data[section].agendas?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = data[indexPath.section].agendas?[indexPath.row]

        if !isList {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MajorEventTableViewCell", for: indexPath) as! MajorEventTableViewCell
            cell.configure(with: item)
            cell.delegate = self
            
            cell.viewAganda = {
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "AgandaViewController") as? AgandaViewController {
                    vc.id = item?.id
                    vc.date = item?.date
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalenderTableViewCell", for: indexPath) as! CalenderTableViewCell
            
            cell.configureData(with: item)
            return cell
        }
       
        
     
        
        
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "AgendaHeaderView") as? AgendaHeaderView else {
            return nil
        }

        let sectionData = data[section] 
        header.configure(dateText: Helper.formatToDayFullMonth(from: sectionData.date ?? "" ) ?? "", yearText: Helper.extractYear(from: sectionData.date ?? "") ?? "",bannerImage: nil, hide: false)

        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60 // Adjust based on your XIB design
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


    }
    
   

}


extension MajorEventViewController: FilterSelectionDelegate {
    func didUpdateSelectedTags(_ tags: [String]) {
        print("Selected Tags:", tags)
       
    }
}


extension MajorEventViewController: HomeSessionTableViewCellDelegate {
    func homeSessionCellDidUpdateHeight() {
        DispatchQueue.main.async {
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }
}



extension MajorEventViewController {
    
    
    func getMajorEventData(date:String) {
        viewModel.fetchMajorAgandaData(date: date, page: 1, in: self.view) { result in
            switch result {
            case .success(let response):
                print("data:", response)
    
                    
                    if date == "" {
                        self.data = response
                        self.arrDate = response
                    
                    } else {
                        self.data = response
                        
                    }
    
                self.tableView.reloadData()
                self.collectionView.reloadData()
                    
                  
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.tableView.reloadData()
                    self.collectionView.reloadData()
                }
            
                
            case .failure(let error):
                // self.showNoDataView(true)
                print(error.localizedDescription)
                MessageHelper.showToast(message: error.localizedDescription, in: self.view)
            }
        }
    }

}






