//
//  OurPartnerViewController.swift
//  ADFW
//
//  Created by MultiTV on 26/05/25.
//

import UIKit
import SwiftUI





class OurPartnerViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var pageTitle: UILabel!
    
    
    var viewModel = PartnerViewModel()
    var gridViewModel = PartnerGridViewModel()
    
    var partnerSections: [PartnerViewModels] = []

    var currentPage = 1
    var isLoading = false
    var isLastPage = false

  
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(UINib(nibName: "OurPartnerTableViewCell", bundle: nil), forCellReuseIdentifier: "OurPartnerTableViewCell")
//  collectionView.collectionViewLayout = createLayout()
//        tableView.separatorStyle = .none
//        configureUI()
        
        
        addSwiftUIView()
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
    
    
    func addSwiftUIView() {
        let swiftUIView = PartnerGridView(viewModel: gridViewModel,onBack: { [weak self] in
            guard let self = self else { return }

            
            self.navigationController?.popViewController(animated: true)
            
            
            
        })
            let hostingController = UIHostingController(rootView: swiftUIView)

            addChild(hostingController)
            view.addSubview(hostingController.view)
            hostingController.didMove(toParent: self)

            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                hostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    
    @IBAction func buttonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
                    self.mergePartnerData(partners)
                    self.currentPage = page
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

    func mergePartnerData(_ partners: [Partner]) {
        var newCategoryDict: [String: [String]] = [:]

        for partner in partners {
            guard let label = partner.categories?.label,
                  let image = partner.websiteImage,
                  let url = URL(string: image),
                  !image.isEmpty else {
                continue
            }

            newCategoryDict[label, default: []].append(image)
        }

        for (label, newImages) in newCategoryDict {
            if let index = gridViewModel.partnerSections.firstIndex(where: { $0.title == label }) {
                gridViewModel.partnerSections[index].logos.append(contentsOf: newImages)
            } else {
                gridViewModel.partnerSections.append(PartnerViewModels(title: label, logos: newImages))
            }
        }

        gridViewModel.partnerSections.sort { $0.title < $1.title }
    }


//    func refreshPartnerView() {
//           // Remove old child
//           for child in children {
//               if let host = child as? UIHostingController<PartnerGridView> {
//                   host.willMove(toParent: nil)
//                   host.view.removeFromSuperview()
//                   host.removeFromParent()
//               }
//           }
//
//           // Add updated SwiftUI view
//           addPartnerSwiftUIView()
//       }

    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height
        
        if position > contentHeight - scrollViewHeight - 100 {
            getPartnerData(page: currentPage + 1)
        }
    }


    
}




extension OurPartnerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  partnerSections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  partnerSections[section].logos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PartnerCell.identifier, for: indexPath) as! PartnerCell
        cell.configure(with: partnerSections[indexPath.section].logos[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PartnerHeaderView.identifier, for: indexPath) as! PartnerHeaderView
        header.titleLabel.text = partnerSections[indexPath.section].title
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    
            let itemsPerRow: CGFloat = 2
            let spacing: CGFloat = 16
            
            let totalSpacing = (itemsPerRow - 1) * spacing
            let availableWidth = collectionView.bounds.width - totalSpacing
            let itemWidth = floor(availableWidth / itemsPerRow)
            
            return CGSize(width: itemWidth, height: itemWidth)
        }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {

        let spacing: CGFloat = 10
        let itemsPerRow: CGFloat = 2
        let numberOfItems = collectionView.numberOfItems(inSection: section)

        if numberOfItems >= Int(itemsPerRow) {
            return UIEdgeInsets(top: 0, left: spacing, bottom: spacing, right: spacing)
        }

        // For centering 1 item
        let totalSpacing = CGFloat(numberOfItems - 1) * spacing
        let availableWidth = collectionView.bounds.width - ((itemsPerRow - 1) * spacing)
        let itemWidth = floor(availableWidth / itemsPerRow)
        let totalItemWidth = CGFloat(numberOfItems) * itemWidth + totalSpacing
        let inset = max((collectionView.bounds.width - totalItemWidth) / 2, spacing)

        return UIEdgeInsets(top: 0, left: inset, bottom: spacing, right: inset)
    }



    
}



class PartnerHeaderView: UICollectionReusableView {
    static let identifier = "PartnerHeaderView"
    let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .systemBlue
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) { fatalError() }
}


class PartnerCell: UICollectionViewCell {
    static let identifier = "PartnerCell"
    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.contentMode = .scaleAspectFit
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4

        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
    }

    func configure(with url: String) {
        if let imageURL = URL(string: url) {
            URLSession.shared.dataTask(with: imageURL) { data, _, _ in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }

    required init?(coder: NSCoder) { fatalError() }
}


extension OurPartnerViewController: UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
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
