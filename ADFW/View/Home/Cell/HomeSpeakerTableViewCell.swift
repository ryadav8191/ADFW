//
//  HomeSpeakerTableViewCell.swift
//  ADFW
//
//  Created by MultiTV on 27/05/25.
//

import UIKit

class HomeSpeakerTableViewCell: UITableViewCell {

    
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var viewAll: UIButton!
    
    
  
    
    
    var onClickViewAll: (() -> Void)?
    weak var delegate: HomeSessionTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
        selectionStyle = .none
        if let layout = collectionview.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = .zero
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        collectionview.collectionViewLayout.invalidateLayout()
        collectionview.layoutIfNeeded()

        let newHeight = collectionview.collectionViewLayout.collectionViewContentSize.height
//        if collectionViewHeightConstraint.constant != newHeight {
//            collectionViewHeightConstraint.constant = newHeight
//            delegate?.homeSessionCellDidUpdateHeight()
//        }
    }
    
    
    
    func configureUI() {
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.register(UINib(nibName: "SpeackerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SpeackerCollectionViewCell")
        
        titleLabel.setStyledTextWithLastWordColor(fullText: "Our Speakers", lastWordColor: .blueColor)
        
    }
    
    @IBAction func viewAllAction(_ sender: Any) {
        onClickViewAll?()
    }
    
    
}

//MARK: -- UICollectionViewDataSource,UICollectionViewDelegate
extension HomeSpeakerTableViewCell: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpeackerCollectionViewCell", for: indexPath) as! SpeackerCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let spacing: CGFloat = 8 // Space between cells
        let totalSpacing = spacing * 3 // left + right + between cells
        
        let width = (collectionView.bounds.width - totalSpacing) / 3
        return CGSize(width: width, height: 300)
    }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
                return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 16)
           
        }
        

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let story = UIStoryboard(name: "Main", bundle: nil)
//        let vc = story.instantiateViewController(identifier: "SpeackerDetailViewController") as! SpeackerDetailViewController
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    private func heightForText(_ text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect,
                                            options: [.usesLineFragmentOrigin, .usesFontLeading],
                                            attributes: [.font: font],
                                            context: nil)
        return ceil(boundingBox.height)
    }
}

