//
//  OurPartnerViewController.swift
//  ADFW
//
//  Created by MultiTV on 26/05/25.
//

import UIKit


struct PartnerViewModels {
      let title: String
      let logos: [String]
  }



class OurPartnerViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var pageTitle: UILabel!
    
    
    var viewModel = PartnerViewModel()
    
    var partnerSections: [PartnerViewModels] = []

    var currentPage = 1
    var isLoading = false
    var isLastPage = false

  
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "OurPartnerTableViewCell", bundle: nil), forCellReuseIdentifier: "OurPartnerTableViewCell")
               tableView.delegate = self
               tableView.dataSource = self
               tableView.separatorStyle = .none
        
        
        configureUI()
        
        getPartnerData(page: 1)

    }
    
    
    func configureUI() {
        navigationView.layer.shadowColor = UIColor(hex: "#0000000D").cgColor
        navigationView.layer.shadowOpacity = 0.25
        navigationView.layer.shadowOffset = CGSize(width: 0, height: 3) // bottom only
        navigationView.layer.shadowRadius = 1
        navigationView.layer.masksToBounds = false
        pageTitle.setStyledTextWithLastWordColor(fullText: "Our Partners", lastWordColor: .blueColor,fontSize: 19)
    }
    
    
    @IBAction func buttonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


extension OurPartnerViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
          return partnerSections.count
      }

      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          let count = partnerSections[section].logos.count
          return Int(ceil(Double(count) / 2.0))
      }

      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 140
      }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white

        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = partnerSections[section].title
        titleLabel.textAlignment = .center
        titleLabel.font = FontManager.font(weight: .semiBold, size: 18)
        titleLabel.textColor = UIColor.blueColor

        headerView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8)
        ])

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "OurPartnerTableViewCell", for: indexPath) as! OurPartnerTableViewCell

           let section = partnerSections[indexPath.section]
           let logos = section.logos
           let index = indexPath.row * 2
        let leftImageURL = index < logos.count ? logos[index] : nil
        let rightImageURL = (index + 1) < logos.count ? logos[index + 1] : nil

        cell.configure(leftImageURL: leftImageURL, rightImageURL: rightImageURL)

           return cell
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       

    }

}


extension OurPartnerViewController: UIScrollViewDelegate {
    
    func getPartnerData(page: Int) {
        guard !isLoading, !isLastPage else { return }
        isLoading = true
        
        viewModel.fetchPartnerData(page: page, in: self.view) { result in
            self.isLoading = false
            switch result {
            case .success(let response):
                if let partners = response.data, !partners.isEmpty {
                    let newSections = self.transformToPartnerViewModels(from: partners)
                    if page == 1 {
                        self.partnerSections = newSections
                    } else {
                        self.partnerSections.append(contentsOf: newSections)
                    }

                    self.currentPage = page
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else {
                    self.isLastPage = true
                    if page == 1 {
                        MessageHelper.showToast(message: "No partner data available.", in: self.view)
                    }
                }
            case .failure(let error):
                MessageHelper.showAlert(message: error.localizedDescription, on: self)
            }
        }
    }


    func transformToPartnerViewModels(from partners: [Partner]) -> [PartnerViewModels] {
        // Dictionary to group logos by category label
        var categoryDict: [String: [String]] = [:]

        for partner in partners {
            // Safely unwrap category label and websiteImage
            guard let label = partner.categories?.label,
                  let image = partner.websiteImage,
                  !image.isEmpty else {
                continue
            }

            // Append the image to the correct category
            categoryDict[label, default: []].append(image)
        }

        // Map the dictionary into PartnerViewModels
        let viewModels = categoryDict.map { (label, images) in
            PartnerViewModels(title: label, logos: images)
        }

        // Optionally sort by label or any other criteria
//        return viewModels.sorted { $0.title < $1.title }
        return viewModels
    }

    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height
        
        if position > contentHeight - scrollViewHeight - 100 {
            getPartnerData(page: currentPage + 1)
        }
    }

    
    
}



