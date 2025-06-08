//
//  AgandaViewController.swift
//  ADFW
//
//  Created by MultiTV on 16/05/25.
//

import UIKit




class AgandaViewController: UIViewController {
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationView: UIView!
    
    weak var delegate: FilterSelectionDelegate?

    let dates = ["Full Week", "09 DEC", "10 DEC", "11 DEC", "12 DEC"]
    var selectedIndex = 0
  
    let sampleAgenda: [AgendaSection] = [
        AgendaSection(
            date: "09 December 2024",
            bannerImage: UIImage.eventBanner, year: "2025",
            sessions: [
                AgendaSession(
                    time: "9:30 - 10:30",
                    title: "The Keys To Managing Money & Risk: In Conversation with Alan Howard",
                    type: "Panel" ,
                    location: " Alan Howard eys To Managing Money & Risk: In Conve",
                    tags: ["D", "M", "2"],
                    speakers: [
                        Speaker(name: "Speaker 1", image: UIImage.person1),
                        Speaker(name: "Speaker 2", image: UIImage.person2),
                        Speaker(name: "Speaker 2", image: UIImage.person2),
                        Speaker(name: "Speaker 2", image: UIImage.person2), Speaker(name: "Speaker 2", image: UIImage.person2), Speaker(name: "Speaker 2", image: UIImage.person2), Speaker(name: "Speaker 2", image: UIImage.person2),
                        Speaker(name: "Speaker 2", image: UIImage.person2),
                        Speaker(name: "Speaker 2", image: UIImage.person2),
                        Speaker(name: "Speaker 5", image: UIImage.person3), Speaker(name: "Speaker 5", image: UIImage.person3), Speaker(name: "Speaker 5", image: UIImage.person3), Speaker(name: "Speaker 5", image: UIImage.person3)
                    ]
                ),
                AgendaSession(
                    time: "9:30 - 10:30",
                    title: "The Keys To Managing Money & Risk: In Conversation with Alan Howard",
                    type: "Panel",
                    location: "ADFW Arena",
                    tags: ["D", "M", "2"],
                    speakers: [
                        Speaker(name: "Speaker 1", image: UIImage.person1),
                        Speaker(name: "Speaker 2", image: UIImage.person2),
                        Speaker(name: "Speaker 3", image: UIImage.person3),
                        Speaker(name: "Speaker 4", image: UIImage.person1),
                        Speaker(name: "Speaker 5", image: UIImage.person3)
                    ]
                )
            ]
        ),
        AgendaSection(
            date: "10 December 2024",
            bannerImage: UIImage.loginBackground, year: "2025",
            sessions: [
                AgendaSession(
                    time: "9:30 - 10:30",
                    title: "The Keys To Managing Money & Risk: In Conversation with Alan Howard",
                    type: "Panel",
                    location: "ADFW Arena",
                    tags: [],
                    speakers: [
                        Speaker(name: "Speaker 1", image: UIImage(named: "speaker1")),
                        Speaker(name: "Speaker 2", image: UIImage(named: "speaker2"))
                    ]
                ),
                AgendaSession(
                    time: "9:30 - 10:30",
                    title: "The Keys To Managing Money & Risk: In Conversation with Alan Howard",
                    type: "Panel",
                    location: "ADFW Arena",
                    tags: [],
                    speakers: [
                        Speaker(name: "Speaker 1", image: UIImage(named: "speaker1")),
                        Speaker(name: "Speaker 2", image: UIImage(named: "speaker2"))
                    ]
                ),
                AgendaSession(
                    time: "9:30 - 10:30",
                    title: "The Keys To Managing Money & Risk: In Conversation with Alan Howard",
                    type: "Panel",
                    location: "ADFW Arena",
                    tags: [],
                    speakers: [
                        Speaker(name: "Speaker 1", image: UIImage(named: "speaker1")),
                        Speaker(name: "Speaker 2", image: UIImage(named: "speaker2"))
                    ]
                )

                
            ]
        ),
        
    ]

    

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource  = self
        tableView.dataSource = self
        tableView.delegate = self
        self.navigationController?.navigationBar.isHidden = true
        self.delegate = self
        registerCell()
        configureUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
    }

    
    func registerCell() {
        collectionView.register(UINib(nibName: "DateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DateCollectionViewCell")
    
        tableView.register(UINib(nibName: "AgendaTableViewCell", bundle: nil), forCellReuseIdentifier: "AgendaTableViewCell")
        
        tableView.register(UINib(nibName: "MajorEventTableViewCell", bundle: nil), forCellReuseIdentifier: "MajorEventTableViewCell")
        let nib = UINib(nibName: "AgendaHeaderView", bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: "AgendaHeaderView")

    }
    
    func configureUI() {
        let fullText = "Event Agenda"
        let attributedString = NSMutableAttributedString(string: fullText)

        // Split text into words
        let words = fullText.components(separatedBy: " ")

        if words.count == 2,
           let firstRange = fullText.range(of: words[0]),
           let secondRange = fullText.range(of: words[1]) {

            let nsFirst = NSRange(firstRange, in: fullText)
            let nsSecond = NSRange(secondRange, in: fullText)

            // Style for "Event"
            attributedString.addAttributes([
                .font: FontManager.font(weight: .semiBold, size: 19),
                .foregroundColor: UIColor.black
            ], range: nsFirst)

            // Style for "Agenda"
            attributedString.addAttributes([
                .font: FontManager.font(weight: .bold, size: 19),
                .foregroundColor: UIColor.blueColor
            ], range: nsSecond)
        }

        pageTitle.attributedText = attributedString

        searchBarView.layer.borderColor = UIColor(hex: "#A3A6A7").cgColor
        searchBarView.layer.borderWidth = 1
        navigationView.layer.shadowColor = UIColor(hex: "#0000000D").cgColor
        navigationView.layer.shadowOpacity = 0.25
        navigationView.layer.shadowOffset = CGSize(width: 0, height: 3) // bottom only
        navigationView.layer.shadowRadius = 1
        navigationView.layer.masksToBounds = false
        
    }
    
    
    
    @IBAction func favoriteAction(_ sender: Any) {
        
    }
    
    
    @IBAction func filterAction(_ sender: Any) {
        let overlay = FilterOverlayView(frame: view.bounds)
           overlay.alpha = 0
        overlay.delegate = self
           view.addSubview(overlay)

           UIView.animate(withDuration: 0.3) {
               overlay.alpha = 1
           }
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0
    }
    

}

