//
//  OurPartnerViewController.swift
//  ADFW
//
//  Created by MultiTV on 26/05/25.
//

import UIKit

class OurPartnerViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var pageTitle: UILabel!
    
    
    struct PartnerViewModel {
          let title: String
          let logos: [String]
      }

      var partnerSections: [PartnerViewModel] = [
          PartnerViewModel(title: "Headline Partner", logos: ["ADQ"]),
          PartnerViewModel(title: "Strategic Partners", logos: ["ADCB", "Abu Dhabi", "Etihad", "Etoro", "HSBC", "HUB71"]),
          PartnerViewModel(title: "Official Partners", logos: ["ADIB", "ADNOC", "Circle", "Further", "IOTA", "Mubadala","Mubadala"]),
      ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "OurPartnerTableViewCell", bundle: nil), forCellReuseIdentifier: "OurPartnerTableViewCell")
               tableView.delegate = self
               tableView.dataSource = self
               tableView.separatorStyle = .none
        
        
        configureUI()
    }
    
    
    func configureUI() {
        navigationView.layer.shadowColor = UIColor(hex: "#0000000D").cgColor
        navigationView.layer.shadowOpacity = 0.25
        navigationView.layer.shadowOffset = CGSize(width: 0, height: 3) // bottom only
        navigationView.layer.shadowRadius = 1
        navigationView.layer.masksToBounds = false
    }
    
    
    @IBAction func buttonAction(_ sender: Any) {
        self.dismiss(animated: true)
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

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "OurPartnerTableViewCell", for: indexPath) as! OurPartnerTableViewCell

           let section = partnerSections[indexPath.section]
           let logos = section.logos
        print("indexPath",indexPath.row)
        debugPrint(indexPath.row)
           let index = indexPath.row * 2
        print("index",index)
           let leftImageName = index < logos.count ? logos[index] : nil
           let rightImageName = (index + 1) < logos.count ? logos[index + 1] : nil

           let leftImage = leftImageName != nil ? UIImage.parter: nil
          let rightImage = rightImageName != nil ? UIImage.parter: nil

           cell.configure(leftImage: leftImage, rightImage: rightImage)
           return cell
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       

    }

}
