//  BeinSports
//
//  Created by mo_fathy on 01/05/2023.
//

import UIKit
import SwiftUI
import Lottie

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var sportsImageView: UIImageView!
    
    @IBOutlet weak var animationLotte: AnimationView!
    @IBOutlet weak var sportName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 20
       self.layer.borderWidth = 2
        
        
        switch traitCollection.userInterfaceStyle{
        case .dark:
            self.layer.borderColor = Color.white.cgColor
        default:
            self.layer.borderColor = Color.black.cgColor
        }
        
    }
    
    

}
