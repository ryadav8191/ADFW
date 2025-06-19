//
//  EventOveviewViewController.swift
//  ADFW
//
//  Created by MultiTV on 19/06/25.
//

import UIKit

class EventOveviewViewController: UIViewController {
    
    @IBOutlet weak var bannerImageView: ScaledHeightImageView!
    @IBOutlet weak var agandaImageView: ScaledHeightImageView!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var viewAganda: UIButton!
    @IBOutlet weak var viewSpeaker: UIButton!
    @IBOutlet weak var pageTitle: UILabel!
    
    var data: Agendas?
    
    var selectedIndex = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
       
    }
    

    func configureData () {
        
        if let urlString = data?.agendaMobileBanner, let url = URL(string: urlString) {
            bannerImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        } else {
            
        }
        
        
        if let urlString = data?.image3, let url = URL(string: urlString) {
            agandaImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        } else {
            
        }
        
        desc.text = data?.description
        
        setButtonTitle(viewAganda, title: "VIEW AGANDA")
        setButtonTitle(viewSpeaker, title: "VIEW SPEAKERS")
        
        viewAganda.tintColor = UIColor.white
        viewAganda.backgroundColor = UIColor(hex: data?.color ?? "")
        viewSpeaker.tintColor = UIColor(hex: data?.color ?? "")
    
    
        viewSpeaker.layer.borderColor = UIColor(hex: data?.color ?? "").cgColor
        viewSpeaker.layer.borderWidth = 1
        
        desc.font = FontManager.font(weight: .medium, size: 14)
        desc.textColor = UIColor.lightBlue
        
        pageTitle.setStyledTextWithLastWordColor(fullText: "Event Overview", lastWordColor: .blueColor,fontSize: 19)
    }
   

    
    func setButtonTitle(_ button: UIButton, title: String) {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: FontManager.font(weight: .semiBold, size: 10)
        ]
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.setAttributedTitle(attributedTitle, for: .selected)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func viewAgandaAction(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "AgandaViewController") as? AgandaViewController {
            vc.id = data?.id
            vc.date = data?.date
            vc.selectedIndex = selectedIndex
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    @IBAction func viewSpeakerAction(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SpeakerViewController") as? SpeakerViewController {
            
            vc.agendaPermaLink = data?.permaLink
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        
        
    }
    
    
    
}