extension AgandaViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return dates.count
       }

       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCollectionViewCell", for: indexPath) as! DateCollectionViewCell
           let isSelected = indexPath.item == selectedIndex
           cell.configure(with: dates[indexPath.item], isSelected: isSelected)
           return cell
       }

       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           selectedIndex = indexPath.item
           collectionView.reloadData()
           // Update agenda table based on selected date
       }
    
    
    
    
}


extension AgandaViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 40)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8) // Adjust spacing as needed
       }
}



extension AgandaViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sampleAgenda.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return sampleAgenda[section].sessions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = sampleAgenda[indexPath.section].sessions[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "AgendaTableViewCell", for: indexPath) as! AgendaTableViewCell
        cell.onPlayVideo = { [weak self] in
               guard let self = self else { return }

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let videoVC = storyboard.instantiateViewController(withIdentifier: "VideoPlayerViewController") as? VideoPlayerViewController {
                videoVC.videoURL = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
                videoVC.modalPresentationStyle = .fullScreen
                self.present(videoVC, animated: true)
            }
           }
        cell.configure(with: item)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "AgendaHeaderView") as? AgendaHeaderView else {
            return nil
        }

        let sectionData = sampleAgenda[section] // Assuming section contains the date info
        header.configure(dateText: sectionData.date, yearText: sectionData.year, bannerImage:sectionData.bannerImage, hide: true)

        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150 // Adjust based on your XIB design
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SessionViewController") as? SessionViewController {
            navigationController?.pushViewController(vc, animated: true)
        }

    }
}


extension AgandaViewController: FilterSelectionDelegate {
    func didUpdateSelectedTags(_ tags: [String]) {
        print("Selected Tags:", tags)
       
    }
}
