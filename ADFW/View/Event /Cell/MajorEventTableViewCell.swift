//
//  MajorEventTableViewCell.swift
//  ADFW
//
//  Created by MultiTV on 22/05/25.
//

import UIKit

struct EventTagModel {
    let iconName: String?    // e.g., "calendar", "clock", "location"
    let title: String
    let isButton: Bool       // for special styling (e.g., "Invite Only")
    let color: String
}


class MajorEventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bannerimageView: ScaledHeightImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descrtion: UILabel!
    @IBOutlet weak var ViewAgendaButton: UIButton!
    @IBOutlet weak var ViewDetailButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var ViewWebSite: UIButton!
    
    @IBOutlet weak var viewDetailsCons: NSLayoutConstraint!
    @IBOutlet weak var viewAgandaCons: NSLayoutConstraint!
    
    weak var delegate: HomeSessionTableViewCellDelegate?
    
    
    @IBOutlet weak var stackViewHeightConst: NSLayoutConstraint!
    
    @IBOutlet weak var stackViewTopConst: NSLayoutConstraint!
    
    var tags: [EventTagModel] = []
    var viewAganda: (() -> Void)?
    var viewDetail: (() -> Void)?
    var viewWebSite: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        let layout = LeftAlignedCollectionViewFlowLayout1()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: "MajorEventCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MajorEventCollectionViewCell")
        configureUI()
    
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
 
    func configureUI () {
        selectionStyle = .none
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.4
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 4
        containerView.layer.cornerRadius = 3
        containerView.layer.masksToBounds = false

        descriptionLabel.font = FontManager.font(weight: .medium, size: 13)
        
        DispatchQueue.main.async {
                self.updateCollectionViewHeight()
            }
    }
    
    func updateCollectionViewHeight() {
        self.collectionView.layoutIfNeeded()
        self.collectionViewHeightConstraint.constant = self.collectionView.contentSize.height
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.layoutIfNeeded()

        let newHeight = collectionView.collectionViewLayout.collectionViewContentSize.height
        if collectionViewHeightConstraint.constant != newHeight {
            collectionViewHeightConstraint.constant = newHeight
            delegate?.homeSessionCellDidUpdateHeight()
        }
    }
    
    override func prepareForReuse() {
            super.prepareForReuse()
        bannerimageView.image = nil
        }
    

    
    func configure(with item: Agendas?) {
        
        if let data = item {
            descrtion.text = data.description
            bannerimageView.image = nil
            if let urlString = data.image, let url = URL(string: urlString) {
                bannerimageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder")) { [weak self] result in
                    switch result {
                    case .success:
                        self?.bannerimageView.invalidateIntrinsicContentSize()
                        self?.setNeedsLayout()
                        self?.layoutIfNeeded()
                        
                        // Notify tableView to update the height of this cell
                        if let tableView = self?.superview as? UITableView {
                            if let indexPath = tableView.indexPath(for: self!) {
                                tableView.reloadRows(at: [indexPath], with: .none)
                            }
                        }
                    case .failure(let error):
                        print("Image load failed: \(error)")
                    }
                }


            } else {
                bannerimageView.image = UIImage(named: "")
            }
            
            if data.viewAgenda ?? false {
                ViewAgendaButton.isHidden = false
                //viewAgandaCons.constant = 32
            } else {
                ViewAgendaButton.isHidden = true
                //viewAgandaCons.constant = 0
            }
            
            if data.viewDetails ?? false {
                ViewDetailButton.isHidden = false
               // viewDetailsCons.constant = 32
            } else {
                ViewDetailButton.isHidden = true
                //viewDetailsCons.constant = 0
            }
            
            if data.viewWebsite ?? false {
                ViewWebSite.isHidden = false
               // viewDetailsCons.constant = 32
            } else {
                ViewWebSite.isHidden = true
                //viewDetailsCons.constant = 0
            }
            
            if !(data.viewWebsite ?? false) && !(data.viewAgenda ?? false) && !(data.viewDetails ?? false) {
                stackViewHeightConst.constant = 0
                stackViewTopConst.constant = 0
            } else {
                stackViewHeightConst.constant = 32
                stackViewTopConst.constant = 16
            }
            
            ViewAgendaButton.tintColor = UIColor.white
            ViewAgendaButton.backgroundColor = UIColor(hex: data.color ?? "")
            ViewWebSite.tintColor = UIColor.white
            ViewWebSite.backgroundColor = UIColor(hex: data.color ?? "")
            ViewDetailButton.tintColor = UIColor(hex: data.color ?? "")
            ViewDetailButton.layer.borderColor = UIColor(hex: data.color ?? "").cgColor
            ViewDetailButton.layer.borderWidth = 1
            
            setButtonTitle(ViewDetailButton, title: "VIEW DETAILS")
            setButtonTitle(ViewWebSite, title: "VIEW WEBSITE")
            setButtonTitle(ViewAgendaButton, title: "VIEW AGENDA")

           
            self.tags = [
                .init(iconName: "calendarIcon", title: formatToDayMonth(from: data.date ?? "") ?? "", isButton: false, color:  data.color ?? ""),
                .init(iconName: "clock", title: data.time ?? "", isButton: false, color:  data.color ?? ""),
                .init(iconName: "calendar", title: data.location?.name ?? "", isButton: false, color:  data.color ?? ""),
                .init(iconName: nil, title: data.agendaType?.name ?? "", isButton: true, color:  data.color ?? "")
            ]
            
            
          
            
            collectionView.reloadData()
            
        }
     
       
    }
    
    func formatToDayMonth(from isoString: String) -> String? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        guard let date = isoFormatter.date(from: isoString) else {
            return nil
        }

        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "d MMM"
        return displayFormatter.string(from: date)
    }

    
    
    func setButtonTitle(_ button: UIButton, title: String) {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: FontManager.font(weight: .semiBold, size: 10)
        ]
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.setAttributedTitle(attributedTitle, for: .selected)
    }
    
    
    
    
    
    
    @IBAction func viewAganda(_ sender: Any) {
        viewAganda?()
    }
    
    
    
    @IBAction func viewDetail(_ sender: Any) {
        viewDetail?()
    }
    
    
    @IBAction func viewWebsiteAction(_ sender: Any) {
        viewWebSite?()
    }
    
    
    

}


extension MajorEventTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = tags[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MajorEventCollectionViewCell", for: indexPath) as! MajorEventCollectionViewCell
        cell.configure(with: model)
        
    
        return cell
    }
    
}




class LeftAlignedCollectionViewFlowLayout1: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }

        var leftMargin: CGFloat = sectionInset.left
        var maxY: CGFloat = -1.0

        for layoutAttribute in attributes {
            if layoutAttribute.representedElementCategory == .cell {
                if layoutAttribute.frame.origin.y >= maxY {
                    leftMargin = sectionInset.left
                }

                layoutAttribute.frame.origin.x = leftMargin
                leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
                maxY = max(layoutAttribute.frame.maxY, maxY)
            }
        }
        return attributes
    }
}

//extension MajorEventTableViewCell {
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let tag = tags[indexPath.item]
//        let label = UILabel()
//        label.text = tag.title
//        label.font = .systemFont(ofSize: 14)
//        label.sizeToFit()
//
//        let baseWidth = label.frame.width
//        let iconWidth: CGFloat = tag.iconName != nil ? 20 : 0
//        let padding: CGFloat = 24 // Inner cell padding
//
//        return CGSize(width: baseWidth + iconWidth + padding, height: 60) // Increased height
//    }
//}
