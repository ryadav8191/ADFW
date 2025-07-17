//
//  HomeSessionTableViewCell.swift
//  ADFW
//
//  Created by MultiTV on 27/05/25.
//

import UIKit
import CollectionViewPagingLayout
import CHIPageControl

enum SelectedCell {
    case session
    case event
    
}



class HomeSessionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var upComingSessLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewAllButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var bgColor: UIImageView!
    @IBOutlet weak var pageControlSquare: CHIPageControlJaloro!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var verticalView: UIView!
    
    
    @IBOutlet weak var viewAll: UIButton!
    
    private var items: [UpcomingSessionsData] = []
    var featuredEvent = [FeaturedEventData]()
    var selectedCell: SelectedCell = .event
    weak var delegate: HomeSessionTableViewCellDelegate?
    
    var onClickViewAll: (() -> Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        selectionStyle = .none
        setupCustomPageControl()
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = .zero
        }
    }
    
    
    func configure(with items: [UpcomingSessionsData], type: SelectedCell) {
        self.items = items
        self.selectedCell = type
        bgColor.isHidden = selectedCell == .event ? false : true
        
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: FontManager.font(weight: .semiBold, size: 15)
        ]
        let attributedTitle = NSAttributedString(string: "View All", attributes: attributes)
        viewAll.setAttributedTitle(attributedTitle, for: .normal)
        
        setupCollectionView()
        updateLayoutForSelectedCell()
        collectionView.reloadData()
    }
    
    
    func configureFeatureEvent(data: [FeaturedEventData]) {
        
        self.featuredEvent = data
        collectionView.reloadData()
    }
    
    private func updateLayoutForSelectedCell() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = (selectedCell == .session) ? .horizontal : .vertical
        }
        
        collectionView.isScrollEnabled = (selectedCell == .session)
        switch selectedCell {
        case .session:
            upComingSessLabel.setStyledTextWithLastWordColor(fullText: "Upcoming Sessions", lastWordColor: .blueColor)
            // upComingSessLabel.textColor = .black
            viewAllButton.tintColor = .blueColor
            verticalView.backgroundColor = .blueColor
            pageControlSquare.isHidden = false
        case .event:
            upComingSessLabel.setStyledTextWithLastWordColor(fullText: "Featured Events", lastWordColor: .white)
            upComingSessLabel.textColor = .white
            viewAllButton.tintColor = .white
            verticalView.backgroundColor = .white
            pageControlSquare.isHidden = true
        }
    }
    
    private func setupCollectionView() {
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        
        collectionView.register(UINib(nibName: "HomeSessionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeSessionCollectionViewCell")
        collectionView.register(UINib(nibName: "FeatureEventCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeatureEventCollectionViewCell")
        
        if selectedCell == .event {
            let layout = CenterLastRowFlowLayout()
            //layout.minimumLineSpacing = 10
            // layout.minimumInteritemSpacing = 10
            collectionView.setCollectionViewLayout(layout, animated: false)
        } else {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            collectionView.setCollectionViewLayout(layout, animated: false)
        }
        
        
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard selectedCell == .event else {
            collectionViewHeightConstraint.constant = 275
            return
        }
        
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.layoutIfNeeded()
        
        let newHeight = collectionView.collectionViewLayout.collectionViewContentSize.height
        if collectionViewHeightConstraint.constant != newHeight {
            collectionViewHeightConstraint.constant = newHeight
            delegate?.homeSessionCellDidUpdateHeight()
        }
    }
    
    
    private func setupCustomPageControl() {
        pageControlSquare.numberOfPages = 5
        pageControlSquare.radius = 0
        pageControlSquare.padding = 6
        pageControlSquare.tintColor = UIColor.systemBlue.withAlphaComponent(0.3)
        pageControlSquare.currentPageTintColor = UIColor.blueColor
        pageControlSquare.elementWidth = 7
        pageControlSquare.elementHeight = 7
    }
    
    
    @IBAction func viewAllAction(_ sender: Any) {
        onClickViewAll?()
    }
    
    
}


extension HomeSessionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  selectedCell == .event ? featuredEvent.count :  items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch selectedCell {
        case .session:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeSessionCollectionViewCell", for: indexPath) as? HomeSessionCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(with: items[indexPath.row].attributes)
            
            
            return cell
        case .event:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureEventCollectionViewCell", for: indexPath) as? FeatureEventCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configireUI(image: featuredEvent[indexPath.row].attributes?.image4)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch selectedCell {
        case .session:
            return CGSize(width: collectionView.frame.width, height: 250)
            
        case .event:
            let itemsPerRow: CGFloat = 3
            let spacing: CGFloat = 10
            
            let totalSpacing = (itemsPerRow - 1) * spacing
            let availableWidth = collectionView.bounds.width - totalSpacing
            let itemWidth = floor(availableWidth / itemsPerRow)
            
            return CGSize(width: itemWidth, height: 90)
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        guard selectedCell == .event else {
            return .zero
        }
        
        let itemsPerRow: CGFloat = 3
        let spacing: CGFloat = 10
        let numberOfItems = collectionView.numberOfItems(inSection: section)
        
        if numberOfItems >= Int(itemsPerRow) {
            return .zero
        }
        
        // Calculate item width as done in sizeForItemAt
        let totalSpacing = CGFloat(numberOfItems - 1) * spacing
        let availableWidth = collectionView.bounds.width - ((itemsPerRow - 1) * spacing)
        let itemWidth = floor(availableWidth / itemsPerRow)
        
        let totalItemWidth = CGFloat(numberOfItems) * itemWidth + totalSpacing
        let inset = max((collectionView.bounds.width - totalItemWidth) / 2, 0)
        
        return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width + 0.5)
        pageControlSquare.set(progress: page, animated: true)
    }
}


class CenterLastRowFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect)?.map({ $0.copy() as! UICollectionViewLayoutAttributes }) else {
            return nil
        }
        
        // Group attributes by their row (based on Y position)
        var rows: [[UICollectionViewLayoutAttributes]] = []
        var currentRow: [UICollectionViewLayoutAttributes] = []
        var currentY: CGFloat = -1
        
        for attr in attributes where attr.representedElementCategory == .cell {
            if abs(attr.frame.origin.y - currentY) > 1 {
                if !currentRow.isEmpty {
                    rows.append(currentRow)
                    currentRow = []
                }
                currentY = attr.frame.origin.y
            }
            currentRow.append(attr)
        }
        if !currentRow.isEmpty {
            rows.append(currentRow)
        }
        
        // Center only the last row
        if let lastRow = rows.last {
            let totalWidth = lastRow.reduce(0) { $0 + $1.frame.width } +
            minimumInteritemSpacing * CGFloat(max(0, lastRow.count - 1))
            let inset = (collectionView!.bounds.width - totalWidth) / 2
            
            var x = inset
            for attr in lastRow {
                var frame = attr.frame
                frame.origin.x = x
                attr.frame = frame
                x += frame.width + minimumInteritemSpacing
            }
        }
        
        return attributes
    }
}



