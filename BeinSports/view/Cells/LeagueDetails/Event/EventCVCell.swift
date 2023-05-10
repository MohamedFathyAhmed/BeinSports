//  BeinSports
//
//  Created by mo_fathy on 01/05/2023.
//
import UIKit
import SwiftUI

class EventCVCell: UICollectionViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var awayImageE: UIImageView!
    @IBOutlet weak var nameAwayLab: UILabel!
    @IBOutlet weak var nameHomeLab: UILabel!
    @IBOutlet weak var homeImageE: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1.5
   
        switch traitCollection.userInterfaceStyle{
        case .dark:
            view.layer.borderColor = Color.white.cgColor
        default:
            view.layer.borderColor = Color.black.cgColor
        }

//        awayImageE.layer.cornerRadius = awayImageE.frame.height/2
//        homeImageE.layer.cornerRadius = homeImageE.frame.height/2
//        homeImageE.layer.borderColor = Color.accentColor.cgColor
//        awayImageE.layer.borderColor = Color.accentColor.cgColor
//        homeImageE.layer.borderWidth = 1.5
//        awayImageE.layer.borderWidth = 1.5
        // Initialization code
 //       contentView.layer.cornerRadius = 20
 //       contentView.layer.borderColor = Color.accentColor.cgColor
  //      contentView.layer.borderWidth = 2
    }

}
