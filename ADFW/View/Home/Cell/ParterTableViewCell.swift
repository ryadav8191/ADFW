//
//  ParterTableViewCell.swift
//  ADFW
//
//  Created by MultiTV on 27/05/25.
//

import UIKit

class ParterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var partnerLgo: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var headLineLabel: UILabel!
    
    var scrollTimer: Timer?
    var currentIndex = 0
    var partnerData = [PartnerViewModels]() {
        didSet {
            collectionView.reloadData()
            if !partnerData.isEmpty {
                updateTitle(for: 0)
            }
        }
    }
    
    @IBOutlet weak var viewDetailButton: UIButton!
    
    
    var onClickViewAll: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: FontManager.font(weight: .semiBold, size: 15)
        ]
        let attributedTitle = NSAttributedString(string: "View All", attributes: attributes)
        viewDetailButton.setAttributedTitle(attributedTitle, for: .normal)
        
        
        titleLabel.setStyledTextWithLastWordColor(fullText: "Our Partners", lastWordColor: .blueColor)
        headLineLabel.font = FontManager.font(weight: .semiBold, size: 18)
        headLineLabel.textColor = .blueColor
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "PartnerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PartnerCollectionViewCell")
        startAutoScroll()
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
    
    func updateTitle(for index: Int) {
        guard index >= 0, index < partnerData.count else { return }
        headLineLabel.text = partnerData[index].title
    }
    
    
    func startAutoScroll() {
        scrollTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollToNextItem), userInfo: nil, repeats: true)
    }

    @objc func scrollToNextItem() {
        let itemCount = collectionView.numberOfItems(inSection: 0)
        if itemCount == 0 { return }

        currentIndex = (currentIndex + 1) % itemCount
        let indexPath = IndexPath(item: currentIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        updateTitle(for: currentIndex)
    }
    
    @IBAction func viewAllAction(_ sender: Any) {
        onClickViewAll?()
    }
}



extension ParterTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return partnerData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PartnerCollectionViewCell", for: indexPath) as? PartnerCollectionViewCell else {
            return UICollectionViewCell()
        }
        let image = partnerData[indexPath.row].logos.first
        if let urlString = image , let photoUrl = URL(string: urlString) {
            cell.partnerImageView.kf.setImage(with: photoUrl, placeholder: UIImage(named: ""))
        } else {
            cell.partnerImageView.image = UIImage(named: "")
        }
        
       return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateCurrentIndexAndTitle()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            updateCurrentIndexAndTitle()
        }
    }
    
    
    private func updateCurrentIndexAndTitle() {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)

        if let indexPath = collectionView.indexPathForItem(at: visiblePoint) {
            currentIndex = indexPath.item
            updateTitle(for: currentIndex)
        }
    }


}
