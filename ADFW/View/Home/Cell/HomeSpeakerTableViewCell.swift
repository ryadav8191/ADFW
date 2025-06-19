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
    
    
    var arrayOfSpeaker = [SpeakerData]() {
        didSet {
            collectionview.reloadData()
        }
    }
    
    
    
    var onClickViewAll: (() -> Void)?
    weak var delegate: HomeSessionTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
        selectionStyle = .none
        
      

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
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
        return arrayOfSpeaker.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpeackerCollectionViewCell", for: indexPath) as! SpeackerCollectionViewCell
        
        let speaker = arrayOfSpeaker[indexPath.row].attributes
        
        cell.desigationLabel.text =  speaker?.designation
        cell.nameLabel.text = (speaker?.firstName ?? "") + " " + (speaker?.lastName ?? "")
        cell.speakerImageView.image = nil
        if let urlString = speaker?.photoUrl, let url = URL(string: urlString) {
            cell.speakerImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "placeholder"),
                options: [
                    .transition(.fade(0.2)),
                    .cacheOriginalImage
                ]
            )
        } else {
            cell.speakerImageView.image = UIImage(named: "")
        }
        let agendaColors = getAgendaColors(for: speaker)
           cell.tagView.colors = agendaColors

        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let aspectRatio: CGFloat = 4 / 3  // Height is more than width
            let totalWidth = collectionView.frame.size.width
            let interItemSpacing: CGFloat = 8
            let numberOfItemsPerRow: CGFloat = 3
            let totalSpacing = (numberOfItemsPerRow - 1) * interItemSpacing
            let availableWidth = totalWidth - totalSpacing
            let itemWidth = availableWidth / numberOfItemsPerRow
            let itemHeight = itemWidth * aspectRatio  // Taller than wide
            return CGSize(width: 170, height: 250)
    }

    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }

   
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let story = UIStoryboard(name: "Main", bundle: nil)
//        let vc = story.instantiateViewController(identifier: "SpeackerDetailViewController") as! SpeackerDetailViewController
//        vc.profile = arrayOfSpeaker[indexPath.row].attributes
//
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //https://api-prod.adfw.com/api/agenda/byDate?isSessionFilter=true&date=2024-12-10

    
    func getAgendaColors(for speaker: Speakers?) -> [String] {
        var colors: [String] = []

        guard let sessions = speaker?.agenda_sessions?.data else { return [] }

        for session in sessions {
            if let color = session.attributes?.agenda?.data?.attributes?.color {
                if !colors.contains(color) {
                    colors.append(color)
                }
            }
        }
        return colors
    }
    
    
}

