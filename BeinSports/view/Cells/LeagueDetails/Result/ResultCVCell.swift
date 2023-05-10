//  BeinSports
//
//  Created by mo_fathy on 01/05/2023.
//

import UIKit
import SwiftUI

class ResultCVCell: UICollectionViewCell {

    @IBOutlet weak var stack: UIStackView!
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var homeNameLab: UILabel!
    @IBOutlet weak var awayNameLab: UILabel!
    @IBOutlet weak var awayImage: UIImageView!
    
    @IBOutlet weak var view: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 20

        view.layer.borderWidth = 1.5
   
        
        // Initialization code
    }

}
