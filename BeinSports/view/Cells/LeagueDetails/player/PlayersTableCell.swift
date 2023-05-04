//
//  PlayersTableCell.swift
//  BeinSports
//
//  Created by mo_fathy on 04/05/2023.
//

import UIKit

class PlayersTableCell: UITableViewCell {

    @IBOutlet weak var namePlayer: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var numberPlayer: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
