//
//  ALCurrencyCell.swift
//  ALCurrencyConverter
//
//  Created by ALLENMAC on 2017/8/24.
//  Copyright © 2017年 ALLENMAC. All rights reserved.
//

import UIKit

class ALCurrencyCell: UITableViewCell {
    
    // MARK: Definitions
    
    @IBOutlet weak var leftBackgroundView: UIView!
    @IBOutlet weak var rightBackgroundView: UIView!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.leftLabel.textColor = selected ? UIColor.black : UIColor.white
        self.rightLabel.textColor = selected ? UIColor.black : UIColor.white
        // Configure the view for the selected state
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        self.leftLabel.textColor = highlighted ? UIColor.black : UIColor.white
        self.rightLabel.textColor = highlighted ? UIColor.black : UIColor.white
    }

}
