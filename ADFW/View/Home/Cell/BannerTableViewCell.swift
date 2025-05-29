////
////  BannerTableViewCell.swift
////  MSVC'25 APP
////
////  Created by MultiTV on 11/03/25.
////

import UIKit

// MARK: - BannerDatum
struct BannerData: Codable {
    let id: Int?
    let image: String?
    let orderIndex, status: Int?
    let createdAt: String?
    let title:String?
    let slug: String?

    enum CodingKeys: String, CodingKey {
        case id, image, title
        case orderIndex = "order_index"
        case status
        case slug
        case createdAt = "created_at"
    }
}

class BannerTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    weak var delegate: MyBannerViewCellDelegate?
    
    let images = ["WELCOME TO", "", ""]
    var currentIndex = 0
    var timer: Timer?
    var banner:[BannerData]?{
        didSet {
            pageControl.numberOfPages = banner?.count ?? 0
                        pageControl.currentPage = 0
                        currentIndex = 0
            collectionView.reloadData()
            
            
        }
    }
    
    @IBOutlet weak var progressView: UIProgressView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
                collectionView.delegate = self
                collectionView.register(UINib(nibName: "BannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BannerCollectionViewCell")
       // startAutoScroll()
        
       
        
        
    }
    
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    deinit {
           stopAutoScroll()
       }
       
    func startAutoScroll() {
        stopAutoScroll() // clean up old timer
        let delay = isVideo(at: currentIndex) ? 8.0 : 3.0
        timer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(scrollToNextItem), userInfo: nil, repeats: false)
    }

       
       func stopAutoScroll() {
           timer?.invalidate()
           timer = nil
       }
       
    @objc func scrollToNextItem() {
        guard let banner = self.banner else { return }
        
        if currentIndex < banner.count - 1 {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
        
        let indexPath = IndexPath(item: currentIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage = currentIndex
        
        // 🛑 Restart auto-scroll with updated delay
        stopAutoScroll()
        
        let isCurrentVideo = isVideo(at: currentIndex)
        let delay = isCurrentVideo ? 8.0 : 3.0 // longer delay for videos
        
        timer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(scrollToNextItem), userInfo: nil, repeats: false)
    }

    
    func isVideo(at index: Int) -> Bool {
        guard let banner = self.banner,
              let urlString = banner[index].image,
              let url = URL(string: urlString) else { return false }

        let ext = url.pathExtension.lowercased()
        return ext == "mp4" || ext == "mov"
    }

    
}

extension BannerTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // return banner?.count ?? 0
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as! BannerCollectionViewCell
        
       
       
        
//        if let title = banner?[indexPath.row].title {
//            // Split into words
//            let components = title.components(separatedBy: " ")
//
//            if components.count >= 3 {
//                let normalText = components.dropLast().joined(separator: " ") + "\n"
//                let boldText = components.last ?? ""
//
//                let fullText = normalText + boldText
//                let attributedString = NSMutableAttributedString(string: fullText)
//
//                // Apply normal style to "Welcome to"
//                attributedString.addAttribute(.font, value: FontManager.font(weight: .regular, size: 20), range: NSRange(location: 0, length: normalText.count))
//
//                // Apply bold + bigger font to "MSVC"
//                attributedString.addAttribute(.font, value: FontManager.font(weight: .medium, size: 30), range: NSRange(location: normalText.count, length: boldText.count))
//
//                cell.imageLabel.numberOfLines = 0
//                cell.imageLabel.attributedText = attributedString
//            } else {
//                // Fallback if unexpected format
//                cell.imageLabel.text = title
//            }
//        }
//        cell.imageLabel.text = banner?[indexPath.row].title 
//       
//        
//        
//        if let banner = self.banner, let urlString = banner[indexPath.row].image, let url = URL(string: urlString) {
//               let fileExtension = url.pathExtension.lowercased()
//
//               if fileExtension == "mp4" || fileExtension == "mov" {
//                   cell.configureWithVideo(url: url)
//                   cell.imageLabel.text = ""
//                 
//               } else {
//                   cell.configureWithImage(url: url)
//               }
//           } else {
//               cell.setFallbackImage()
//           }
//       //
        
        cell.imageView.image = UIImage.adfwBg1

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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? BannerCollectionViewCell {
            //delegate?.didSelectCell(cell, indexPath: indexPath)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = page
        currentIndex = page
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = page
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let bannerCell = cell as? BannerCollectionViewCell {
            bannerCell.stopVideo()
        }
    }

    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        guard let banner = banner,
//              let urlString = banner[indexPath.row].image,
//              let url = URL(string: urlString),
//              url.pathExtension.lowercased() == "mp4" || url.pathExtension.lowercased() == "mov",
//              let videoCell = cell as? BannerCollectionViewCell
//        else { return }
//
//        videoCell.configureWithVideo(url: url)
//        
//        // Delay play slightly to ensure cell is settled
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//            videoCell.playVideo()
//        }
//    }

}


extension BannerTableViewCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let contentWidth = scrollView.contentSize.width - scrollView.bounds.width

        guard contentWidth > 0 else {
            progressView.setProgress(1.0, animated: false)
            return
        }

        let progress = Float(offsetX / contentWidth)
        progressView.setProgress(progress, animated: true)
    }
}
