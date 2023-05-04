//  BeinSports
//
//  Created by mo_fathy on 01/05/2023.
//

import UIKit
import SwiftUI

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var sportsImageView: UIImageView!
    
    @IBOutlet weak var sportName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 20
        self.layer.borderColor = Color.accentColor.cgColor
        self.layer.borderWidth = 2
    }

}
