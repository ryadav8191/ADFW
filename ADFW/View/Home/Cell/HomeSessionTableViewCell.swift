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
    
    

    private var items: [UpcomingSessionsData] = []
    var selectedCell: SelectedCell = .session
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
     
        updateLayoutForSelectedCell()
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
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }

        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        guard selectedCell == .event else { return }

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
        return items.count
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
            
            
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch selectedCell {
        case .session:
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)

        case .event:
          
//            let spacing: CGFloat = 12
//            let insets: CGFloat = 8 * 2
//            let totalSpacing = spacing * 2 + insets
            let width = (collectionView.bounds.width) / 3
            print("+=++++=+++================================",width)
            return CGSize(width: width, height: width)

        }
    }
    

//    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width + 0.5)
        pageControlSquare.set(progress: page, animated: true)
    }
}
