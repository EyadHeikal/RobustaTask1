//
//  EmptyCell.swift
//  RobustaTask
//
//  Created by Eyad Heikal on 4/24/21.
//

import UIKit

class EmptyCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
