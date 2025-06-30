//
//  CustomProtocol.swift
//  EventApp
//
//  Created by MultiTV on 20/02/25.
//

import Foundation
import UIKit

protocol CameraViewControllerDelegate: AnyObject {
    func didCaptureImage(_ image: UIImage)
}

protocol DidClickButtonDelegate: AnyObject {
    func didclickNote(index: Int)
    func didClickPdf(index:Int)
}


protocol MyCollectionViewCellDelegate: AnyObject {
   // func didSelectCell(_ cell: WidgetsCollectionViewCell, indexPath: IndexPath)
}


protocol MyBannerViewCellDelegate: AnyObject {
   // func didSelectCell(_ cell: BannerCollectionViewCell, indexPath: IndexPath)
}


protocol FilterSelectionDelegate: AnyObject {
    func didUpdateSelectedTags(_ tags: [AgandaFilter])
}


protocol HomeSessionTableViewCellDelegate: AnyObject {
    func homeSessionCellDidUpdateHeight()
}


protocol MenuSelectionDelegate: AnyObject {
    func didSelectMenuItem(_ item: String)
}
