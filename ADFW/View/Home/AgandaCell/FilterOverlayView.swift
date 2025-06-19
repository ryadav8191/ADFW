//
//  FilterOverlayView.swift
//  ADFW
//
//  Created by MultiTV on 21/05/25.
//

import UIKit


class FilterOverlayView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private let dimmedView = UIView()
    private let cardView = UIView()
    private var collectionView: UICollectionView!

     var tags = [AgandaFilterData]()
    
    var selectedTags = Set<String>()  // Use Set for fast lookup
    weak var delegate: FilterSelectionDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        dimmedView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dimmedView)

        NSLayoutConstraint.activate([
            dimmedView.topAnchor.constraint(equalTo: topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 8
        cardView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cardView)

        NSLayoutConstraint.activate([
            cardView.centerYAnchor.constraint(equalTo: centerYAnchor),
            cardView.centerXAnchor.constraint(equalTo: centerXAnchor),
            cardView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9), // 90% of screen width
            cardView.heightAnchor.constraint(equalToConstant: 350)
        ])

        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 12
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TagCell.self, forCellWithReuseIdentifier: TagCell.identifier)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            collectionView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16),
            collectionView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissOverlay))
               dimmedView.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissOverlay() {
        delegate?.didUpdateSelectedTags(Array(selectedTags))
        self.removeFromSuperview()
    }

    // MARK: - CollectionView

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.identifier, for: indexPath) as! TagCell
        let tag = tags[indexPath.item].attributes?.title ?? ""
           let isSelected = selectedTags.contains(tag)
        cell.configure(title: tag, isSelected: isSelected)
           return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = tags[indexPath.item].attributes?.title ?? ""
        let font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        let textSize = (text as NSString).size(withAttributes: [.font: font])
        let width = textSize.width + 10 + 8 + 24 + 0 // dot + space + padding
        return CGSize(width: width, height: 34)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tag = tags[indexPath.item].attributes?.title ?? ""

        if selectedTags.contains(tag) {
            selectedTags.remove(tag)
        } else {
            selectedTags.insert(tag)
        }

        UIView.performWithoutAnimation {
            collectionView.reloadItems(at: [indexPath])
        }
        
        delegate?.didUpdateSelectedTags(Array(selectedTags))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.removeFromSuperview()
        }
    }


}

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        return attributes
    }
}
