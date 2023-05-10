//  BeinSports
//
//  Created by mo_fathy on 01/05/2023.
//
import UIKit
import SwiftUI
import Lottie

class CustomTableCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    
   
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!

    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgView.layer.cornerRadius = imgView.frame.height/2
        
    
        view.layer.cornerRadius = 20
        view.layer.borderColor = Color.accentColor.cgColor
        view.layer.borderWidth = 2
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
   
}
