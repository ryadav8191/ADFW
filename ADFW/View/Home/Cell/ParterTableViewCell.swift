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

    
    var onClickViewAll: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
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
        // Example: update with dynamic content
        headLineLabel.text = "Partner \(index + 1)" // Or any dynamic logic
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PartnerCollectionViewCell", for: indexPath) as? PartnerCollectionViewCell else {
            return UICollectionViewCell()
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
