//
//  SpeackerDetailViewController.swift
//  ADFW
//
//  Created by MultiTV on 22/05/25.
//







import UIKit
import WebKit
import Kingfisher

class SpeackerDetailViewController: UIViewController {

    var profile: Speakers?
    var onClose: (() -> Void)?

    private let scrollView = UIScrollView()
    private let contentView = UIStackView()

    private let closeButton = UIButton(type: .system)
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let designationLabel = UILabel()
    private let bioWebView = WKWebView()

    private let tagsCollectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayouts()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    private var tags: [(title: String, color: UIColor)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        configureData()
    }
    
   

    private func setupViews() {
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.axis = .vertical
        contentView.spacing = 16
        contentView.alignment = .fill

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        // Close Button
        closeButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        closeButton.tintColor = .gray
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        let closeContainer = UIView()
        closeContainer.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.trailingAnchor.constraint(equalTo: closeContainer.trailingAnchor),
            closeButton.topAnchor.constraint(equalTo: closeContainer.topAnchor),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeContainer.heightAnchor.constraint(equalToConstant: 30)
        ])
        contentView.addArrangedSubview(closeContainer)

        // Profile Image + Info
        let profileStack = UIStackView()
        profileStack.axis = .horizontal
        profileStack.spacing = 12
        profileStack.alignment = .center

        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 0
        profileImageView.contentMode = .scaleAspectFill
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 105),
            profileImageView.heightAnchor.constraint(equalToConstant: 115)
        ])

        let textStack = UIStackView()
        textStack.axis = .vertical
        textStack.spacing = 4

        nameLabel.font = FontManager.font(weight: .semiBold, size: 18)
        nameLabel.textColor = .lightBlue
        nameLabel.numberOfLines = 0

        designationLabel.font = FontManager.font(weight: .regular, size: 12)
        designationLabel.textColor = UIColor(hex: "#555555")
        designationLabel.numberOfLines = 0

        textStack.addArrangedSubview(nameLabel)
        textStack.addArrangedSubview(designationLabel)

        profileStack.addArrangedSubview(profileImageView)
        profileStack.addArrangedSubview(textStack)

        contentView.addArrangedSubview(profileStack)

        // Bio Web View
        bioWebView.navigationDelegate = self
        bioWebView.scrollView.isScrollEnabled = false
        contentView.addArrangedSubview(bioWebView)

        // Tags Collection View
        tagsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        tagsCollectionView.delegate = self
        tagsCollectionView.dataSource = self
        tagsCollectionView.register(TagSecCell.self, forCellWithReuseIdentifier: TagSecCell.identifier)
        tagsCollectionView.backgroundColor = .clear
        contentView.addArrangedSubview(tagsCollectionView)
    }

    private func configureData() {
        if let urlStr = profile?.photoUrl, let url = URL(string: urlStr) {
            profileImageView.kf.setImage(with: url)
        }

        nameLabel.text = "\(profile?.firstName ?? "") \(profile?.lastName ?? "")"
        designationLabel.text = profile?.designation ?? ""

        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
        @font-face {
            font-family: 'IsidoraSans-Regular';
            src: local('IsidoraSans-Regular');
        }
        body {
            font-family: 'IsidoraSans-Regular', -apple-system, Helvetica, Arial, sans-serif;
            font-size: 12px;
            color: #555555;
            line-height: 1.5;
        }
        </style>
        </head>
        <body>
        \(profile?.bio ?? "")
        </body>
        </html>
        """
        bioWebView.loadHTMLString(html, baseURL: nil)


        // Tags data
        tags = getAgendaTags(for: profile)
        tagsCollectionView.reloadData()

        DispatchQueue.main.async {
            self.tagsCollectionView.collectionViewLayout.invalidateLayout()
            self.tagsCollectionView.layoutIfNeeded()
            self.tagsCollectionView.heightAnchor.constraint(equalToConstant: self.tagsCollectionView.contentSize.height).isActive = true
        }

    }

    @objc private func closeTapped() {
        self.navigationController?.popViewController(animated: false)
    }
}

extension SpeackerDetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.body.scrollHeight") { [weak self] (height, _) in
            if let height = height as? CGFloat {
                webView.heightAnchor.constraint(equalToConstant: height).isActive = true
                self?.view.setNeedsLayout()
                self?.view.layoutIfNeeded()
            }
        }
    }
}

extension SpeackerDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagSecCell.identifier, for: indexPath) as? TagSecCell else {
            return UICollectionViewCell()
        }
        let tag = tags[indexPath.item]
        cell.configure(with: tag.title, color: tag.color)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tag = tags[indexPath.item].title
        let font = UIFont.systemFont(ofSize: 14, weight: .medium) // Match actual font
        let size = (tag as NSString).size(withAttributes: [.font: font])
        return CGSize(width: size.width + 40, height: 32) // Optionally increase padding
    }
    
    
    
    func getAgendaTags(for speaker: Speakers?) -> [(String, UIColor)] {
        var tags: [(String, UIColor)] = []

        guard let sessions = speaker?.agenda_sessions?.data else { return [] }

        for session in sessions {
            if let agenda = session.attributes?.agenda?.data?.attributes,
               let permaLink = agenda.permaLink?.capitalized,
               let hexColor = agenda.color {

                // Avoid duplicates
                if !tags.contains(where: { $0.0 == permaLink }) {
                    tags.append((permaLink, UIColor(hex: hexColor)))
                }
            }
        }
        return tags
    }


}










class TagSecCell: UICollectionViewCell {
    static let identifier = "TagSecCell"

    private let tagLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor(named: "darkBlue") ?? .black
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let dotView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 7
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let containerView: UIView = {
        let view = UIView()
     //   view.layer.cornerRadius = 3
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(containerView)
        containerView.addSubview(dotView)
        containerView.addSubview(tagLabel)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            dotView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            dotView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            dotView.widthAnchor.constraint(equalToConstant: 15),
            dotView.heightAnchor.constraint(equalToConstant: 15),

            tagLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            tagLabel.leadingAnchor.constraint(equalTo: dotView.trailingAnchor, constant: 8),
            tagLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with text: String, color: UIColor) {
        tagLabel.text = text
        dotView.backgroundColor = color
        containerView.layer.borderColor = color.cgColor
    }
}


import UIKit

class LeftAlignedCollectionViewFlowLayouts: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        for layoutAttribute in attributes {
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }
        return attributes
    }
}
